<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="kr.ac.kopo.schedule.vo.ScheduleVO"%>
<%@page import="kr.ac.kopo.schedule.dao.ScheduleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

ScheduleDAO scheduleDao = new ScheduleDAO();
ScheduleVO schedule = new ScheduleVO();
String movieNo=request.getParameter("movieNo");
if (!movieNo.equals("undefined"))
	schedule.setMovieNo(Integer.parseInt(movieNo));
schedule.setScreenTime(request.getParameter("date"));

List<ScheduleVO> scheduleList = scheduleDao.selectWhere(schedule);

Gson gson = new Gson();
String jsonString = gson.toJson(scheduleList);
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
out.print(jsonString);
out.flush();
%>