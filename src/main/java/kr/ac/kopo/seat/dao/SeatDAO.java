package kr.ac.kopo.seat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;

import kr.ac.kopo.seat.vo.SeatVO;
import kr.ac.kopo.util.MyBatisConfig;

public class SeatDAO {
	private SqlSession session;

	public SeatDAO() {
		session = new MyBatisConfig().getInstance();
	}

	public void updateAvailableZero(List<SeatVO> seatList) {
		try {
			session.update("seat.dao.SeatDAO.updateAvailableZero", seatList);
			session.commit();
		} catch (Exception e) {
			session.rollback();
			throw e;
		}
	}
}
