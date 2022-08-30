<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberInfoForm</title>
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
	table {width: 100%; border-collapse: collapse; border: 1px solid white;}
	table input {font-family: 'Noto Sans KR', sans-serif;} 
	tr {height: 65px;}
	th, td {border: 1px solid #ccc; padding-left: 5px;}
	th {background: #D9E5FF; color: gray; width: 120px; font-family: 'Jua', sans-serif; font-size: 1.0em; font-weight: lighter;}
	.c_id {background: 	#E7E7E7; border: 1px solid gray;}
	.s_id {color: gray; font-family: 'Jua', sans-serif; font-size: 1em; font-weight: lighter;}
	.addr_row {height: 100px;}
	.addr_row input {margin: 2px 0;}
	#chk_pwd2 {font-family: 'Noto Sans KR', sans-serif;}
	#btn_address {width: 110px; height: 30px; border: none; border-radius:3px; background: #FFBD6A; color: white; 
				font-size: 12px; font-weight: bold; cursor: pointer; font-family: 'Jua', sans-serif; font-size: 1em; font-weight: lighter;}
	
	/* 하단 */
	.btns {text-align: center; margin-top: 30px;}
	.btns input[type="button"] {width: 120px; height: 40px; border-radius: 25px; border: none; background: #6799FF; color: white; 
								font-weight: bold; cursor: pointer; font-family: 'Jua', sans-serif; font-size: 1em; font-weight: lighter;}
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 다음 주소 라이브러리 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form=document.infoForm; 
		let id=form.id;
		let pwd=form.pwd;
		let pwd2=form.pwd2;
		let name=form.name;
		let email=form.email;
		let tel=form.tel;
		let address=form.address; 
		let address2=form.address2;
		
	
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
		
		//게시글보기 버튼을 클릭
		let btn_boardList=document.getElementById("btn_boardList");
		btn_boardList.addEventListener("click", function() {
			location='../board/boardList.jsp';
		})
		
		
		//회원가입 버튼의 유효성검사와 처리페이지 넘기기
		let btn_update=document.getElementById("btn_update");
		btn_update.addEventListener("click", function() {
			
			if(id.value.length==0) {
				alert('아이디를 입력 후 중복체크를 해주세요.');
				id.focus();
				return;
			}
			/* if(!isChk) {
				alert('아이디 중복 체크를 해주세요.');
				id.focus();
				return;
			} */
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
		
		//회원탈퇴 버튼의 처리페이지 넘기기
		let btn_delete=document.getElementById("btn_delete");
		btn_delete.addEventListener("click",function() {
			let form=document.infoForm;
			
			if(!form.id.value) {
				alert('아이디를 입력하세요.');
				form.id.focus();
				return;
			}
			if(!form.pwd.value) {
				alert('비밀번호를 입력하세요.');
				form.pwd.focus();
				return;
			}
			if(!form.pwd2.value) {
				alert('비밀번호 확인을 입력하세요.');
				form.pwd2.focus();
				return;
			}
			if(pwd.value!=pwd2.value) {
				alert('비밀번호가 일치하지 않습니다.');
				form.pwd2.focus();
				return;
			}
			
			let answer=confirm('확인을 누르면 탈퇴 처리가 완료됩니다.');
			if(answer) {
				/* 폼의 액션을 바꾸는 방법 -> 여기서 바꾸는 이유는 현재 폼의 액션이 memberUpdatePro.jsp로 이동되는 것으로 설정되있기 때문에 delete.jsp로 변경하기 위함이다. */
				form.action='memberDeletePro.jsp';
				form.submit();
			} else {
				return;
			}
		})
	})
</script>
</head>
<body>

<%
String memberId=(String)session.getAttribute("memberId");
if(memberId==null) {
	out.print("<script>location='../logon/memberLoginForm.jsp';</script>");
}

/* 아래는 세션 memberId가 있을 때 실행 */
MemberDAO memberDAO=MemberDAO.getInstance();
MemberDTO member=new MemberDTO();
member=memberDAO.getMember(memberId);

SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>

<div id="container">
	<div class="m_title"><a href="../board/boardList.jsp">DEV TALK</a></div>
	<div class="s_title">회원 정보 확인</div>
	
	<form action="memberUpdatePro.jsp" method="post" name="infoForm">
		<table>
			<tr><th>아이디</th><td>
			<input type="text" name="id" size="15" value="<%=member.getId()%>" class="c_id" readonly>
			&ensp;<span class="s_id">※아이디는 변경 불가합니다.</span></td></tr>
			
			<tr><th>비밀번호</th><td>
			<input type="password" name="pwd" size="15" value="<%=member.getPwd()%>"><br>
			<span id="chk_pwd"></span></td></tr>
			
			<tr><th>비밀번호 확인</th><td>
			<input type="password" name="pwd2" size="15"><br>
			<span id="chk_pwd2"></span></td></tr>
			
			<tr><th>이름</th><td>
			<input type="text" name="name" size="15" value="<%=member.getName()%>"></td></tr>
			
			<tr><th>이메일</th><td>
			<input type="text" name="email" size="30" value="<%=member.getEmail()%>"><br>
			<span id="chk_email"></span></td></tr>
			
			<tr><th>연락처</th><td>
			<input type="text" name="tel" size="30" value="<%=member.getTel()%>"></td></tr>
			
			<tr class="addr_row"><th>주소</th><td>
			<input type="button" value="주소 찾기" id="btn_address" size="50"><br>
			<input type="text" name="address"><br>
			<input type="text" name="address2" size="50"></td></tr>
			
			<tr><th>가입일시</th><td><%=sdf.format(member.getRegDate())%></td></tr>
		</table>
		<div class="btns">
			<input type="button" value="회원정보수정" id="btn_update">&emsp;&emsp;
			<input type="button" value="회원탈퇴" id="btn_delete">&emsp;&emsp;
			<input type="button" value="게시글 보기" id="btn_boardList">
		</div>
	</form>
</div>

</body>
</html>