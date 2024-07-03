<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영일정 관리</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker.min.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/locales/bootstrap-datepicker.ko.min.js"></script>
<link href="/Cinema-WEB/resources/css/my.css" rel="stylesheet" />

<script>
	$(document).ready(
			function() {
				const date = new Date();
				const yyyy = date.getFullYear();
				const mm = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
				const dd = String(date.getDate()).padStart(2, '0');

				const formattedDate = yyyy + "-" + mm + "-" + dd;
				$('.datePicker').val(formattedDate);
				
				$('.datePicker').datepicker({
					format : 'yyyy-mm-dd', //데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
					startDate : '-0d', //달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
					endDate : '+13d', //달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
					autoclose : true, //사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
					showWeekDays : true, // 위에 요일 보여주는 옵션 기본값 : true
					todayHighlight : true, //오늘 날짜에 하이라이팅 기능 기본값 :false
					toggleActive : false, //이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
					language : 'ko', //달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
				})
				
				const selectedDate = $('#datePicker').datepicker('getFormattedDate', 'yyyymmdd');
					
					fetch('ajax/selectSchedule.jsp', {
			            method: 'POST',
			            body: new URLSearchParams({
			                date: selectedDate,
			                theaterName : '1'
			            })
			        })
			        .then(response => response.json())
			        .then(data => appendDate(data))
			        .catch(error => console.error('Error :', error));
					
				 $('#submitBtn').click(function() {
			        const theaterName = $('#theater').val();
			        const movieNo = $('#movie').val();
			        const hour = $('#hour').val();
			        const minute = $('#minute').val();
			        let selectedDate = $('#datePicker2').datepicker('getFormattedDate', 'yyyy-mm-dd');
			        selectedDate += " "+hour+":"+minute+":00";

			        fetch('ajax/registerSchedule.jsp', {
			            method: 'POST',
			            body: new URLSearchParams({
			            	theaterName: theaterName,
				            movieNo: movieNo,
				            screenTime: selectedDate
			            })
			        })
			        .then(response => {
		            if (response.ok) {
		                $('#scheduleModal').modal('hide');
		                location.reload(true);
		            } else {
		                console.error('등록 실패:', response.statusText);
		            }
		        })
			    });
					
					
				$('#registerBtn').click(function(e) {
		            e.preventDefault(); // 기본 동작(폼 제출) 방지
		            $('#scheduleModal').modal('show');
		        });

				$('#datePicker').on('changeDate',function(e) {
					const selectedDate = $('#datePicker').datepicker('getFormattedDate', 'yyyymmdd');
					
					fetch('ajax/selectSchedule.jsp', {
			            method: 'POST',
			            body: new URLSearchParams({
			                date: selectedDate,
			                theaterName : '1'
			            })
			        })
			        .then(response => response.json())
			        .then(data => appendDate(data))
			        .catch(error => console.error('Error :', error));
				});
				
				$('#theaterList .dropdown-item').on('click', function(e) {
					e.preventDefault();
					const selectedDate = $('#datePicker').datepicker('getFormattedDate', 'yyyymmdd');
				    const theaterName = $(this).data("theater-name");
					fetch('ajax/selectSchedule.jsp', {
			            method: 'POST',
			            body: new URLSearchParams({
			                date: selectedDate,
			                theaterName : theaterName
			            })
			        })
			        .then(response => response.json())
			        .then(data => appendDate(data))
			        .catch(error => console.error('Error :', error));
					
				});
				
				function appendDate(data) {
		            $("#resultView").empty();

		            data.forEach(schedule => {
		                let html = "<div class='row border'>" +
		                           "<div class='col-2 text-center fw-bolder'>" + schedule.theaterName + "</div>" +
		                           generateTimeSlots(schedule.screenTime, schedule.movie.runtime) +
		                           "</div>";
		                $("#resultView").append(html);
		            });
		            $('[data-toggle="tooltip"]').tooltip();
		        }
				

				function generateTimeSlots(screenTime, runtime) {
					const slotsPerHour = 6; // 한 시간당 6개의 10분 단위 슬롯
		            const totalHours = 10; 
		            const start = new Date(screenTime);
		            // runtime을 10분 단위로 변환하고 올림 처리
		            const runtimeInSlots = Math.ceil(parseInt(runtime) / 10);
		            const end = new Date(start.getTime() + runtimeInSlots * 10 * 60000);
		            
		            let html = "";
		            for (let hour = 12; hour < 12 + totalHours; hour++) {
		                html += "<div class='col-1 border-start'>";
		                html += "<div class='row'>";

		                for (let slot = 0; slot < slotsPerHour; slot++) {
		                    const minute = slot * 10;
		                    const cellTime = new Date(start);
		                    cellTime.setHours(hour, minute, 0, 0);

		                    let cellClass = "";
		                    let tooltipContent = "";
		                    if (cellTime >= start && cellTime < end) {
		                        cellClass = "bg-info";
		                    }

		                    html += "<div class='col-2 p-1 border-start " + cellClass + "' data-toggle='tooltip' data-html='true' title='${tooltipContent}'>&nbsp;</div>";
		                }
		                html += "</div></div>";
		            }
		            return html;
		        }
			});
</script>
</head>
<body class="bg-light">
	<header class="p-3 text-bg-dark">
		<jsp:include page="/include/topMenu.jsp"></jsp:include>
	</header>
	<main style="max-width: 1200px">
		<div id="scheduleModal" class="modal fade" tabindex="-1"
			aria-labelledby="paymentModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title fw-bold me-5" id="paymentModalLabel">상영일정
							등록</h4>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					
					
					<div class="modal-body">
						<div class="col-md-4 mb-4">
							<p>선택날짜</p>
							<input type="text" id="datePicker2" class="datePicker form-control mt-0" />
						</div>
						<div class="col-md-4 mb-4">
							<label for="state" class="form-label">상영관</label> <select
								class="form-select" id="theater" required>
								<c:forEach var="theater" items="${theaterList}">
									<option value="${theater.theaterName}">${theater.theaterName}
										관</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-4 mb-4">
							<label for="state" class="form-label">영화</label> <select
								class="form-select" id="movie" required>
								<c:forEach var="movie" items="${movieList}">
									<option value="${movie.no}">${movie.title}</option>
								</c:forEach>
							</select>
						</div>
						<div class="row">
						<div class="col-md-4 mb-4">
							<label for="state" class="form-label">시</label> <select
								class="form-select" id="hour" required>
								<option value="12">12시</option>
								<option value="13">13시</option>
								<option value="14">14시</option>
								<option value="15">15시</option>
								<option value="16">16시</option>
								<option value="17">17시</option>
								<option value="18">18시</option>
								<option value="19">19시</option>
								<option value="20">20시</option>
								<option value="21">21시</option>
							</select>
						</div>
						<div class="col-md-4 mb-4">
							<label for="state" class="form-label">분</label> 
							<select class="form-select" id="minute" required>
								<option value="00">00분</option>
								<option value="10">10분</option>
								<option value="20">20분</option>
								<option value="30">30분</option>
								<option value="40">40분</option>
								<option value="50">50분</option>
							</select>
						</div>
						</div>
					</div>
					<button id="submitBtn" class="btn btn-primary">등록하기</button>
				</div>
			</div>
		</div>

		<h2 class="text-center mt-4">상영일정 관리</h2>
		
		<div class="d-flex justify-content-between align-items-center">
			<div class="d-flex align-items-center">
				<div class="row">
					<div class="row-4">
						<p class="mb-0 px-3 flex-grow-3 fw-bolder">날짜선택</p>
						<input type="text" id="datePicker" class="datePicker form-control" />
					
					</div>
				</div>
			</div>
			<div class="d-flex my-4 justify-content-end">
				<div>
					<button id="registerBtn" class="btn btn-primary fw-bolder">상영일정
						등록</button>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row border">
				<div class="col-2 text-center">
					<div class="dropdown">
						<button class="btn btn-secondary dropdown-toggle my-1"
							type="button" data-bs-toggle="dropdown" aria-expanded="false">
							상영관 선택</button>
						<ul id="theaterList" class="dropdown-menu dropdown-menu-dark">
							<c:forEach var="theater" items="${theaterList}">
								<li><a class="dropdown-item" href="#"
									data-theater-name="${theater.theaterName}">${theater.theaterName}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="col-1 border-start pt-3">
					<div class="row">
						<div class="col-2 p-1">12</div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
					</div>
				</div>
				<div class="col-1 border-start pt-3">
					<div class="row">
						<div class="col-2 p-1">13</div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
					</div>
				</div>
				<div class="col-1 border-start pt-3">
					<div class="row">
						<div class="col-2 p-1">14</div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
					</div>
				</div>
				<div class="col-1 border-start pt-3">
					<div class="row">
						<div class="col-2 p-1">15</div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
					</div>
				</div>
				<div class="col-1 border-start pt-3">
					<div class="row">
						<div class="col-2 p-1">16</div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
					</div>
				</div>
				<div class="col-1 border-start pt-3">
					<div class="row">
						<div class="col-2 p-1">17</div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
					</div>
				</div>
				<div class="col-1 border-start pt-3">
					<div class="row">
						<div class="col-2 p-1">18</div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
					</div>
				</div>
				<div class="col-1 border-start pt-3">
					<div class="row">
						<div class="col-2 p-1">19</div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
					</div>
				</div>
				<div class="col-1 border-start pt-3">
					<div class="row">
						<div class="col-2 p-1">20</div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
					</div>
				</div>
				<div class="col-1 border-start pt-3">
					<div class="row">
						<div class="col-2 p-1">21</div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
						<div class="col-2 p-1"></div>
					</div>
				</div>
			</div>
			<div class="container-fluid p-0" id="resultView"></div>
		</div>

	</main>
	<footer
		class="d-flex flex-wrap justify-content-center align-items-center py-3 my-4 border-top bg-secondary"
		style="--bs-bg-opacity: .1;">
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</footer>
</body>
</html>