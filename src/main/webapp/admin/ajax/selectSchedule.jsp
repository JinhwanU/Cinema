<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.ac.kopo.schedule.vo.ScheduleVO"%>
<%@page import="kr.ac.kopo.schedule.dao.ScheduleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

ScheduleDAO scheduleDao = new ScheduleDAO();
ScheduleVO schedule = new ScheduleVO();

schedule.setScreenTime(request.getParameter("date"));
schedule.setTheaterName(request.getParameter("theaterName")); 
List<ScheduleVO> scheduleList = scheduleDao.selectByDateAndTheater(schedule);
Gson gson = new Gson();
String json = gson.toJson(scheduleList);
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
out.print(json);
out.flush();
%>