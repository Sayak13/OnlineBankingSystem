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
					<li class="nav-item mx-2"><a
						class="nav-link" href="/adminApi/adminHome">Home</a></li>
					<li class="nav-item mx-2"><a
						class="nav-link" href="/adminApi/allUsers">Users</a></li>
					<li class="nav-item active mx-2">
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


		<div class="container w-50 my-5 shadow">

			<div class="row justify-content-center mt-3 pt-3">
				<h2>Account Details</h2>
			</div>

			<form class="mx-auto my-3 pb-3" action="/adminApi/updateAccount"
				method="post">

				<div class="form-group">
					<label for="userId">Account Id :</label> <input type="number"
						class="form-control" id="accountId" name="accountId"
						value="${account.accountId}" readonly />
				</div>

				<div class="form-group">
					<label for="userId">User Id :</label> <input type="number"
						class="form-control" id="userId" name="userId"
						value="${account.userId}" readonly />
				</div>

				<div class="form-group">
					<label for="accountType">Account Type :</label> <select
						class="form-control" id="accountType" name="accountType">
						<option value="SAVINGS"
							${account.accountType == 'SAVINGS' ? 'selected' : ''}>SAVINGS</option>
						<option value="CURRENT"
							${account.accountType == 'CURRENT' ? 'selected' : ''}>CURRENT</option>
					</select>
				</div>

				<div class="form-group">
					<label for="balance">Balance :</label> <input type="number"
						class="form-control" id="balance" name="balance"
						value=${account.balance}>
				</div>

				<div class="form-group">
					<label for="accountStatus">Account Status :</label> <select
						class="form-control" id="accountStatus" name="accountStatus">
						<option value="ACTIVE"
							${account.accountStatus == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
						<option value="INACTIVE"
							${account.accountStatus == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
					</select>
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