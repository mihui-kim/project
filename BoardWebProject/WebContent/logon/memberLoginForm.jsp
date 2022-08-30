<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');
	#container {width: 450px; margin: 40px auto;}
	
	/* 상단 */ 
	.m_title {font-family: 'Fredoka One', cursive; font-size: 3em; text-align: center;}
	.m_title a {text-decoration: none; color: #6799FF;}
	.s_title {font-family: 'Fredoka One', cursive; font-size: 2em; text-align: center; margin-bottom: 20px; color: gray;}
	
	/* 중단 입력창 */
	.f_input {text-align: center; padding: 10px; border: 1px solid #ccc; border-radius: 10px;}
	.f_input .c_id, .c_pwd {height: 45px; margin-top: 20px; padding-left: 5px; border-radius: 10px; border: 1px solid #ccc;}
	.f_input .f_chk {text-align: left; margin-top: 20px; font-size: 0.9em; color: gray; margin-left: 15px;}
	.f_input #btn_login {margin: 20px 0; width: 410px; height: 47px; 
						background: #6799FF; color: white; font-weight:bold; font-size: 15px;
						border: none; border-radius: 10px; cursor: pointer;}
	
	/* 하단 */
	.f_a {text-align: center; margin-top: 15px;	}
	.f_a a {text-decoration: none; color: gray;}
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
<div id="container">
	<div class="m_title"><a href="#">DEV TALK</a></div>
	<div class="s_title">LOGIN</div>
	
	<form action="memberLoginPro.jsp" method="post" name="loginForm">
		<div class="f_input">
			<div class="f_id"><input type="text" id="id" name="id" class="c_id" placeholder="아이디" size="55"></div>
			<div class="f_pwd"><input type="password" id="pwd" name="pwd" class="c_pwd" placeholder="비밀번호" size="55"></div>
			<div class="f_chk"><input type="checkbox" id="chk" class="c_chk" size="55">&nbsp;<label for="chk">아이디 저장</label></div>
			<div class="f_submit"><input type="button" value="로그인" id="btn_login"></div>
		</div>
		<div class="f_a">
			<a href="#">비밀번호 찾기 &emsp;|&emsp;&emsp;</a>
			<a href="#">아이디 찾기&emsp;&emsp;|&emsp;&emsp;</a>
			<a href="../member/memberJoinForm.jsp">회원가입</a> <!-- 다른 폴더에 있어서 (../) 하위경로를 표시하면서 찾아주었다 -->
		</div>
	</form>
</div>
</body>
</html>