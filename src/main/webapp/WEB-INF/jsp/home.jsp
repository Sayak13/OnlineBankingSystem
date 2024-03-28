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
	img{
		height: 10rem;
		
	}
	body{
		background-image: url("${pageContext.request.contextPath}\back.webp");
		background-color: #cccccc;
	}
</style>

<title>Home</title>
</head>
<body>
	<%
	session = request.getSession();
	Object attribute = session.getAttribute("user");
	if (attribute == null) {
		response.sendRedirect("/userApi/index");
		return;
	}
	%>

	<div>
		<!-- Nav Bar -->
		<nav class="navbar navbar-dark bg-dark">
			<a class="navbar-brand mx-5" style="font-weight: bolder;">BOSE BANK</a>
			<div class="form-inline">
				<div class="dropdown">
					<a class="navbar-brand btn dropdown-toggle mx-5" href="#"
						role="button" data-toggle="dropdown" aria-expanded="false">
						Welcome ${sessionScope.user.name} </a>

					<div
						class="dropdown-menu border-0 row justify-content-center mx-auto">
						<a href="/userApi/update" class="dropdown-item">Update
							Profile</a> <a class="dropdown-item" href="/userApi/logout">Logout</a>
						<a class="dropdown-item" data-toggle="modal"
							data-target="#deleteUser">Delete Profile</a>
					</div>
				</div>
			</div>
		</nav>

		<!-- alerts -->
		<c:if test="${not empty msg}">
			<div class="alert alert-success alert-dismissible fade show"
				role="alert">
				${msg }
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
		</c:if>

		<c:if test="${not empty errors}">
			<div class="alert alert-danger alert-dismissible fade show"
				role="alert">
				${errors }
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
		</c:if>

		<!-- Style testing -->
		<c:choose>
				<c:when test="${req=='Home'}">
		<div class="container my-5 mx-auto row">
			<div class="col-sm-4">
				<div class="card shadow-lg" style="width: 18rem;">
					<img src="${pageContext.request.contextPath}\accounts.jpg"
						class="card-img-top" alt="...">
					<form action="/accountApi/getAccountByUser/${sessionScope.user.userId}"
				method="get" class="card-body">
						<h5 class="card-title">Accounts</h5>
						<p class="card-text">All your accounts on your finger tips. Click the button the view all accounts.</p>
						<input type="submit" value="Accounts" class="btn btn-primary">
					</form>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="card shadow-lg" style="width: 18rem;">
					<img src="${pageContext.request.contextPath}\createAccount.webp"
						class="card-img-top" alt="..." style="object-fit: contain;">
					<div class="card-body">
						<h5 class="card-title">Create New Account</h5>
						<p class="card-text">You can create account in our bank without visiting us manually. Click here to Create Account!</p>
						<button class="btn btn-primary" data-toggle="modal"
				data-target="#createAccount">Create Account</button>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="card shadow-lg" style="width: 18rem;">
					<img src="${pageContext.request.contextPath}\sendMoney.jpg"
						class="card-img-top" alt="..." style="object-fit: contain;">
					<div class="card-body">
						<h5 class="card-title">Send Money</h5>
						<p class="card-text">Send money to anyone anywhere via our bank without any trouble and great security.</p>
						<a href="/transactionApi/newTransaction" class="btn btn-primary">Send Money</a>
					</div>
				</div>
			</div>
		</div>
		<div class="container my-5 mx-auto row justify-content-center">
			<div class="col-sm-4">
				<div class="card shadow-lg" style="width: 18rem;">
					<img src="${pageContext.request.contextPath}\transactionH.jpg"
						class="card-img-top" alt="..." style="object-fit: contain;">
					<div class="card-body">
						<h5 class="card-title">Transaction History</h5>
						<p class="card-text">Get your transaction history by just clicking on a button!</p>
						<br>
						<a href="/transactionApi/transactionHistory" class="btn btn-primary">Transaction History</a>
					</div>
				</div>
			</div>
		</div>
		</c:when>
		</c:choose>

		<!-- Display On Button Click -->
		<div class="row justify-content-center m-3" id="accounts">
			<!-- Displays Account & Transaction Details -->
			<c:choose>
				<c:when test="${req=='Account Details'}">
					<table class="table table-striped">
						<thead class="thead-dark">
							<tr class="justify-content-center">
								<th scope="col">Account ID</th>
								<th scope="col">Account Type</th>
								<th scope="col">Balance</th>
								<th scope="col">Created On</th>
								<th scope="col">Account Status</th>
								<th scope="col"></th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${fn:length(accounts) == 0}">
									<tr class="justify-content-center">
										<td colspan="5" class="text-center">No data found</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="account" items="${accounts}">
										<tr class="justify-content-center">
											<td>${account.accountId}</td>
											<td>${account.accountType}</td>
											<td>${account.balance}</td>
											<td>${account.createdOn}</td>
											<td>${account.accountStatus}</td>
											<td><a onclick="deleteAccount(${account.accountId})"
												class="btn btn-outline-danger mx-auto">Delete Account</a></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div class="row justify-content-center">
						<a href="/userApi/home" class="btn btn-outline-success">Home</a>
					</div>
				</c:when>
			</c:choose>
		</div>

		<!-- Delete Account Modal -->
		<div class="modal fade" id="deleteAccountModal" tabindex="-1"
			role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p>Are you sure you want to delete your Account!</p>
					</div>
					<form class="modal-footer" action="/accountApi/delete"
						method="post">
						<input type="hidden" id="accountId" name="accountId"> <input
							type="submit" value="Delete Account" class="btn btn-danger">
					</form>
				</div>
			</div>
		</div>

		<!-- Delete Profile Modal -->
		<div class="modal" tabindex="-1" id="deleteUser">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<h5>Are you sure you want to delete your profile!</h5>
					</div>
					<div class="modal-footer">
						<a href="deleteUser/${sessionScope.user.userId}"
							class="btn btn-danger mx-auto">Delete Profile</a>
					</div>
				</div>
			</div>
		</div>

		<!-- Create Account Modal -->
		<div class="modal fade modal-dialog modal-dialog-centered"
			id="createAccount" data-backdrop="static" data-keyboard="false"
			tabindex="-1" aria-labelledby="staticBackdropLabel"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="mx-auto">
						<h5 id="staticBackdropLabel">Create New Account</h5>
					</div>

					<!-- Form to call createAccount -->
					<form action="/accountApi/create" method="post">
						<div class="modal-body">

							<div class="form-group">
								<label for="userId">User Id :</label> <input type="number"
									class="form-control" id="userId" name="userId"
									value="${sessionScope.user.userId}" readonly />
							</div>

							<div class="form-group">
								<label for="name">Customer Name :</label> <input type="text"
									class="form-control" id="name" name="name"
									value="${sessionScope.user.name}" readonly />
							</div>

							<div class="form-group">
								<label for="panNo">Pan No :</label> <input type="text"
									class="form-control" id="panNo" name="panNo"
									value="${sessionScope.user.panNo}" readonly />
							</div>

							<div class="form-group">
								<label for="accountType">Account Type :</label> <select
									class="form-control" id="accountType" name="accountType">
									<option value="">Select an option..</option>
									<option value="SAVINGS">SAVINGS</option>
									<option value="CURRENT">CURRENT</option>
								</select>
							</div>

							<div class="form-group">
								<label for="balance">Starting Balance :</label> <input
									type="number" class="form-control" id="balance" name="balance">
							</div>

							<div class="form-group">
								<input type="hidden" class="form-control" id="accountStatus"
									name="accountStatus" value="ACTIVE">
							</div>

						</div>

						<div class="modal-footer">
							<button type="submit" class="btn btn-primary mx-auto">Create
								Account</button>
						</div>
					</form>
				</div>
			</div>
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

	<!-- Displays Delete Account modal -->
	<script>
	function deleteAccount(accountId) {
    // Set the modal input
    	document.getElementById("accountId").value = accountId;
		console.log(accountId);
    // Show the modal
    $("#deleteAccountModal").modal("show");
  }
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