package kr.ac.kopo.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.ac.kopo.movie.vo.MovieVO;
import kr.ac.kopo.util.MyBatisConfig;

public class MovieDAO {
	private SqlSession session;

	public MovieDAO() {
		session = new MyBatisConfig().getInstance();
	}

	public void insertMovie() {

		MovieVO movie = new MovieVO();
		movie.setTitle("삽입test");
		movie.setRuntime(100);
		movie.setOpenDate("20221202");

		session.insert("movie.dao.MovieDAO.insert", movie);
		session.commit();
	}

	public List<MovieVO> selectAllMovies() {
		List<MovieVO> list = session.selectList("movie.dao.MovieDAO.selectAll");
		return list;
	}

	public void selectMovieByNo() {
		MovieVO movie = new MovieVO();
		movie.setNo(1);
		movie = session.selectOne("movie.dao.MovieDAO.selectByNo", movie);
	}

}
