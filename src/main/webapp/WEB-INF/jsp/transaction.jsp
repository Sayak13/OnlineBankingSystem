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

<title>Transactions</title>
</head>
<body>
	<%
	session = request.getSession();
	Object attribute = session.getAttribute("user");
	if (attribute == null) {
		response.sendRedirect("index");
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

		<div class="container">
			<c:choose>
				<c:when test="${req=='NEW TRANSACTION'}">
				<div class="container shadow">
					<div class="row justify-content-center my-5 pt-3">
						<h2>Send Money</h2>
					</div>
					<form class="mx-auto my-5 w-50 pb-3" action="/transactionApi/create"
						method="post">
						<div class="form-group row">
							<label for="senderAccountId" class="col-sm-4 col-form-label">Sender's
								Account Id :</label>
							<div class="col-sm-8">
								<select class="form-control" id="senderAccountId"
									name="senderAccountId">
									<option value="">Select an option..</option>
									<c:forEach var="account" items="${accounts}">
										<option value="${account.accountId}">${account.accountId}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label for="receiverAccountId" class="col-sm-4 col-form-label">Receiver's
								Account Id :</label>
							<div class="col-sm-8">
								<input type="number" class="form-control" id="receiverAccountId"
									name="receiverAccountId" placeholder="Enter Account ID">
							</div>
						</div>
						<div class="form-group row">
							<label for="amount" class="col-sm-4 col-form-label">Enter
								Amount :</label>
							<div class="col-sm-8">
								<input type="number" class="form-control" id="amount"
									name="amount" placeholder="Enter Amount">
							</div>
						</div>
						<div class="row justify-content-center my-5">
							<button type="submit" class="btn btn-primary mx-4">Send</button>
							<a href="/userApi/home" class="btn btn-primary mx-4">Home</a>
						</div>
					</form>
					</div>
				</c:when>

				<c:when test="${req=='TRANSACTION HISTORY FORM'}">
				<div class="container shadow">
					<div class="row justify-content-center my-5 pt-3">
						<h2>Transaction History</h2>
					</div>
					<form class="mx-auto my-5 w-50 pb-3"
						action="/transactionApi/transactionhistory" method="post">
						<div class="form-group row justify-content-center mb-3">
							<div class="col-sm-6">
								<select class="form-control" id="accountId" name="accountId">
									<option value="">Select Account ID..</option>
									<c:forEach var="account" items="${accounts}">
										<option value="${account.accountId}">${account.accountId}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group row pt-3">
							<div class="col-sm-2"></div>
							<label for="startDate" class="col-sm-3 col-form-label">From</label>
							<div class="col-sm-5">
								<input type="date" class="form-control" id="startDate"
									name="startDate">
							</div>
							<div class="col-sm-2"></div>
						</div>
						<div class="form-group row">
							<div class="col-sm-2"></div>
							<label for="endDate" class="col-sm-3 col-form-label">To</label>
							<div class="col-sm-5">
								<input type="date" class="form-control" id="endDate"
									name="endDate">
							</div>
							<div class="col-sm-2"></div>
						</div>
						
						<div class="row justify-content-center my-5">
							<button type="submit" class="btn btn-primary mx-4">Submit</button>
							<a href="/userApi/home" class="btn btn-primary mx-4">Home</a>
						</div>
					</form>
					</div>
				</c:when>
				
				<c:when test="${req=='TRANSACTION HISTORY'}">
					<table class="table table-striped my-5">
						<thead class="thead-dark">
							<tr class="justify-content-center">
								<th scope="col">Date</th>
								<th scope="col">Transaction ID</th>
								<th scope="col">Transaction Type</th>
								<th scope="col">Sender Account ID</th>
								<th scope="col">Receiver Account ID</th>
								<th scope="col">Amount</th>
								<th scope="col">Transaction Status</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${fn:length(transactions) == 0}">
									<tr class="justify-content-center">
										<td colspan="7" class="text-center">No data found</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="transaction" items="${transactions}">
										<tr class="justify-content-center">
											<td>${transaction.transactionTime}</td>
											<td>${transaction.transactionId}</td>
											<td>
												<c:choose>
													<c:when test="${accountId == transaction.senderAccountId}">
														DEBIT
													</c:when>
													<c:otherwise>
														CREDIT
													</c:otherwise>
												</c:choose>
											</td>
											<td>${transaction.senderAccountId}</td>
											<td>${transaction.receiverAccountId}</td>
											<td>${transaction.amount}</td>
											<td>${transaction.transactionStatus}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div class="row justify-content-center my-5">
							<a href="/userApi/home" class="btn btn-primary mx-4">Home</a>
							<a href="/transactionApi/transactionHistory" class="btn btn-primary mx-4">Back</a>
					</div>
				</c:when>
			</c:choose>
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