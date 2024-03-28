<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">

<title>Log in</title>
</head>
<body>
	<div class="bg-secondary" style="height: 120vh;">
		<div class="mx-0">
			<nav class="navbar navbar-dark bg-dark">
				<a class="navbar-brand mx-5" style="font-weight: bolder;">BOSE BANK</a>
			</nav>
		</div>

		<!-- msg display in case of duplicate pan or logout -->
		<c:if test="${not empty msg}">
			<div class="alert alert-danger alert-dismissible fade show"
				role="alert">
				${msg }
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
		</c:if>

		<div class="mx-0">
			<div
				class="container border border-secondary my-4 rounded bg-dark text-light"
				style="width: 40%;">
				<table>
					<tbody>
						<tr>
							<h3 class="btn text-center my-4 col-6 text-light" id="loginbtn"
								onclick="form(1);">Login</h3>
						</tr>
						<tr>
							<h3 class="btn text-center my-4 col-6 text-secondary"
								id="signbtn" onclick="form(2);">Sign Up</h3>
						</tr>
					</tbody>
				</table>
				<div id="error" class="text-danger row justify-content-center">${errors}</div>
				<form action="/userApi/login" method="post" class="container"
					id="loginform" style="width: 75%;"
					onSubmit="return checkInputLogin(this);">
					<div class="form-group my-3">
						<div id="errors" class="text-danger"></div>
						<input type="number" placeholder="User ID"
							class="form-control bg-dark border-bottom text-light" id="userId"
							name="userId" style="border: none;">
					</div>
					<div class="form-group my-3 text-secondary row">
						<p class="justify-content-center">OR</p>
					</div>
					<div class="form-group my-3">
						<input type="text" placeholder="PAN No"
							class="form-control bg-dark border-bottom text-light" id="panNo"
							name="panNo" style="border: none;">
					</div>
					<div class="form-group my-3">
						<input type="password" placeholder="Password"
							class="form-control bg-dark border-bottom text-light"
							id="password" name="password" style="border: none;">
					</div>
					<div class="text-center my-4">
						<button type="submit" class="btn btn-outline-success text-center">Log
							In</button>
					</div>
				</form>

				<form action="/userApi/create" method="post" class="container"
					id="signupform" style="width: 75%; display: none;" onsubmit="return validateSignup(this);">
					<div id="signupError"></div>
					<div class="form-group my-3">
						<input type="text" placeholder="Name"
							class="form-control bg-dark border-bottom text-light" id="name"
							name="name" style="border: none;" required>
					</div>
					<div class="form-group my-3">
						<input type="email" placeholder="Email ID"
							class="form-control bg-dark border-bottom text-light" id="email"
							name="email" style="border: none;">
					</div>
					<div class="form-group my-3">
						<input type="text" placeholder="Phone No"
							class="form-control bg-dark border-bottom text-light" id="phnNo"
							name="phnNo" style="border: none;" required>
					</div>
					<div class="form-group my-3">
						<input type="text" placeholder="Pan No"
							class="form-control bg-dark border-bottom text-light" id="panNo"
							name="panNo" style="border: none;" required>
					</div>
					<div class="form-group my-3">
						<textarea placeholder="Address"
							class="form-control bg-dark border-bottom text-light"
							id="address" name="address" style="border: none;" required></textarea>
					</div>
					<div class="form-group my-3 row">
						<label for="dob" class="col-4 text-secondary pt-2">DOB :</label>
						<input type="date"
							class="form-control bg-dark border-bottom text-light col-7" id="dob"
							name="dob" style="border: none;" required>
					</div>
					<div class="form-group my-3">
						<input type="password" placeholder="Password"
							class="form-control bg-dark border-bottom text-light"
							id="password" name="password" style="border: none;" required>
					</div>
					<div class="text-center my-4">
						<button type="submit" class="btn btn-outline-success text-center">Sign
							Up</button>
					</div>
				</form>
			</div>
		</div>

	</div>
	
	<!-- Toggles between login and signup -->
	<script>
      function form(option){
		document.getElementById("error").innerHTML="";
        if(option==1){
          document.getElementById("signupform").style.display="none";
          document.getElementById("loginform").style.display="block";
		  document.getElementById("loginbtn").classList.replace("text-secondary","text-light");
		  document.getElementById("signbtn").classList.replace("text-light","text-secondary");
        }else{
          document.getElementById("loginform").style.display="none";
          document.getElementById("signupform").style.display="block";
		  document.getElementById("signbtn").classList.replace("text-secondary","text-light");
		  document.getElementById("loginbtn").classList.replace("text-light","text-secondary");
        }
      }
    </script>

	<!-- Prevents back button -->
	<script type="text/javascript">
		function disableBackButton() {
			window.history.forward();
		}
		setTimeout("disableBackButton()", 0);
		window.onunload = function() {
			null
		};
	</script>

	<!-- Login form validation -->
	<script>
		function validateSignup(form){
			var panNo = form.elements["panNo"];
			var phnNo = form.elements["phnNo"];
			var dob = form.elements["dob"];
			const panRegex = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
			const phnRegex = /^\d{10}$/;
			
			if(!phnRegex.test(phnNo.value)){
				alert("Invalid Phone No");
				phnNo.focus();
				return false;
			}
			else if(!panRegex.test(panNo.value)){
				alert("Invalid Pan No");
				panNo.focus();
				return false;
			}else if(new Date() <= new Date(dob.value)){
				alert("Date Of Birth can't be greater than current date");
				dob.focus();
				return false;
			}
			return true;
		}
	
		function checkInputLogin(form) {
			 var userId = form.elements["userId"];
			 var panNo = form.elements["panNo"];
			 const panNoRegex = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
			 
			 if(userId.value.trim()===""){
				 if(panNoRegex.test(panNo.value)){
					 userId.value = "0";
					 return true;
				 }else{
					 return false;
				 }
			 }
		}
	</script>

	<!-- Optional JavaScript; choose one of the two! -->

	<!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
		crossorigin="anonymous"></script>
	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<!--
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
    -->
</body>
</html>