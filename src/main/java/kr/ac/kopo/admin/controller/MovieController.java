package kr.ac.kopo.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.movie.dao.MovieDAO;
import kr.ac.kopo.movie.vo.MovieVO;

public class MovieController  implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MovieDAO movieDao = new MovieDAO();
		List<MovieVO> movieList = movieDao.selectAllMovies();
		request.setAttribute("movieList", movieList);
		return "/admin/movie.jsp";
	}
}
