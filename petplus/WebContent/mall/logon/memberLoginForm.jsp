<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
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
	
	
	/* 상단 */ 
	.s_title {
		font-family: 'font1';
		font-weight: bold;
		font-size: 2.5em; 
		text-align: center;
		margin: 30px auto; 
		color: #396e15; 
	}
	
	/* 중단 입력창 */
	input:-webkit-autofill {
		-webkit-box-shadow: 0 0 0 1000px white inset; 
		box-shadow: 0 0 0 1000px white inset;
	}
	.f_input{ 
		width: 350px;
		height: 250px;
		padding: 30px; 
		margin: 0px auto 150px;
		border: 1px solid #adadad;
		border-radius: 10px;
		background: white;
		text-align: center;
	}
	.f_input .c_id, .f_input .c_pwd {
		width: 300px;
		height: 50px; 
		margin: 0px auto;
		padding-left: 50px;
		border: 1px solid #adadad;
		border-radius: 5px;
	}
	.f_input .c_pwd {
		border-top: hidden;
	}
	.f_input .c_id:focus, .f_input .c_pwd:focus {
		outline-color: green;
	}
	.f_input .f_id input[type='text'] {
		background: url('../../icons/m_user.png') no-repeat;
		background-size: 20px; 
		background-position: 15px; 
	}
	.f_input .f_id input[type='text']:focus {
		background: url('../../icons/m_user2.png') no-repeat;
		background-size: 20px; 
		background-position: 15px; 
	}
	.f_input .f_pwd input[type='password'] {
		background: url('../../icons/m_pwd.png') no-repeat;
		background-size: 20px; 
		background-position: 15px; 
	}
	.f_input .f_pwd input[type='password']:focus {
		background: url('../../icons/m_pwd2.png') no-repeat;
		background-size: 20px; 
		background-position: 15px; 
	}
	.f_input .f_chk {
		text-align: left;
		margin-left: 15px;
		margin-top: 20px;
		font-size: 0.9em;
		font-family: 'Noto Sans KR', sans-serif;
		color: #adadad;
	}
	.f_input .f_chk input[type="checkbox"] {
		accent-color: green;
	}
	
	.f_input #btn_login {
		width: 350px; 
		height: 50px; 
		padding: 5px;
		margin-top: 30px;
		border: 3px solid #396e15;  
		border-radius: 5px;
		color: white;
		background: #396e15;  
		font-family: 'font1';
		font-size: 1em;
		cursor: pointer;
	}
	
	/* 하단 */
	.f_a {
		font-family: 'Noto Sans KR', sans-serif;
		font-size: 0.9em;
		text-align: center; 
		margin-top: 15px;	
	}
	.f_a a {
		text-decoration: none; 
		color: #adadad;
	}
</style>

<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form= document.loginForm;
		
		/* 로그인 버튼 클릭했을 때 유효성 검사(공백 유무) */
		let btn_login=document.getElementById("btn_login");
		btn_login.addEventListener("click", function() {
			if(!form.id.value) {
				alert('아이디를 입력해주세요.');
				form.id.focus();
				return;
			}
			if(!form.pwd.value) {
				alert('비밀번호를 입력해주세요.');
				return;
			}
			form.submit();	
		})
		
		/* 쿠키 값(id)를 아이디입력상자(input)에 자동으로 넣어놓도록 하는 작업 */
		//쿠키가 있다면... 
		if(document.cookie.length > 0) {
			let search = "cookieId=";
			let idx = document.cookie.indexOf(search);
			//쿠키 아이디값이 있다면...
			if(idx != -1) {
				idx += search.length;
				let end = document.cookie.indexOf(';', idx);
				if(end == -1) {
					end = document.cookie.length;
				}
			form.id.value=document.cookie.substring(idx, end);
			form.chk.checked = true;
			}
		}
		
		/* 로그인 상태 유지 버튼 클릭했을 때 (쿠키 사용 - 자바스크립트로 만들어보자) */
		let chk=document.getElementById("chk");
		chk.addEventListener("click", function() {
			let now =new Date();
			let name ="cookieId";
			let value =form.id.value;
			
			//체크박스 ON  -> 쿠키생성
			if(form.chk.checked == true) {
				now.setDate(now.getDate()+7)
			//체크박스 OFF -> 쿠키삭제
			} else {
				now.setDate(now.getDate()+0);
			}
			document.cookie = name + "=" + escape(value) + ";path=/;expires=" + now.toGMTString() + ";";
		})
		
	})
</script>
</head>	
<body>
<%request.setCharacterEncoding("utf-8");%>
<div id="container">
	<div>
		<header><jsp:include page="../common/shopTop.jsp"/></header>
	</div>
	<div class="s_title">LOGIN</div>
	
	<form action="memberLoginPro.jsp" method="post" name="loginForm" autocomplete="off">
		<div class="f_input">
			<div class="f_id"><input type="text" id="id" name="id" class="c_id" placeholder="아이디" size="55"></div>
			<div class="f_pwd"><input type="password" id="pwd" name="pwd" class="c_pwd" placeholder="비밀번호" size="55"></div>
			<div class="f_chk"><input type="checkbox" id="chk" class="c_chk" size="55">&nbsp;<label for="chk">아이디 저장</label></div>
			<div class="f_submit"><input type="button" value="로그인" id="btn_login" ></div>
			<div class="f_a">
				<a href="#">비밀번호 찾기 &emsp;|&emsp;</a>
				<a href="#">아이디 찾기&emsp;|&emsp;</a>
				<a href="../member/memberJoinForm.jsp">회원가입</a> <!-- 다른 폴더에 있어서 (../) 하위경로를 표시하면서 찾아주었다 -->
			</div>
		</div>
	</form>
	<jsp:include page="../common/shopBottom.jsp"/>
</div>
</body>
</html>