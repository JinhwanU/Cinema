<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영영화 관리</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="/Cinema-WEB/resources/css/my.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
	$(document).ready(function(){
		$('#movieBtn').click(function(e) {
            e.preventDefault(); // 기본 동작(폼 제출) 방지
            $('#movieModal').modal('show');
        });
		
		$('#searchBtn').click(function(e) {
            e.preventDefault(); // 기본 동작(폼 제출) 방지
            let searchInput = $('#searchText').val()
	        const params = {
	                collection: 'kmdb_new2',
	                title: searchInput,
	                detail : 'Y',
	                listCount: '50',
	        		ServiceKey: '6X19E69S7Y473181K8ZH'
	            };
            const url = 'http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?' + $.param(params);
            
            fetch(url)
                .then(response => response.json())
                .then(data => {
                	let result = data.Data[0].Result;
                    console.log(result);
                    result = result.filter(el => {
                        return el.genre !== "에로" && el.directors.director[0].length !== 0 && el.genre.length !== 0 && el.repRlsDate.length !== 0 && el.posters.length !== 0;
                    });
                    displayData('#detailView', result);
                })
        });
		
		$(document).on('click', '#detailView .search-result', function() {
            let title = $(this).find('#title').text().trim();
            let runtime = $(this).find('#runtime').text().trim();
            let openDate = $(this).find('#openDate').text().trim();
            let kmdbUrl = $(this).find('#kmdbUrl').text().trim();
            let posterUrl = $(this).find('#posterUrl').attr('src');
            let rating = $(this).find('#rating').text().trim();
            
            if(confirm('상영 등록하시겠습니까?')){
                fetch('ajax/register.jsp', {
                    method: 'POST',
                    body: new URLSearchParams({
                    	title: title,
                    	runtime: runtime,
                    	openDate: openDate,
                    	kmdbUrl: kmdbUrl,
                    	posterUrl: posterUrl,
                    	rating: rating
                    })
                })
            }
        });
		
		
		function displayData(target, list) {
            $(target).empty();
            
            list.forEach(movie => {
            	console.log(movie)
            	let { title } = movie
            	title = title.replace(/\!HS/g, "") //!HS를 빈문자열로 replace
            	title = title.replace(/\!HE/g, "") // !HE를 빈문자열로 replace
            	title = title.replace(/^\s+|\s+$/g, "") // 앞뒤 공백 제거
            	title = title.replace(/ +/g, " ") // 여러개의 공백 하나의 공백으로 바꾸기 
            	
            	let poster =  movie.posters.split('|')[0];
            	
	            let html = '<tr class="search-result">' +
                    '<td class="align-middle text-center"><img id="posterUrl" src="' + poster + '" height="200px"/></td>' +
                    '<td id="title" class="align-middle text-center">' + title + '</td>' +
                    '<td id="openDate" class="align-middle text-center">' + movie.repRlsDate + '</td>' +
                    '<td id="runtime" class="align-middle text-center">' + movie.runtime + '</td>' +
                    '<td class="align-middle text-center">' + movie.company + '</td>' +
                    '<td class="align-middle text-center">' + movie.directors.director[0].directorNm + '</td>' +
                    '<td class="align-middle text-center">' + movie.nation + '</td>' +
                    '<td id="rating" class="align-middle text-center">' + movie.rating + '</td>' +
                    '<td id="kmdbUrl" style="display: none;">' + movie.kmdbUrl + '</td>' +
                    '</tr>';
                $(target).append(html);
            });
        }
	})
</script>
</head>
<body class="bg-light">
	<header class="p-3 text-bg-dark">
		<jsp:include page="/include/topMenu.jsp"></jsp:include>
	</header>
	<main>
		<div id="movieModal" class="modal fade" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
	        <div class="modal-dialog modal-xl">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <h4 class="modal-title fw-bold me-5" id="paymentModalLabel">상영 등록</h4>
	                    <form class="d-flex mx-5" role="search">
			                <input id="searchText" class="form-control me-2" type="search" placeholder="영화명" aria-label="검색">
			                <button id="searchBtn" class="btn btn-outline-dark" type="button" style="width: 100px;">검색</button>
			            </form>
	                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                </div>
	                <div class="modal-body">
	                	<div class="table-responsive">
							<table class="table table-striped table-hover">
								<thead class="text-center">
									<tr>
										<th scope="col">포스터</th>
										<th scope="col">영화명</th>
										<th scope="col">개봉일자</th>
										<th scope="col">상영시간</th>
										<th scope="col">제작사</th>
										<th scope="col">감독명</th>
										<th scope="col">제작국가</th>
										<th scope="col">관람등급</th>
									</tr>
								</thead>
								<tbody id="detailView">
								
								</tbody>
							</table>
						</div>
	                </div>
	            </div>
	        </div>
	    </div>
	
	
	
		<div class="py-5 text-center">
			<h2 class="fw-bold">현재 상영중인 영화</h2>
			<div class="d-flex justify-content-end">
				<button id="movieBtn" class="btn btn-primary btn-lg fw-bold" type="button">상영 등록</button>
			</div>
			<table class="table table-hover table-striped align-middle table-sm mt-3" style="width: 100%;">
				<tr class="table-primary">
					<th class="text-center" width="20%">포스터</th>
					<th class="text-center" width="30%">영화제목</th>
					<th class="text-center" width="20%">관람등급</th>
					<th class="text-center" width="10%">상영시간</th>
					<th class="text-center" width="20%">개봉일</th>
				</tr>
					<c:forEach var="movie" items="${ movieList }">
						<tr>
							<td align="center"><img src="${ movie.posterUrl }" height="200px"/></td>
							<td align="center">${ movie.title }</td>
							<td align="center">${ movie.rating }</td>
							<td align="center">${ movie.runtime }분</td>
							<td align="center">${ movie.openDate }</td>
						</tr>
					</c:forEach>
			</table>
		</div>
		
	</main>
	<footer
		class="d-flex flex-wrap justify-content-center align-items-center py-3 my-4 border-top bg-secondary"
		style="-bs-bg-opacity: .1;">
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</footer>
</body>
</html>






