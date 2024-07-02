package kr.ac.kopo.schedule.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.ac.kopo.schedule.vo.ScheduleVO;
import kr.ac.kopo.util.MyBatisConfig;

public class ScheduleDAO {
	private SqlSession session;

	public ScheduleDAO() {
		session = new MyBatisConfig().getInstance();
	}

	public List<ScheduleVO> selectWhere(ScheduleVO schedule) {
		List<ScheduleVO> list = session.selectList("schedule.dao.ScheduleDAO.selectWhere", schedule);
		return list;
	}
	
	public ScheduleVO selectByNoAssociation(int no) {
		ScheduleVO schedule = session.selectOne("schedule.dao.ScheduleDAO.selectByNoAssociation", no);
		return schedule;
	}

	public List<ScheduleVO> selectByTheaterAssociation(ScheduleVO schedule) {
		List<ScheduleVO> list = session.selectList("schedule.dao.ScheduleDAO.selectByTheaterAssociation", schedule);
		return list;
	}
	public ScheduleVO selectByNo(int no) {
		ScheduleVO schedule = session.selectOne("schedule.dao.ScheduleDAO.selectByNo", no);
		return schedule;
	}
	
	
}
