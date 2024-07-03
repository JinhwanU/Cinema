<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매내역</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="/Cinema-WEB/resources/css/my.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">
	<header class="p-3 text-bg-dark">
		<jsp:include page="/include/topMenu.jsp"></jsp:include>
	</header>
	<main style="max-width: 1200px;">
		<h1 class="fw-bolder text-center m-5">예 매 내 역</h1>
		<table class="table table-hover table-striped align-middle table-sm mt-3" style="width: 100%;">
			<tr class="table-primary">
				<th class="text-center p-3" width="10%">예매번호</th>
				<th class="text-center" width="17%">영화제목</th>
				<th class="text-center" width="7%">상영관</th>
				<th class="text-center" width="18%">상영일시</th>
				<th class="text-center" width="5%">인원</th>
				<th class="text-center" width="15%">좌석</th>
				<th class="text-center" width="10%">결제금액</th>
				<th class="text-center" width="18%">예약일시</th>
			</tr>
				<c:forEach var="reserv" items="${ reservList }">
					<tr>
						<td align="center" class="p-3">${ reserv.no }</td>
						<td align="center">${ reserv.movie.title }</td>
						<td align="center">${ reserv.schedule.theaterName }관</td>
						<td align="center">${ reserv.schedule.screenTime }</td>
						<td align="center">${ reserv.headcount }</td>
						<td align="center">${ reserv.seatName }</td>
						<td align="center">${ reserv.payment }원</td>
						<td align="center">${ reserv.regDate }</td>
					</tr>
				</c:forEach>
		</table>
	</main>
	<footer
		class="d-flex flex-wrap justify-content-center align-items-center py-3 my-4 border-top bg-secondary"
		style="--bs-bg-opacity: .1;">
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</footer>
</body>
</html>