package kr.ac.kopo.reservation.dao;

import org.apache.ibatis.session.SqlSession;

import kr.ac.kopo.reservation.vo.ReservationVO;
import kr.ac.kopo.util.MyBatisConfig;

public class ReservationDAO {
	private SqlSession session;

	public ReservationDAO() {
		session = new MyBatisConfig().getInstance();
	}

	public void insertReservation(ReservationVO reservation) {
		session.insert("reservation.dao.ReservationDAO.insert", reservation);
		session.commit();
	}
}
