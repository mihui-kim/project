<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberInfoForm</title>
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
	}
	#container {
		width: 1200px; 
		margin: 0 auto;
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
	form #read {
		background: #E7E7E7; 
		border: 1px solid gray;
	}
	form #s_date {
		margin-top: 30px;
	}
	form #chk_pwd {
		position: absolute;
		top: 230px;
		font-size: 0.75em;
		margin: 0;
		padding: 0;
	}
	form #chk_pwd2 {
		position: absolute;
		top: 325px;
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
		width: 400px;
		text-align: center; 
		margin: 50px auto 130px;
		color:  #575555;
	}
	.btns input[type="button"] {
		width: 100px; 
		height: 40px; 
		border-radius: 5px; 
		border: none; 
		background: #396e15;  
		color: white; 
		font-family:  'font1';
		font-size: 1em; 
		cursor: pointer; 
	}
	
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 다음 주소 라이브러리 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form=document.infoForm; 
	
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
					form.address.value=data.address;
				}
			}).open();
		})
	
		
		//회원정보수정 버튼의 유효성검사와 처리페이지 넘기기
		let btn_update=document.getElementById("btn_update");
		btn_update.addEventListener("click", function() {
			
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
			form.submit();
		})
		
		//회원탈퇴 버튼의 처리페이지 넘기기
		let btn_delete=document.getElementById("btn_delete");
		btn_delete.addEventListener("click",function() {
			
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
			if(form.pwd.value!=form.pwd2.value) {
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
		
		//취소 버튼 (전 페이지로 돌아가기)
		let btn_cancel=document.getElementById("btn_cancel");
		btn_cancel.addEventListener("click", function() {
			location='../shopping/shopAll.jsp';
		})
	})
</script>
</head>
<body>

<%


String memberId=(String)session.getAttribute("memberId");
if(memberId==null) {
	out.print("<script>location='../logon/memberLoginForm.jsp';</script>");
	return;
}

/* 아래는 세션 memberId가 있을 때 실행 */
MemberDAO memberDAO=MemberDAO.getInstance();
MemberDTO member=new MemberDTO();
member=memberDAO.getMember(memberId);

SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>



<div id="container">
<div>
	<header><jsp:include page="../common/shopTop.jsp"/></header>
</div>
	<form action="memberUpdatePro.jsp" method="post" name="infoForm">
		<div class="j_form">
			<div class="s_title">회원 정보 확인</div>
			<p>아이디</p>
			<input type="text" name="id" size="15" id="read" value="<%=member.getId()%>" readonly>
			
			<p>비밀번호</p>
			<input type="password" name="pwd" size="15" value="<%=member.getPwd()%>"><br>
			<span id="chk_pwd"></span>
			
			<p>비밀번호 확인</p>
			<input type="password" name="pwd2" size="15" ><br>
			<span id="chk_pwd2"></span>
			
			<p>이름</p>
			<input type="text" name="name" size="15" value="<%=member.getName()%>">
			
			<p>이메일</p>
			<input type="text" name="email" size="30"  id="read" value="<%=member.getEmail()%>" readonly>
			
			<p>연락처</p>
			<input type="text" name="tel" size="30" value="<%=member.getTel()%>">
			
			<p>주소</p>
			<input type="text" name="address" id="i_address"> <input type="button" value="주소 찾기" id="btn_address" size="50">
			<input type="text" name="address2" size="50" id="i_address">
			
			<p id="s_date">가입일시</p>
			<input type="text" id="read" value="<%=sdf.format(member.getRegDate())%>" readonly>
		</div>
	<div class="btns">
		<input type="button" value="수정" id="btn_update">&emsp;
		<input type="button" value="취소" id="btn_cancel">&emsp;
		<input type="button" value="회원탈퇴" id="btn_delete">
	</div>
	</form>
	<jsp:include page="../common/shopBottom.jsp"/>
</div>
</body>
</html>