<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>무비포스트</title>
<script src="https://cdn.jsdelivr.net/npm/masonry-layout@4.2.2/dist/masonry.pkgd.min.js" async></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="../resources/css/my.css" rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
</style>
</head>
<body class="bg-light">
	<header class="p-3 text-bg-dark">
		<jsp:include page="../include/topMenu.jsp"></jsp:include>
	</header>
	<main class="py-3">
		<div class="row my-5" data-masonry='{"percentPosition": true }'>
			<c:forEach var="post" items="${ postList }">
				<div class="col-sm-6 col-lg-4 mb-4">
					<div class="card">
						<c:if test="${ not empty post.imgUrl }">
							<img class="card-img-top" width="100%" height="200"
								src="${ post.imgUrl }" />
						</c:if>
						<div class="card-body">
							<p class="card-text">${ post.writer }</p>
							<h5 class="card-title">${ post.movie.title }</h5>
							<p class="card-text">${ post.content }</p>
							<p class="card-text">${ post.grade }</p>
							<p class="card-text">${ post.viewCnt }</p>
							<p class="card-text">${ post.regDate }</p>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</main>
	<footer
		class="d-flex flex-wrap justify-content-center align-items-center py-3 my-4 border-top bg-secondary"
		style="--bs-bg-opacity: .1;">
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</footer>
</body>
</html>