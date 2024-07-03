package kr.ac.kopo.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.movie.dao.MovieDAO;
import kr.ac.kopo.movie.vo.MovieVO;
import kr.ac.kopo.theater.dao.TheaterDAO;
import kr.ac.kopo.theater.vo.TheaterVO;

public class ScheduleController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		TheaterDAO theaterDao = new TheaterDAO();
		MovieDAO movieDao = new MovieDAO();

		List<TheaterVO> theaterList = theaterDao.selectAll();
		List<MovieVO> movieList = movieDao.selectAllMovies();
		
		request.setAttribute("theaterList", theaterList);
		request.setAttribute("movieList", movieList);
		
		return "/admin/schedule.jsp";
	}
}
