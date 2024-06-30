<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석선택</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="/Cinema-WEB/resources/css/my.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
main {
	height: 800px; /* Set maximum height for scrollbar */
}

.row {
	display: flex;
}
</style>
<script>
	$(document).ready(function() {
		let selectedCount = $('.seat.selected').length;
		let count = $('.btn-group .btn-info').text()
		let price = count * 15000;
		$('.btn-group button').click(function() {

			$(this).removeClass('btn-light').addClass('btn-info');
			$(this).siblings().removeClass('btn-info').addClass('btn-light');

			$('.seat.selected').removeClass('selected');
			$('#seatName').text('');

			count = $('.btn-group .btn-info').text()
			price = count * 15000;
			$('#price').text(price + '원')

		});

		$('.seat').click(function() {
			let count = parseInt($('.btn-group .btn-info').text());
			let selectedCount = $('.seat.selected').length;
			let seatName = $(this).text().trim();

			if ($(this).hasClass('selected')) {
				$(this).removeClass('selected');

				let currentSeatNames = $('#seatName').text();
				let updatedSeatNames = currentSeatNames.replace(seatName, '');
				$('#seatName').text(updatedSeatNames.trim());

			} else {
				if (selectedCount < count) {
					$(this).addClass('selected');

					let currentSeatNames = $('#seatName').text().trim();
					if (currentSeatNames === '') {
						$('#seatName').text(seatName);
					} else {
						$('#seatName').text(currentSeatNames + ' ' + seatName);
					}
					$('input[name="seat"]').val($('#seatName').text().trim());
				}
			}
		});
	});
</script>

</head>
<body class="bg-light">
	<header class="p-3 text-bg-dark">
		<jsp:include page="/include/topMenu.jsp"></jsp:include>
	</header>
	<main class="py-3">

		<ul class="showcase container-fluid">
			<li><strong>인원수</strong>
				<div class="btn-toolbar" role="toolbar"
					aria-label="Toolbar with button groups">
					<div class="btn-group mx-3 border border-3" role="group"
						aria-label="First group">
						<button type="button" class="btn btn-info btn-lg">1</button>
						<button type="button" class="btn btn-light btn-lg">2</button>
						<button type="button" class="btn btn-light btn-lg">3</button>
						<button type="button" class="btn btn-light btn-lg">4</button>
					</div></li>
			<li class="me-5"><button type="button"
					class="btn btn-light btn-lg">선택 초기화</button></li>
			<li>
				<div class="seat"></div> <small>선택<br>가능
			</small>
			</li>
			<li>
				<div class="seat" style="background-color: #6feaf6;"></div> <small>선택</small>
			</li>
			<li>
				<div class="seat" style="background-color: #c0c0c0;"></div> <small>선택<br>불가
			</small>
			</li>
		</ul>

		<div class="container">
			<div
				class="screen text-light d-flex align-items-center justify-content-center">
				<h1 class="fw-bolder">Screen</h1>
			</div>

			<div class="row justify-content-center">
				<c:forEach var="seat" items="${schedule.seatList}"
					varStatus="status">
					<div data-seat-no="${seat.no}"
						class="seat ${seat.available==1 ? '' : 'occupied'} text-center text-white">
						${seat.seatName}</div>
					<c:if test="${(status.index + 1) % 10 == 0}">
			</div>
			<div class="row justify-content-center">
				</c:if>
				</c:forEach>
			</div>
		</div>
		<div class="container-fluid mt-3">
			<div class="row mb-2">
				<div
					class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative align-items-center justify-content-center">
					<div class="col-md-4">
						<img class="bd-placeholder-img" width="80" height="120"
							src="https://ojsfile.ohmynews.com/STD_IMG_FILE/2024/0613/IE003311810_STD.jpg" />
						<strong class="d-inline-block mb-2 text-primary-emphasis">${schedule.movie.title}</strong>
						<small>(${schedule.movie.runtime}분)</small>
					</div>
					<div class="col-md-2">
						<h3 class="mb-0">${schedule.theaterName}관</h3>
					</div>
					<div class="col-md-2">
						<h3 id="seatName" class="mb-0"></h3>

					</div>
					<div class="col-md-2">
						<h3 id="price" class="mb-0">15000원</h3>
					</div>
					<div class="col-md-2 d-none d-lg-block">
						<form action="payment.do" method="get">
							<input type="submit" class="btn btn-danger btn-lg px-4 py-4"
								value="결제하기"> <input type="hidden" name="no"
								value="${schedule.no}"> <input type="hidden" name="seat">
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>
	<footer
		class="d-flex flex-wrap justify-content-center align-items-center py-3 border-top bg-secondary"
		style="-bs-bg-opacity: .1;">
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</footer>
</body>
</html>