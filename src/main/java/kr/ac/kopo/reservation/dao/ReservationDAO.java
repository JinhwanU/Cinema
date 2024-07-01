package kr.ac.kopo.reservation.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.ac.kopo.reservation.vo.ReservationVO;
import kr.ac.kopo.util.MyBatisConfig;

public class ReservationDAO {
	private SqlSession session;

	public ReservationDAO() {
		session = new MyBatisConfig().getInstance();
	}

	public void insertReservation(ReservationVO reservation) {
		try {
			session.insert("reservation.dao.ReservationDAO.insert", reservation);
			session.commit();
		} catch (Exception e) {
			session.rollback();
			throw e;
		}
	}
	
	public List<ReservationVO> selectListByMemberId(String memberId){
		List<ReservationVO> reservList= session.selectList("reservation.dao.ReservationDAO.selectListByMemberId", memberId);
		return reservList;
	}
}
