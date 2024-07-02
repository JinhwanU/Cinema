<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영일정 관리</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="/Cinema-WEB/resources/css/my.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
	$(document).ready(function(){
        const date = new Date();
        const yyyy = date.getFullYear();
        const mm = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
        const dd = String(date.getDate()).padStart(2, '0');

        const yesterday = yyyy+mm+dd;
        const formattedDate = yyyy + "-" + mm + "-" + dd;
        $('.datePicker').val(formattedDate);
        
        $('.datePicker').datepicker({
		       format: 'yyyy-mm-dd', //데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
		       startDate: '-0d', //달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
		       endDate: '+30d', //달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
		       autoclose: true, //사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
		       showWeekDays: true, // 위에 요일 보여주는 옵션 기본값 : true
		       todayHighlight: true, //오늘 날짜에 하이라이팅 기능 기본값 :false
		       toggleActive: false, //이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
		       language: 'ko', //달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
		    })
		fetchDataDaily(yesterday);
		
		$('#datePickerDaily').on('changeDate', function(e) {
            const selectedDate = $('#datePickerDaily').datepicker('getFormattedDate', 'yyyymmdd');
            fetchDataDaily(selectedDate);
        });

        
        function fetchDataDaily(date) {
            const params = {
                key: '411f58b805722fdde96de4f968b9de19',
                targetDt: date,
                itemPerPage: '10'
            };
            const url = 'http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?' + $.param(params);
            
            fetch(url)
                .then(response => response.json())
                .then(data => displayData('#dailyView', data.boxOfficeResult.dailyBoxOfficeList));
        }
        
        function displayData(target, list) {
            $(target).empty();
            
            list.forEach(movie => {
	            let html = '<tr>' +
                    '<td align="center">' + movie.rank + '</td>' +
                    '<td>' + movie.movieNm + '</td>' +
                    '<td align="right">' + salesAmtFormatted + '</td>' +
                    '<td align="right">' + audiCntFormatted + '</td>' +
                    '<td align="right">' + salesAccFormatted + '</td>' +
                    '<td align="right">' + audiAccFormatted + '</td>' +
                    '<td align="center" class="fw-bold '+ rankIntenClass +'">' + movie.rankInten + '</td>' +
                    '</tr>';
                $(target).append(html);
            });
        }
	});
</script>	
</head>
<body class="bg-light">
	<header class="p-3 text-bg-dark">
		<jsp:include page="/include/topMenu.jsp"></jsp:include>
	</header>
	<main>
		<div class="container my-4">
			<label for="datePicker" class="form-label">조회할 날짜 선택</label> 
			<input type="text" id="datePickerDaily" class="datePicker form-control" />
		</div>
		<div class="bd-example m-0 border-0 mt-3">
			<nav>
				<div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
					<button class="nav-link active fw-bold" id="nav-daily-tab"
						data-bs-toggle="tab" data-bs-target="#nav-daily" type="button"
						role="tab" aria-controls="nav-daily" aria-selected="true">일별</button>
					<button class="nav-link fw-bold" id="nav-week-tab" data-bs-toggle="tab"
						data-bs-target="#nav-week" type="button" role="tab"
						aria-controls="nav-week" aria-selected="false">주간</button>
					<button class="nav-link fw-bold" id="nav-weekend-tab" data-bs-toggle="tab"
						data-bs-target="#nav-weekend" type="button" role="tab"
						aria-controls="nav-weekend" aria-selected="false">주말</button>
				</div>
			</nav>
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="nav-daily"
					role="tabpanel" aria-labelledby="nav-daily-tab">
					<h2 class="fw-bolder">일별 박스오피스</h2>
					<div class="table-responsive">
						<table class="table table-striped">
							<thead class="text-center">
								<tr>
									<th scope="col">시작시간</th>
									<th scope="col">상영시간(분)</th>
									<th scope="col">영화명</th>
									<th scope="col">관람등급</th>
								</tr>
							</thead>
							<tbody id="dailyView">
							</tbody>
						</table>
					</div>
				</div>
				<div class="tab-pane fade" id="nav-week" role="tabpanel"
					aria-labelledby="nav-week-tab">
					<h2 class="fw-bolder">주간 박스오피스</h2><small>* 해당 날짜가 속한 주(월~일) 기준으로 조회</small>
					<div class="table-responsive">
						<table class="table table-striped">
							<thead class="text-center">
								<tr>
									<th scope="col">시작시간</th>
									<th scope="col">상영시간(분)</th>
									<th scope="col">영화명</th>
									<th scope="col">관람등급</th>
								</tr>
							</thead>
							<tbody id="weeklyView">
							</tbody>
						</table>
					</div>
				</div>
				<div class="tab-pane fade" id="nav-weekend" role="tabpanel"
					aria-labelledby="nav-weekend-tab">
					<h2 class="fw-bolder">주간 박스오피스(주말)</h2><small>* 해당 날짜가 속한 주(월~일) 기준으로 조회</small>
					<div class="table-responsive">
						<table class="table table-striped">
							<thead class="text-center">
								<tr>
									<th scope="col">시작시간</th>
									<th scope="col">상영시간(분)</th>
									<th scope="col">영화명</th>
									<th scope="col">관람등급</th>
								</tr>
							</thead>
							<tbody id="weekendView">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		
	
	
	</main>
	<footer
		class="d-flex flex-wrap justify-content-center align-items-center py-3 my-4 border-top bg-secondary"
		style="--bs-bg-opacity: .1;">
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</footer>
</body>
</html>