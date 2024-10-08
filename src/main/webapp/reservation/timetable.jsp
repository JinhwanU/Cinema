<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영시간표</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="/Cinema-WEB/resources/css/my.css" rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
/* Custom styles for vertical scrollable list group */
main {
	height: 800px; /* Set maximum height for scrollbar */
	max-width: 1400px;
}

.list-group {
	height: 500px;
}
</style>
<script>
$(document).ready(function() {
    let movieNo = $('#movieList').find('.active').data('movie-no');
    let date = $('#dateList').find('.active').data('date');
    
    fetchSchedule(movieNo, date);

    function fetchSchedule(movieNo, date) {
        fetch('ajax/schedule.jsp', {
            method: 'POST',
            body: new URLSearchParams({
                movieNo: movieNo,
                date: date
            })
        })
        .then(response => response.json())
        .then(data => appendSchedule(data))
        .catch(error => console.error('Error :', error));
    }

    function appendSchedule(data) {
        $("#scheduleList").empty();
        const now = new Date();
        now.setMinutes(now.getMinutes() + 30);
        
        data.forEach(schedule => {
            var time = new Date(schedule.screenTime); // 상영 시간
            var isPast = time < now; // 상영 시간이 현재 시간보다 이전인지 확인
            
            var html = '<a href="#" name="schedule" class="list-group-item list-group-item-action py-3 px-3 lh-tight';
            if (isPast || schedule.seatCnt <= 0) {
                html += ' disabled';
            }
            html += '" data-bs-toggle="list" data-no="' + schedule.no + '">';
            
            html += '<div class="row">';
            html += '<strong class="col-md-2 mb-1">' + formatTime(time) + '<br>';
            time.setMinutes(time.getMinutes() + schedule.movie.runtime);
            html += '<small>~' + formatTime(time) + '</small></strong>';
            html += '<strong class="col-md-6 mx-1 px-2">' + schedule.movie.title + '<br></strong>';
            html += '<div class="col-md-3 text-end">';
            html += '<small>' + schedule.theaterName + '관<br>' + schedule.seatCnt + '/80';
            html += '</small></div></div></a>';

            $('#scheduleList').append(html);
        });
        updateSelectSeatButton();
    }
    
    function updateSelectSeatButton() {
        $("#selectSeatBtn").prop("disabled", $('a[name="schedule"].active').length === 0);
    }

    $('main').on('click', 'a[name="movie"]', function() {
        let selectedMovieNo = $(this).data('movie-no');
        let selectedDate = $('#dateList').find('.active').data('date');

        fetchSchedule(selectedMovieNo, selectedDate);
    });

    $('main').on('click', 'a[name="date"]', function() {
        let selectedDate = $(this).data('date');
        let selectedMovieNo = $('#movieList').find('.active').data('movie-no');

        fetchSchedule(selectedMovieNo, selectedDate);
    });

    $('main').on('click', 'a[name="schedule"]', function() {
    	updateSelectSeatButton()
    });

    function formatTime(date) {
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        return hours + ":" + minutes;
    }
    
	$('#selectSeatBtn').on('click', function() {
		let no= $('#scheduleList').find('.active').data('no');
		location.href="select.do?no="+no
	})
});

</script>
</head>
<body class="bg-light">
	<header class="p-3 text-bg-dark">
		<jsp:include page="/include/topMenu.jsp"></jsp:include>
	</header>
	<main class="py-3">
		<div class="row">
		<div class="col-2"></div>
		<div class="col-8">
			<div class="row fw-bolder my-3">
				<h1>예매하기</h1>
			</div>
			<div class="row border">
				<div class="col-5 px-0 border-end">
					<div
						class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white">
						<a
							class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom justify-content-center">
							<span class="fs-5 fw-semibold text-center">영화</span>
						</a>
						<div id="movieList"
							class="list-group list-group-flush border-bottom scrollarea overflow-auto"
							data-bs-toggle="list">
							<c:forEach var="movie" items="${movieList}">
								<a href="#" name=movie
									class="list-group-item list-group-item-action py-3 lh-tight"
									data-bs-toggle="list" data-movie-no="${movie.no}">
									<div class="row">
										<small class="col-md-4 mb-1 pe-1">${movie.rating}</small> 
										<strong class="col-md-8">${ movie.title }<br></strong>
									</div>
								</a>
							</c:forEach>
						</div>
					</div>
				</div>

				<div class="col-2 px-0 border-end">
					<div
						class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white">
						<a
							class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom justify-content-center">
							<span class="fs-5 fw-semibold text-center">날짜</span>
						</a>
						<div id="dateList"
							class="list-group list-group-flush border-bottom scrollarea overflow-auto"
							data-bs-toggle="list">
							<c:forEach var="date" items="${ dateList }" varStatus="status">
								<a href="#" data-date="${date.date}" name=date
									class="list-group-item list-group-item-action py-3 px-1 lh-tight ${status.first ? 'active' : ''}"
									data-bs-toggle="list">
									<div class="d-flex justify-content-center">
										<p class="d-flex align-items-center mb-1">
											<strong class="ms-2">${date.formattedDate}</strong>
										</p>
									</div>
								</a>
							</c:forEach>
						</div>
					</div>
				</div>

				<div class="col-5 px-0">
					<div
						class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white">
						<a
							class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom justify-content-center">
							<span class="fs-5 fw-semibold">상영일정</span>
						</a>
						<div id="scheduleList"
							class="list-group list-group-flush border-bottom scrollarea overflow-auto"
							data-bs-toggle="list"></div>
					</div>
				</div>
			</div>
			<div class="row">
				<button id="selectSeatBtn" class="btn btn-danger" disabled=true>좌석선택</button>
			</div>
		</div>
		<div class="col-2">
		<a href="${ pageContext.request.contextPath }/reservation/integratedTimetable.do" style="text-decoration: none;">
		<div class="card" style="width: 18rem;">
		
		
			<div id="myCarousel" class="carousel slide mb-6" data-bs-ride="carousel">
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img class="bd-placeholder-img" width="100%" height="400px" src="http://file.koreafilm.or.kr/thm/02/00/03/47/tn_DPF03506A.jpg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="var(--bs-secondary-color)"/></svg>
        <div class="container">
          <div class="carousel-caption text-start">
          </div>
        </div>
      </div>
      <div class="carousel-item">
        <img class="bd-placeholder-img" width="100%" height="400px" src="http://file.koreafilm.or.kr/thm/02/99/18/45/tn_DPK022133.jpg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="var(--bs-secondary-color)"/></svg>
        <div class="container">
          <div class="carousel-caption">
          </div>
        </div>
      </div>
      <div class="carousel-item">
        <img class="bd-placeholder-img" width="100%" height="400px" src="http://file.koreafilm.or.kr/thm/02/99/17/92/tn_DPK020117.jpg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="var(--bs-secondary-color)"/></svg>
        <div class="container">
          <div class="carousel-caption text-end">
          </div>
        </div>
      </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>
		
		
		
		
			  <!-- <img src="http://file.koreafilm.or.kr/thm/02/00/03/47/tn_DPF03506A.jpg" class="card-img-top" alt="..."> -->
			  <div class="card-body">
			    <h5 class="card-title"> </h5>
			    <p class="card-text"><a class="text-danger" style="text-decoration: none">통합예매 서비스</a>에서<br>다양한 영화들을 찾아보세요</p>
			  </div>
			</div>
		</a>
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