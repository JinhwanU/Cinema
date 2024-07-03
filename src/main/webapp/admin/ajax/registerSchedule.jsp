<%@page import="kr.ac.kopo.seat.dao.SeatDAO"%>
<%@page import="kr.ac.kopo.schedule.vo.ScheduleVO"%>
<%@page import="kr.ac.kopo.schedule.dao.ScheduleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

ScheduleDAO scheduleDao = new ScheduleDAO();
ScheduleVO schedule = new ScheduleVO();

schedule.setMovieNo(Integer.parseInt(request.getParameter("movieNo")));
schedule.setTheaterName(request.getParameter("theaterName")); 
schedule.setScreenTime(request.getParameter("screenTime"));

int scheduleNo = scheduleDao.insertSchedule(schedule);

schedule.setNo(scheduleNo);
SeatDAO seatDao = new SeatDAO();
seatDao.insertScheduleSeats(schedule);


%>