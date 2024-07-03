package kr.ac.kopo.theater.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.ac.kopo.schedule.vo.ScheduleVO;
import kr.ac.kopo.theater.vo.TheaterVO;
import kr.ac.kopo.util.MyBatisConfig;

public class TheaterDAO {
	private SqlSession session;

	public TheaterDAO() {
		session = new MyBatisConfig().getInstance();
	}
	
	public List<TheaterVO> selectAll(){
		List<TheaterVO> list = session.selectList("theater.dao.TheaterDAO.selectAll");
		return list;
	}
}
