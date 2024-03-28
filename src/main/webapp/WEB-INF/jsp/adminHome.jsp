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
body,.navbar-custom {
	/* background-image: url("${pageContext.request.contextPath}\back.webp");
	background-color: #5cdb95; */
  /*background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);*/
  background-color: #cccccc;
}

.userprofile{
    background-color: #022950;
    border-radius: 25px;
    color: white;
    /*font-size: larger;*/
    font-family: "Lucida Console", "Courier New", monospace;
}
input{
    opacity: 0.8;
}
.userprofileForm{
    border-radius: 25px;
}

.nav-link{
    font-family: Arial, Helvetica, sans-serif;
    font-weight: 200;
    color: #022950;
}
.navbar-brand{
    color: #022950;
    font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
    font-weight: 400;
}
.card{
    background-color: #557a95;
    border-radius: 25px;
}
.card-text,h5{
    color: #d4bfae;
}

</style>
<title>Admin|Home</title>
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
					<li class="nav-item ${req == '' ? 'active' : ''} mx-2"><a
						class="nav-link" href="/adminApi/adminHome">Home</a></li>
					<li class="nav-item ${req == 'Users' ? 'active' : ''} mx-2"><a
						class="nav-link" href="/adminApi/allUsers">Users</a></li>
					<li class="nav-item ${req == 'Accounts' ? 'active' : ''} mx-2">
						<a class="nav-link" href="/adminApi/allAccounts">Accounts</a>
					</li>
				</ul>
			</div>

			<div class="form-inline">
				<div class="dropdown">
					<a class="navbar-brand btn dropdown-toggle mx-5" href="#"
						role="button" data-toggle="dropdown" aria-expanded="false" style="font-weight: bolder;">
						Welcome Admin </a>

					<div class="dropdown-menu">
						<a class="dropdown-item" href="/userApi/logout">Logout</a>
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

		<!-- Body Part -->
		<div class="container mx-auto row">

			<!-- Chooses between Accounts and Users -->
			<c:choose>
				<c:when test="${req==''}">
					<div class="col-sm-6 mt-3 mx-auto ">
						<div class="shadow container userprofile">
							<div class="row justify-content-center my-5 pt-5">
								<h2>Get User Profile</h2>
							</div>
							<form class="mx-auto my-5 w-50 pb-3 userprofileForm" action="/adminApi/getUser"
								method="post">
								<div class="form-group row">
									<label for="userId" class="col-sm-5 col-form-label">User Id</label>
									<div class="col-sm-7">
										<input class="form-control" id="userId" name="userId" required>
									</div>
								</div>

								<div class="row justify-content-center my-5">
									<button type="submit" class="btn btn-primary mx-4">Fetch</button>
								</div>
							</form>
						</div>
					</div>

					<div class="col-sm-6 mt-3 mx-auto ">
						<div class="shadow container userprofile">
							<div class="row justify-content-center my-5 pt-5">
								<h2>Get User Account</h2>
							</div>
							<form class="mx-auto my-5 w-50 pb-3 userprofileForm"
								action="/adminApi/getAccount" method="post">
								<div class="form-group row">
									<label for="accountId" class="col-sm-5 col-form-label">Acc
										Id </label>
									<div class="col-sm-7">
										<input class="form-control" id="accountId" name="accountId" required>
									</div>
								</div>

								<div class="row justify-content-center my-5">
									<button type="submit" class="btn btn-primary mx-4">Fetch</button>
								</div>
							</form>
						</div>
					</div>
				</c:when>

				<c:when test="${req=='Users'}">
					<table class="table table-striped my-3">
						<thead class="thead-dark">
							<tr class="justify-content-center">
								<th scope="col">User ID</th>
								<th scope="col">Name</th>
								<th scope="col">Email</th>
								<th scope="col">Phone No</th>
								<th scope="col">Pan No</th>
								<th scope="col">Address</th>
								<th scope="col">DOB</th>
								<th scope="col"></th>
								<th scope="col"></th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${fn:length(users) == 0}">
									<tr class="justify-content-center">
										<td colspan="5" class="text-center">No data found</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="user" items="${users}">
										<tr class="justify-content-center">
											<td>${user.userId}</td>
											<td>${user.name}</td>
											<td>${user.email}</td>
											<td>${user.phnNo}</td>
											<td>${user.panNo}</td>
											<td>${user.address}</td>
											<td>${user.dob}</td>
											<td><a href="/adminApi/updateUser/${user.userId}"
												class="btn btn-outline-success mx-auto">Update</a></td>
											<td><a onclick="deleteProfile(${user.userId})"
												class="btn btn-outline-danger mx-auto">Delete</a></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</c:when>

				<c:when test="${req=='Accounts'}">
					<table class="table table-striped my-3">
						<thead class="thead-dark">
							<tr class="justify-content-center">
								<th scope="col">Account ID</th>
								<th scope="col">User ID</th>
								<th scope="col">Account Type</th>
								<th scope="col">Balance</th>
								<th scope="col">Created On</th>
								<th scope="col">Account Status</th>
								<th scope="col"></th>
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
											<td>${account.userId}</td>
											<td>${account.accountType}</td>
											<td>${account.balance}</td>
											<td>${account.createdOn}</td>
											<td>${account.accountStatus}</td>
											<c:choose>
												<c:when test="${account.userId != null}">
													<td><a
														href="/adminApi/updateAccount/${account.accountId }"
														class="btn btn-outline-success mx-auto">Update Account</a></td>
												</c:when>
												<c:otherwise>
													<td></td>
												</c:otherwise>
											</c:choose>
											<td><a onclick="deleteAccount(${account.accountId})"
												class="btn btn-outline-danger mx-auto">Delete Account</a></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</c:when>

				<c:when test="${req=='Account'}">
					<c:choose>
						<c:when test="${account == null }">
							<div class="container row justify-content-center pt-5">
								<div class="card w-50">
									<div class="card-body">
										<h4 class="card-title">No Data found for the given
											Account ID.</h4>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="container row justify-content-center pt-5">
								<div class="card w-50">
									<div class="card-body">
										<h4 class="card-title">Account Id : ${account.accountId }</h4>
										<p class="card-text">
										<h5>User Id : ${account.userId }</h5>
										<h5>Account Type : ${account.accountType }</h5>
										<h5>Balance : ${account.balance }</h5>
										<h5>Created On : ${account.createdOn }</h5>
										<h5>Account Status : ${account.accountStatus }</h5>
										</p>
										<c:choose>
											<c:when test="${account.userId != null}">
												<a href="/adminApi/updateAccount/${account.accountId }"
													class="btn btn-success mx-auto mt-2">Update Account</a>
											</c:when>
											<c:otherwise>
												<td></td>
											</c:otherwise>
										</c:choose>
										<a onclick="deleteAccount(${account.accountId})"
											class="btn btn-danger mx-auto">Delete Account</a>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:when>

				<c:when test="${req=='User'}">
					<c:choose>
						<c:when test="${user == null }">
							<div class="container row justify-content-center pt-5">
								<div class="card w-50">
									<div class="card-body">
										<h4 class="card-title">No Data found for the given User
											ID.</h4>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="container row justify-content-center pt-5">
								<div class="card w-50">
									<div class="card-body">
										<h4 class="card-title">User Id : ${user.userId }</h4>
										<p class="card-text">
										<h5>Name : ${user.name }</h5>
										<h5>Email : ${user.email }</h5>
										<h5>Phone No : ${user.phnNo }</h5>
										<h5>Pan No : ${user.panNo }</h5>
										<h5>Address : ${user.address }</h5>
										<h5>DOB : ${user.dob }</h5>
										
										<a href="/adminApi/updateUser/${user.userId}"
											class="btn btn-success mx-auto mt-2">Update</a> <a
											onclick="deleteAccount(${account.accountId})"
											class="btn btn-danger mx-auto">Delete Account</a>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:when>
			</c:choose>
		</div>


		<!-- Delete Profile Modal -->
		<div class="modal fade" id="deleteProfileModal" tabindex="-1"
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
						<p>Are you sure you want to delete this Profile!</p>
					</div>
					<form class="modal-footer" action="/adminApi/deleteUser"
						method="get">
						<input type="hidden" id="userId" name="userId"> <input
							type="submit" value="Delete Profile" class="btn btn-danger">
					</form>
				</div>
			</div>
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
						<p>Are you sure you want to delete this Account!</p>
					</div>
					<form class="modal-footer" action="/adminApi/deleteAccount"
						method="post">
						<input type="hidden" id="accountId" name="accountId"> <input
							type="submit" value="Delete Account" class="btn btn-danger">
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

	<!-- Displays Delete Profile modal -->
	<script>
	function deleteProfile(userId) {
    // Set the modal input
    	document.getElementById("userId").value = userId;
		//console.log(accountId);
    // Show the modal
    $("#deleteProfileModal").modal("show");
  }
</script>

	<!-- Displays Delete Account modal -->
	<script>
	function deleteAccount(accountId) {
    // Set the modal input
    	document.getElementById("accountId").value = accountId;
		//console.log(accountId);
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