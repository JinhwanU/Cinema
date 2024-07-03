package kr.ac.kopo.seat.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;

import kr.ac.kopo.schedule.vo.ScheduleVO;
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
	
	public void insertScheduleSeats(ScheduleVO schedule) {
		List<SeatVO> seats = generateSeats(schedule.getNo(), schedule.getTheaterName());
		try {
			session.insert("seat.dao.SeatDAO.insertSeats", seats);
            session.commit();
		} catch (Exception e) {
			session.rollback();
			throw(e);
		}
	}
	
	private List<SeatVO> generateSeats(int scheduleNo, String theaterName) {
        List<SeatVO> seats = new ArrayList<>();
        char[] rows = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'};
        int columns = 10;
        
        for (char row : rows) {
            for (int col = 1; col <= columns; col++) {
                String seatName = String.format("%c%02d", row, col);
                seats.add(new SeatVO(theaterName, seatName, scheduleNo));
            }
        }
        return seats;
    }
}
