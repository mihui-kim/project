<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberJoinForm</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
	
	/* 상단 */ 
	#container {width: 600px; margin: 0 auto;}
	.m_title {font-family: 'Fredoka One', cursive; font-size: 3em; text-align: center;}
	.m_title a {text-decoration: none; color: #6799FF;}
	.s_title {font-family: 'Jua', sans-serif; font-size: 2em; text-align: center; margin-bottom: 30px; color: gray;}
	input[type="text"], input[type="password"] {height: 19px;}
	
	/* 중단 */
	form span {font-family: 'Sunflower', sans-serif; font-size: 0.9em;}
	table {width: 100%; border-collapse: collapse; border: 1px solid #ccc;}
	tr {height: 65px;}
	th, td {border: 1px solid gray; padding-left: 5px;}
	th {background: #B2CCFF; color: white; width: 120px; font-family: 'Jua', sans-serif; font-size: 1.0em; font-weight: lighter;}
	.addr_row {height: 100px;}
	.addr_row input {margin: 2px 0;}
	#btn_chk_id {width: 110px; height: 30px; border: none; border-radius:3px; background: #FFBD6A; color: white; 
				margin-left: 10px; cursor: pointer; font-family: 'Noto Sans KR', sans-serif;}
	#btn_address {width: 110px; height: 30px; border: none; border-radius:3px; background: #FFBD6A; color: white; 
				cursor: pointer; font-family: 'Noto Sans KR', sans-serif;}
	
	/* 하단 */
	.btns {text-align: center; margin-top: 30px;}
	.btns input[type="button"] {width: 120px; height: 40px; border-radius: 10px; border: none; background: #6799FF; color: white; 
								cursor: pointer; font-family: 'Jua', sans-serif; font-size: 1.0em; font-weight: lighter;}
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 다음 주소 라이브러리 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

	//let isChk=false; //아이디중복체크 누르기 (전역변수)

	document.addEventListener("DOMContentLoaded", function() {
		let form=document.joinForm; 
		let id=form.id;
		let pwd=form.pwd;
		let pwd2=form.pwd2;
		let name=form.name;
		let email=form.email;
		let tel=form.tel;
		let address=form.address; 
		let address2=form.address2;
		
		
		
		//ID중복 체크 버튼 (DB작업)
		let btn_chk_id=document.getElementById("btn_chk_id");
		btn_chk_id.addEventListener("click", function() {
			if(id.value.length<4) {alert('아이디를 4글자 이상 입력해주세요.'); id.focus();}
			else {location='memberIdCheck.jsp?id='+id.value;}
		})
		
		//비밀번호 유효성 검사 (8글자 이상 입력되도록 조건 걸기)
		let chk_pwd=document.getElementById("chk_pwd");
		pwd.addEventListener("keyup", function() {
			if(pwd.value.length <4) {
				chk_pwd.innerHTML="비밀번호는 4글자 이상이어야 합니다.";
				chk_pwd.style.color="red";
			} else {
				chk_pwd.innerHTML="사용가능한 비밀번호 입니다."
				chk_pwd.style.color="blue";
			}
		})
		
		//비밀번호 확인
		let chk_pwd2=document.getElementById("chk_pwd2");
		pwd2.addEventListener("keyup", function() {
			if(pwd.value==pwd2.value) {
				chk_pwd2.innerText="비밀번호가 일치합니다."
				chk_pwd2.style.color="blue";
			} else {
				chk_pwd2.innerText="비밀번호가 다릅니다."
				chk_pwd2.style.color="red";
			}
		})
		
		//이메일 유효성 검사
		let isEmail=function(value) {
			return (value.indexOf('@')>2) && (value.split('@')[1].indexOf('.')>1);
		}
		
		let chk_email=document.getElementById("chk_email"); 
		email.addEventListener("keyup", function(event) {
			let value=event.currentTarget.value;
			if(isEmail(value)) {
				chk_email.innerText="이메일 형식이 맞습니다. : "+value;
				chk_email.style.color="blue";
			} else {
				chk_email.innerText="이메일 형식이 아닙니다. : "+value;
				chk_email.style.color="red";
			}
		})
		
		//주소 찾기 (다음 라이브러리 사용)
		let btn_address=document.getElementById("btn_address"); 
		btn_address.addEventListener("click", function() {
			new daum.Postcode({
				oncomplete:function(data) {
					address.value=data.address;
				}
			}).open();
		})
		
		//취소버튼
		let btn_cancel=document.getElementById("btn_cancel");
		btn_cancel.addEventListener("click", function() {
			location='../logon/memberLoginForm.jsp';
		})
		
		//회원가입 버튼의 유효성검사와 처리페이지 넘기기
		let btn_insert=document.getElementById("btn_insert");
		btn_insert.addEventListener("click", function() {
			if(id.value.length==0) {
				alert('아이디를 입력 후 중복체크를 해주세요.');
				id.focus();
				return;
			}
			if(pwd.value.length==0) {
				alert('비밀번호를 입력해주세요.');
				pwd.focus();
				return;
			}
			if(pwd2.value.length==0) {
				alert('비밀번호 확인을 입력해주세요.');
				pwd2.focus();
				return;
			}
			if(name.value.length==0) {
				alert('이름를 입력해주세요.');
				name.focus();
				return;
			}
			if(pwd.value!=pwd2.value) {
				alert('비밀번호가 일치하지 않습니다.');
				pwd2.focus();
				return;
			}
			if(email.value.length==0) {
				alert('이메일을 입력해주세요.');
				email.focus();
				return;
			}
			if(tel.value.length==0) {
				alert('연락처를 입력해주세요.');
				tel.focus();
				return;
			}
			if(address.value.length==0) {
				alert('주소 찾기를 통해 주소를 선택해주세요.');
				address.focus();
				return;
			}
			if(address2.value.length==0) {
				alert('상세주소를 입력해주세요.');
				address2.focus();
				return;
			}
			form.submit();
		})
	})
</script>
</head>	
<body>
<div id="container">

<div class="m_title"><a href="../board/boardList.jsp">DEV TALK</a></div>
<div class="s_title">회원가입</div>

<form action="memberJoinPro.jsp" method="post" name="joinForm">
	<table>
		<tr><th>아이디</th><td>
		<input type="text" name="id" size="15">
		<input type="button" value="ID 중복 체크" id="btn_chk_id"><br>
		<span id="chk_id"></span></td></tr>
		
		<tr><th>비밀번호</th><td>
		<input type="password" name="pwd" size="15"><br>
		<span id="chk_pwd"></span></td></tr>
		
		<tr><th>비밀번호 확인</th><td>
		<input type="password" name="pwd2" size="15"><br>
		<span id="chk_pwd2"></span></td></tr>
		<tr><th>이름</th><td>
		<input type="text" name="name" size="15"></td></tr>
		
		<tr><th>이메일</th><td>
		<input type="text" name="email" size="30"><br>
		<span id="chk_email"></span></td></tr>
		
		<tr><th>연락처</th><td>
		<input type="text" name="tel" size="30"></td></tr>
		
		<tr class="addr_row"><th>주소</th><td>
		<input type="button" value="주소 찾기" id="btn_address" size="50"><br>
		<input type="text" name="address"><br>
		<input type="text" name="address2" size="50"></td></tr>
	</table>
	<div class="btns">
		<input type="button" value="회원가입" id="btn_insert">&emsp;&emsp;
		<input type="button" value="취소" id="btn_cancel">
	</div>
</form>

</div>
</body>
</html>