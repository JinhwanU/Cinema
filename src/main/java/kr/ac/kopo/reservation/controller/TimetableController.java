package kr.ac.kopo.reservation.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kopo.ajax.vo.DateVO;
import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.movie.dao.MovieDAO;
import kr.ac.kopo.movie.vo.MovieVO;

public class TimetableController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MovieDAO movieDao = new MovieDAO();
		List<MovieVO> movieList = movieDao.selectAllMovies();
		request.setAttribute("movieList", movieList);

		LocalDate currentDate = LocalDate.now();

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MM-dd");

		String[] dayNames = { "월", "화", "수", "목", "금", "토", "일" };
		
		List<DateVO> dateList = new ArrayList<>();

		for (int i = 0; i < 14; i++) {
			LocalDate date = currentDate.plusDays(i);
			DayOfWeek dayOfWeek = date.getDayOfWeek();
			String dayName = dayNames[dayOfWeek.getValue() % 7]; // Java의 DayOfWeek 값은 월요일이 1, 일요일이 7입니다.
			
			DateVO dateVO = new DateVO();
			dateVO.setDate(date.format(formatter));
			dateVO.setFormattedDate(date.format(dateFormatter)+"("+dayName+")");
			
			dateList.add(dateVO);
		}

		request.setAttribute("dateList", dateList);
		
		return "/reservation/timetable.jsp";
	}
}
