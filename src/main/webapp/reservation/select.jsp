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
		let count = parseInt($('.btn-group .btn-info').text()); // 초기 인원 수
		let price = count * 15000; // 초기 가격 설정
		let selectedCount = 0; // 초기 선택된 좌석 수
		
		updatePriceAndButtonState();
		
		$('.btn-group button').click(function() {
			$(this).removeClass('btn-light').addClass('btn-info');
			$(this).siblings().removeClass('btn-info').addClass('btn-light');

			$('.seat.selected').removeClass('selected');
			$('#seatName').text('');
			
			count = parseInt($('.btn-group .btn-info').text());
			price = count * 15000;
			updatePriceAndButtonState(); // 인원 수 변경 시 가격 업데이트 및 버튼 상태 업데이트
		});

		$('.seat').click(function() {
			let seatName = $(this).text().trim();

			if ($(this).hasClass('selected')) {
				$(this).removeClass('selected');
				updateSelectedSeatsList(seatName, false); // 선택 해제 시 좌석 목록 업데이트
			} else {
				if (selectedCount < count) {
					$(this).addClass('selected');
				 	updateSelectedSeatsList(seatName, true); // 선택 시 좌석 목록 업데이트
				}
			}
			updatePriceAndButtonState();
		});
		
		
		 function updateSelectedSeatsList(seatName, isSelected) {
	            let currentSeatNames = $('#seatName').text().trim();
	            let updatedSeatNames = currentSeatNames.split(' ');

	            if (isSelected) {
	                updatedSeatNames.push(seatName);
	            } else {
	                updatedSeatNames = updatedSeatNames.filter(name => name !== seatName);
	            }

	            $('#seatName').text(updatedSeatNames.join(' '));
	            $('input[name="seat"]').val(updatedSeatNames.join(' '));
	        }

	        function updatePriceAndButtonState() {
	            selectedCount = $('.seat.selected').length; // 선택된 좌석 수 업데이트

	            $('#price').text(price + '원'); // 가격 업데이트

	            // 선택된 좌석 수와 인원 수가 일치할 때 결제 버튼 활성화
	            if (selectedCount === count) {
	                $("#paymentBtn").prop("disabled", false);
	            } else {
	                $("#paymentBtn").prop("disabled", true);
	            }
	        }
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
					<div class="btn-group mx-3 border border-3 me-5" role="group"
						aria-label="First group">
						<button type="button" class="btn btn-info btn-lg">1</button>
						<button type="button" class="btn btn-light btn-lg">2</button>
						<button type="button" class="btn btn-light btn-lg">3</button>
						<button type="button" class="btn btn-light btn-lg">4</button>
					</div></li>
			<li class="mx-5"></li>
			<li>
				<div class="seat"></div> <small>선택<br>가능</small>
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
						<div class="row align-items-center">
							<div class="col-4">
							<img class="bd-placeholder-img" width="80" height="120" src="${schedule.movie.posterUrl}" />
							</div>
							<div class="col-8">
								<strong class="d-inline-block mb-2 text-primary-emphasis">${schedule.movie.title}</strong>
								<small>(${schedule.movie.runtime}분)</small><br><small>${schedule.movie.rating}</small>
							</div>
						</div>
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
							<input id="paymentBtn" type="submit" class="btn btn-danger btn-lg px-4 py-4"
								value="결제하기" disabled=true> <input type="hidden" name="no"
								value="${schedule.no}"> <input type="hidden" name="seat">
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>
	<footer
		class="d-flex flex-wrap justify-content-center align-items-center py-3 border-top bg-secondary"
		style="--bs-bg-opacity: .1;">
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</footer>
</body>
</html>