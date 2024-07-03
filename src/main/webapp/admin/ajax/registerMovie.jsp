<%@page import="kr.ac.kopo.movie.vo.MovieVO"%>
<%@page import="kr.ac.kopo.movie.dao.MovieDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

MovieDAO movieDao = new MovieDAO();
MovieVO movie = new MovieVO();

movie.setTitle(request.getParameter("title"));
movie.setRuntime(Integer.parseInt(request.getParameter("runtime")));
movie.setOpenDate(request.getParameter("openDate"));
movie.setKmdbUrl(request.getParameter("kmdbUrl"));
movie.setPosterUrl(request.getParameter("posterUrl"));
movie.setRating(request.getParameter("rating"));

movieDao.insertMovie(movie);
%>