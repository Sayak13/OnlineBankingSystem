<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	
<style>
	body{
		background-image: url("${pageContext.request.contextPath}\back.webp");
		background-color: #cccccc;
	}
</style>

<title>Admin|Update</title>
</head>
<body>
	<%
	session = request.getSession();
	Object attribute = session.getAttribute("admin");
	if (attribute == null || !attribute.equals("Admin")) {
		response.sendRedirect("/userApi/index");
		return;
	}
	%>

	<div>
		<!-- Nav Bar -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
			<a class="navbar-brand mx-3" style="font-weight: bolder;">BOSE BANK</a>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-itemmx-2"><a
						class="nav-link" href="/adminApi/adminHome">Home</a></li>
					<li class="nav-item active mx-2"><a
						class="nav-link" href="/adminApi/allUsers">Users</a></li>
					<li class="nav-item mx-2">
						<a class="nav-link" href="/adminApi/allAccounts">Accounts</a>
					</li>
				</ul>
			</div>

			<div class="form-inline">
				<div class="dropdown">
					<a class="navbar-brand btn dropdown-toggle mx-5" href="#"
						role="button" data-toggle="dropdown" aria-expanded="false">
						Welcome Admin </a>

					<div
						class="dropdown-menu border-0 row justify-content-center mx-auto">
						<a class="dropdown-item" href="/userApi/logout">Logout</a>
					</div>
				</div>
			</div>
		</nav>

		<!-- Update User Form -->
		<div class="container w-50 shadow my-5">
			
			<div class="row justify-content-center mt-3 pt-3">
				<h2>User Details</h2>
			</div>
			
			<form class="mx-auto my-5 pb-3" action="/adminApi/updateUser" method="post">
				<div class="form-group row">
					<label for="userId" class="col-sm-2 col-form-label">User ID</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="userId" name="userId"
							placeholder="Enter user ID" value="${user.userId}"
							readonly />
					</div>
				</div>
				<div class="form-group row">
					<label for="name" class="col-sm-2 col-form-label">Name</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="name" name="name"
							placeholder="Enter name" value="${user.name}">
					</div>
				</div>
				<div class="form-group row">
					<label for="email" class="col-sm-2 col-form-label">Email</label>
					<div class="col-sm-10">
						<input type="email" class="form-control" id="email" name="email"
							placeholder="Enter email" value="${user.email}">
					</div>
				</div>
				<div class="form-group row">
					<label for="phnNo" class="col-sm-2 col-form-label">Phone
						Number</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="phnNo" name="phnNo"
							placeholder="Enter phone number"
							value="${user.phnNo}">
					</div>
				</div>
				<div class="form-group row">
					<label for="panNo" class="col-sm-2 col-form-label">PAN
						Number</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="panNo" name="panNo"
							placeholder="Enter PAN number" value="${user.panNo}"
							readonly />
					</div>
				</div>
				<div class="form-group row">
					<label for="address" class="col-sm-2 col-form-label">Address</label>
					<div class="col-sm-10">
						<textarea class="form-control" id="address" rows="3"
							name="address" placeholder="Enter address">${user.address}</textarea>
					</div>
				</div>
				<div class="form-group row">
					<label for="dob" class="col-sm-2 col-form-label">Date of
						Birth</label>
					<div class="col-sm-10">
						<input type="date" class="form-control" id="dob" name="dob"
							value="${user.dob}">
					</div>
				</div>
				<div class="row justify-content-center mt-5">
					<button type="submit" class="btn btn-primary mx-auto">Update
						Details</button>
				</div>
			</form>
		</div>
		
		
	</div>
	
	
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

	<!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
		crossorigin="anonymous"></script>
</body>
</html>