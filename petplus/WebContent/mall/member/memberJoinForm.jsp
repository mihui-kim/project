<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberJoinForm</title>
<style>
	@font-face {
	    font-family: 'font1';
	    src: url('../../icons/SuncheonB.ttf') format('truetype');
	}
	@font-face {
	    font-family: 'font2';
	    src: url('../../icons/SuncheonR.ttf') format('truetype');
	}
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
	
	
	/* 상단 */ 
	* {
		margin: 0;
		padding: 0;
	}
	body {
		border: 40px solid #fda73f;
		border-top: hidden;
	}
	#container {
		width: 1200px; 
		margin: 40px auto;
	}
	.j_form {
		width: 450px;
		margin: 20px 63% 20px 37%;
		color:  #575555; 
		font-family: 'font2';
		font-weight: bold;
	}
	.s_title {
		margin: 50px auto; 
		text-align: left;
		font-size: 1.4em;
	}
	input:-webkit-autofill {
		-webkit-box-shadow: 0 0 0 1000px white inset; 
		box-shadow: 0 0 0 1000px white inset;
	}
	input[type="text"], input[type="password"] {
		width: 300px;
		height: 35px;
		margin: 10px 0 30px 0;
		padding-left: 10px;
	}
	input[type="text"]:focus, input[type="password"]:focus {
		outline-color: green;
	}
	input:-webkit-autofill {
		-webkit-box-shadow: 0 0 0 1000px white inset; 
		box-shadow: 0 0 0 1000px white inset;
	}
	
	
	/* 중단 */
	form {
		font-size: 0.9em;
		position: relative;
	}
	form #btn_chk_id {
		width: 80px; 
		height: 35px;  
		border: none; 
		font-size: 0.7em;
		cursor: pointer; 
	}
	form #chk_pwd {
		position: absolute;
		top: 235px;
		font-size: 0.75em;
		margin: 0;
		padding: 0;
	}
	form #chk_pwd2 {
		position: absolute;
		top: 330px;
		font-size: 0.75em;
		margin: 0;
		padding: 0;
	}
	form #chk_email {
		position: absolute;
		top: 520px;
		font-size: 0.75em;
		margin: 0;
		padding: 0;
	}
	#i_address {
		margin: 5px 0;
	}
	#btn_address {
		width: 80px; 
		height: 35px; 
		border: none; 
		font-size: 0.7em;
		cursor: pointer;
	}
	
	
	/* 하단 */
	.btns {
		width: 300px;
		text-align: center; 
		margin: 50px auto 130px;
		font-family: 'font2';
		font-weight: bold;
		font-size: 0.9em;
		color:  #575555;
	}
	.btns input[type="button"] {
		width: 130px; 
		height: 50px; 
		border-radius: 5px; 
		border: none; 
		background: #396e15;  
		color: white; 
		font-family:  'font1';
		font-size: 1em; 
		cursor: pointer; 
	}
	#btns_chk {
		text-align: left;
	}
	#btns_chk input[type="checkbox"] {
		accent-color: green;
	}
	#accept1 {
		margin-bottom: 15px; 
	}
	
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 다음 주소 라이브러리 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- alert 라이브러리 -->
<script>

	//let isChk=false; //아이디중복체크 누르기 (전역변수)

	document.addEventListener("DOMContentLoaded", function() {
		let form=document.joinForm; 
		
		//ID중복 체크 버튼 (DB작업)
		let btn_chk_id=document.getElementById("btn_chk_id");
		btn_chk_id.addEventListener("click", function() {
			if(form.id.value.length<4) {alert('아이디를 4글자 이상 입력해주세요.'); id.focus();}
			else {location='memberIdCheck.jsp?id='+form.id.value;}
		})
		
		//비밀번호 유효성 검사 (8글자 이상 입력되도록 조건 걸기)
		let chk_pwd=document.getElementById("chk_pwd");
		form.pwd.addEventListener("keyup", function() {
			if(form.pwd.value.length <4) {
				chk_pwd.innerHTML="비밀번호는 4글자 이상이어야 합니다.";
				chk_pwd.style.color="red";
			} else {
				chk_pwd.innerHTML="사용가능한 비밀번호 입니다."
				chk_pwd.style.color="blue";
			}
		})
		
		//비밀번호 확인
		let chk_pwd2=document.getElementById("chk_pwd2");
		form.pwd2.addEventListener("keyup", function() {
			if(form.pwd.value==form.pwd2.value) {
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
		form.email.addEventListener("keyup", function(event) {
			let value=event.currentTarget.value;
			if(isEmail(value)) {
				chk_email.innerText="이메일 형식이 맞습니다."
				chk_email.style.color="blue";
			} else {
				chk_email.innerText="이메일 형식이 아닙니다."
				chk_email.style.color="red";
			}
		})
		
		//주소 찾기 (다음 라이브러리 사용)
		let btn_address=document.getElementById("btn_address"); 
		btn_address.addEventListener("click", function() {
			new daum.Postcode({
				oncomplete:function(data) {
					form.address.value=data.address;
				}
			}).open();
		})
		
		//취소버튼
		let btn_cancel=document.getElementById("btn_cancel");
		btn_cancel.addEventListener("click", function() {
			location='../shopping/shopAll.jsp';
		})
		

		function SweetAlert(){
			Swal.fire(
					  'check',
					  '개인정보 수집에 동의하셨습니다.',
					  'success'
					)
		   }
		
		//개인정보 동의 체크
		let accept1=document.getElementById("accept1");
		accept1.addEventListener("click", function() {
				
				SweetAlert();
			})	
			
		
		//회원가입 버튼의 유효성검사와 처리페이지 넘기기
		let btn_insert=document.getElementById("btn_insert");
		btn_insert.addEventListener("click", function() {
			if(form.id.value.length==0) {
				alert('아이디를 입력 후 중복체크를 해주세요.');
				form.id.focus();
				return;
			}
			if(form.pwd.value.length==0) {
				alert('비밀번호를 입력해주세요.');
				form.pwd.focus();
				return;
			}
			if(form.pwd2.value.length==0) {
				alert('비밀번호 확인을 입력해주세요.');
				form.pwd2.focus();
				return;
			}
			if(form.name.value.length==0) {
				alert('이름를 입력해주세요.');
				form.name.focus();
				return;
			}
			if(form.pwd.value!=form.pwd2.value) {
				alert('비밀번호가 일치하지 않습니다.');
				form.pwd2.focus();
				return;
			}
			if(form.email.value.length==0) {
				alert('이메일을 입력해주세요.');
				form.email.focus();
				return;
			}
			if(form.tel.value.length==0) {
				alert('연락처를 입력해주세요.');
				form.tel.focus();
				return;
			}
			if(form.address.value.length==0) {
				alert('주소 찾기를 통해 주소를 선택해주세요.');
				form.address.focus();
				return;
			}
			if(form.address2.value.length==0) {
				alert('상세주소를 입력해주세요.');
				form.address2.focus();
				return;
			}
			if(form.accept1.checked==0) {
				alert('개인정보 수집 및 이용에 동의해주세요.');
				form.accept1.focus();
				return;
			}
			form.submit();
		})
	})
</script>
</head>	
<body>

<%request.setCharacterEncoding("utf-8");%>
<header><jsp:include page="../common/shopTop.jsp"></jsp:include></header>
<div id="container">
<form action="memberJoinPro.jsp" method="post" name="joinForm" autocomplete="off">
	<div class="j_form">
		<div class="s_title">회원 가입</div>
		<p>아이디 *</p>
		<input type="text" name="id" size="15">
		<input type="button" value="ID 중복 체크" id="btn_chk_id"><br>
		
		<p>비밀번호 *</p>
		<input type="password" name="pwd" size="15"><br>
		<span id="chk_pwd"></span>
		
		<p>비밀번호 확인 *</p>
		<input type="password" name="pwd2" size="15"><br>
		<span id="chk_pwd2"></span>
		
		<p>이름 *</p>
		<input type="text" name="name" size="15">
		
		<p>이메일 *</p>
		<input type="text" name="email" size="30"><br>
		<span id="chk_email"></span>
		
		<p>연락처 *</p>
		<input type="text" name="tel" size="30">
		
		<p>주소 *</p>
		<input type="text" name="address" id="i_address"> <input type="button" value="주소 찾기" id="btn_address" size="50">
		<input type="text" name="address2" size="50" id="i_address">
	</div>
	<div class="btns">
		<div id="btns_chk">
			<input type="checkbox" name="accept1" id="accept1"><label for="accept1"> (필수) 개인정보 수집 및 이용에 동의합니다.</label><br>
			<input type="checkbox" name="accept2" id="accept2"><label for="accept2"> (선택) 이메일 마케팅 정보 수신에 동의합니다.</label>
		</div><br><br><br>
		<input type="button" value="회원가입" id="btn_insert">&emsp;&emsp;
		<input type="button" value="취소" id="btn_cancel">
	</div>
</form>
<jsp:include page="../common/shopBottom.jsp"></jsp:include>
</div>
</body>
</html>