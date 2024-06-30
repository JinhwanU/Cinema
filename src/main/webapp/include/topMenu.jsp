<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <script>
	<c:if test="${ userVO.userId == null }">
	location.href = "/Email-WEB/member/login.jsp"
	</c:if>
</script> -->
<div class="container" style="max-width: 900px;">
	<div class="row">
		<div class="col-md-8">
			<!-- <div class="d-flex flex-wrap align-items-center justify-content-center"> -->
			<ul
				class="nav col-12 col-lg-auto mb-2 me-lg-5 justify-content-start mb-md-0">
				<li><a href="${ pageContext.request.contextPath }/"
					class="text-white text-decoration-none"> <img
						src="/Cinema-WEB/resources/images/logoWhite.png" class="bi me-2"
						width="60" height="32" alt="Bootstrap">
				</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle px-4 text-white fw-bolder" href="#"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">
						영화 </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item fw-bolder"
							href="${ pageContext.request.contextPath }/movie/list.do">무비차트</a></li>
						<li><a class="dropdown-item fw-bolder"
							href="${ pageContext.request.contextPath }/post/list.do">무비
								포스트</a></li>
					</ul></li>
				<li><a
					href="${ pageContext.request.contextPath }/reservation/timetable.do"
					class="nav-link px-4 text-white fw-bolder">예매</a></li>
				<li><a href="${ pageContext.request.contextPath }/cinema/info.do" class="nav-link px-4 text-white fw-bolder">극장</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle px-4 text-white fw-bolder" href="#"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">
						마이페이지 </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item fw-bolder" href="#">예매내역 확인</a></li>
						<li><a class="dropdown-item fw-bolder" href="#">회원정보 관리</a></li>
					</ul></li>
			</ul>
		</div>

		<div class="col-md-4 text-end">
			<button type="button" class="btn btn-outline-light me-2">Login</button>
			<button type="button" class="btn btn-warning">Sign-up</button>
		</div>
	</div>
</div>
</div>

