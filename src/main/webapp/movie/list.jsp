<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>무비차트</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="../resources/css/my.css" rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
a {
	text-decoration: none;
}
</style>
</head>
<body class="bg-light">
	<header class="p-3 text-bg-dark">
		<jsp:include page="../include/topMenu.jsp"></jsp:include>
	</header>
	<main class="py-3">
		<div class="album py-5">
				<h1>무비차트</h1>

				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:forEach var="movie" items="${ movieList }">
						<div class="col-3 p-4">
							<div class="card shadow-sm">
								<img class="bd-placeholder-img card-img-top" width="100%"
									height="300" src="${movie.posterUrl }">
							<title>Placeholder</title><rect width="100%" height="100%"
										fill="#55595c" />
								<div class="card-body">
									<p class="card-text"><a href="${movie.kmdbUrl}" target="_blank">${ movie.title }</a>
										<br><small>상영시간 : ${ movie.runtime }분</small></p>
									<div class="d-flex justify-content-between align-items-center">
										<div class="btn-group">
											<button type="button" onclick="location.href='${ pageContext.request.contextPath }/reservation/timetable.do'"
												class="btn btn-sm btn-outline-danger">예매하기</button>
										</div>
										<small class="text-muted">${ movie.openDate } 개봉</small>
									</div>
								</div>
							</div>

						</div>
					</c:forEach>
				</div>
		</div>
	</main>
	<footer
		class="d-flex flex-wrap justify-content-center align-items-center py-3 my-4 border-top bg-secondary"
		style="--bs-bg-opacity: .1;">
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</footer>
</body>
</html>