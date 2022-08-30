<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 폼</title>
<style>
	@font-face {
	    font-family: 'font1';
	    src: url('../../icons/SuncheonB.ttf') format('truetype');
	}
	@font-face {
	    font-family: 'font2';
	    src: url('../../icons/SuncheonR.ttf') format('truetype');
	}
	
	/* 상단 */
	* {
		margin: 0;
		padding: 0;
	}
	.bg {
	  width: 100%;
	  height: 100%;
	  overflow: hidden;
	  margin: 0px auto;
	  position: relative;
	}
	video {
	  width: 100%;
	  position: relative;
	  top: 5px;
	}
	.text {
	  position: absolute;
	  width: 100%;
	  top: 200px;
	  left: 50%;
	  transform: translate(-50%,-50%);
	}
	.m_title {
		font-family: 'font1';
		font-size: 3em; 
		font-weight: bold;
		text-align: center; 
		margin: 30px 0px;
	}
	.m_title #one {
		color: #fda73f;
	}
	.m_title #two {
		color: #396e15;
	}
	.s_title {
		margin: 20px auto 10px; 
		font-family: 'font1';
		font-size: 1em; 
		text-align: center; 
		color: gray;
	}
	.s_title_img {
		position: relative; 
		top: 4px; 
		right: 5px;
	}

	
	/* 중단 */	
	input:-webkit-autofill {
		-webkit-box-shadow: 0 0 0 1000px white inset; 
		box-shadow: 0 0 0 1000px white inset;
	}
	form {
		width: 300px;
		height: 230px;
		margin: 0 auto;
		border: 1px solid #ccc;  
		border-radius: 10px;
		background: white;
	}
	.b_box {
		width: 230px;
		padding: 5px; 
		margin: -1px auto;
		border: 1px solid lightgray;
		border-radius: 5px;
		background: white;
		text-align: center;
	} 
	.b_box input:focus {
		outline: none;
	}
	.b_box input[type='text'], .b_box input[type='password'] {
		width: 220px;
		height: 35px; 
		padding-left: 10px; 
		border: none;
	}
	.c_box {
		margin: 10px;   
		text-align: center;
	}
	.c_box input[type='button'] {
		width: 238px; 
		height: 45px; 
		padding: 5px;
		border: 3px solid #396e15;  
		border-radius: 5px;
		color: white;
		background: #396e15;  
		font-family: 'font1';
		font-size: 1em; 
		cursor: pointer;
	}
	
	

</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form=document.managerLoginForm;
		
		let btn_login=document.getElementById("btn_login");
		btn_login.addEventListener("click", function() {
			if(!form.managerId.value) {
				alert('아이디를 입력해주세요.');
				return;
			}
			if(!form.managerPwd.value) {
				alert('비밀번호를 입력해주세요.');
				return;
			}
			form.submit();
		})
	})

</script>
</head>
<body>

<div class="bg">
      <video muted autoplay loop>
        <source src="../../icons/title.mp4" type="video/mp4">
      </video>
    <div class="text">
		<div class="m_title"><span id="one">Pet</span> <span id="two">Plus+</span></div>
		
		<form action="managerLoginPro.jsp" method="post" name="managerLoginForm"  autocomplete="off">
			<div class="s_title"><img src="../../icons/manager.png" width="20px" class="s_title_img">관리자 계정</div>
			<div class="a_box">
				<div class="b_box">
					<input type="text" name="managerId" id="managerId" placeholder="아이디" size="28">
				</div>
				<div class="b_box">
					<input type="password" name="managerPwd" id="managerPwd" placeholder="비밀번호" size="28">
				</div>
				<div class="c_box">
					<input type="button" id="btn_login" value="로그인">
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>