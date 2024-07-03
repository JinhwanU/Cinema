package kr.ac.kopo.reservation.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.reservation.dao.ReservationDAO;
import kr.ac.kopo.reservation.vo.ReservationVO;
import kr.ac.kopo.seat.dao.SeatDAO;
import kr.ac.kopo.seat.vo.SeatVO;
import oracle.net.ns.SessionAtts;

public class CompleteController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int movieNo = Integer.parseInt(request.getParameter("movieNo"));
		String seatName = request.getParameter("seatName");
		int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
		int headcount = Integer.parseInt(request.getParameter("headcount"));
		int payment = Integer.parseInt(request.getParameter("payment"));

		ReservationVO reservation = new ReservationVO();
		reservation.setMemberId("test");
		reservation.setMovieNo(movieNo);
		reservation.setSeatName(seatName);
		reservation.setScheduleNo(scheduleNo);
		reservation.setHeadcount(headcount);
		reservation.setPayment(payment);

		String[] seatNameArray = seatName.split(" ");

		List<SeatVO> seatList = new ArrayList<>();
		for (String name : seatNameArray) {
		    seatList.add(new SeatVO(name, scheduleNo));
		}

		SeatDAO seatDao = new SeatDAO();
		ReservationDAO reservationDao = new ReservationDAO();

		try {
			seatDao.updateAvailableZero(seatList);
			reservationDao.insertReservation(reservation);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/reservation/complete.jsp";
	}
}
