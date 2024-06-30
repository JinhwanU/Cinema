<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="/Cinema-WEB/resources/css/my.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
$(document).ready(function(){
	$('#agreeChk').click(function() {
		$("#paymentBtn").prop("disabled", !$('#paymentBtn').prop("disabled"));
	});
	$('#seatName').val($('#seat').text().trim());
})

</script>
</head>
<body class="bg-light">
	<header class="p-3 text-bg-dark">
		<jsp:include page="/include/topMenu.jsp"></jsp:include>
	</header>
	<main class="py-3">
		    <div class="py-5 text-center">
      <h1 class="fw-bolder">예매 확인</h1>
      <p class="lead">현재 결제시스템은 지원하지 않습니다.</p>
    </div>

    <div class="row g-5">
      <div class="col-md-5 col-lg-4 order-md-last">
        <h4 class="d-flex justify-content-between align-items-center mb-3">
          <span class="text-primary">결제</span>
        </h4>
        <ul class="list-group mb-3">
          <li class="list-group-item d-flex justify-content-between lh-sm">
            <div>
              <h6 class="my-0">결제하실 금액</h6>
              <small class="text-body-secondary">일반(15,000) * ${count}명</small>
            </div>
            <span class="text-body-secondary">${count*15000} 원</span>
          </li>
          <li class="list-group-item d-flex justify-content-between">
            <span>Total (KRW)</span>
            <strong>${count*15000} 원</strong>
          </li>
        </ul>
		<div class="form-check mb-3">
            <label class="form-check-label" for="save-info">결제에 동의합니다</label>
            <input type="checkbox" class="form-check-input" id="agreeChk">
          </div>
        <div class="d-grid">
			<form action="complete.do" method="post" onsubmit="">
	        	<input type="hidden" name="movieNo" value="${schedule.movieNo}">
	        	<input type="hidden" name="scheduleNo" value="${schedule.no}">
	        	<input type="hidden" name="headcount" value="${count}">
	        	<input type="hidden" name="payment" value="${count*15000}">
	        	<input id="seatName" type="hidden" name="seatName">
    	    	<input type="submit" id="paymentBtn" class="btn btn-danger col-12" disabled="true" value="결제하기">
        	</form>
        </div>	
      </div>
      
      <div class="col-md-7 col-lg-8">
        <h3 class="mb-3 fw-bold">예매 내역 확인</h3>
          <div class="row g-3">
            <div class="col-sm-6">
              <p class="fw-bold">영화 제목</p>
              <p>${schedule.movie.title}</p>
            </div>

            <div class="col-12">
              <p class="fw-bold">상영날짜</p>
              <p>${schedule.screenTime}</p>
            </div>


            <div class="col-12">
              <p class="fw-bold">상영관</p>
              <p>${schedule.theaterName}관</p>
            </div>

            <div class="col-12">
              <p class="fw-bold">좌석번호</p>
              <p id="seat">
              <c:forEach var="seat" items="${seatList}">
              	${seat}&nbsp;
			  </c:forEach>
			  </p>
            </div>


          <hr class="my-4">

          <h4 class="mb-3">결제수단</h4>

          <div class="my-3">
            <div class="form-check">
              <input id="credit" name="paymentMethod" type="radio" class="form-check-input" checked required>
              <label class="form-check-label" for="credit">신용카드</label>
            </div>
            <div class="form-check">
              <input id="debit" name="paymentMethod" type="radio" class="form-check-input" required>
              <label class="form-check-label" for="debit">휴대폰 결제</label>
            </div>
            <div class="form-check">
              <input id="paypal" name="paymentMethod" type="radio" class="form-check-input" required>
              <label class="form-check-label" for="paypal">간편 결제</label>
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