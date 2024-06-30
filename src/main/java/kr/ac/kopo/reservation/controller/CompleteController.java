package kr.ac.kopo.reservation.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.reservation.dao.ReservationDAO;
import kr.ac.kopo.reservation.vo.ReservationVO;

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

		ReservationDAO reservationDao = new ReservationDAO();
		reservationDao.insertReservation(reservation);

		return "/home.jsp";
	}
}
