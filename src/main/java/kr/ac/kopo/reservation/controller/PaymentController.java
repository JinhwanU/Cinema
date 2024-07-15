package kr.ac.kopo.reservation.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.schedule.dao.ScheduleDAO;
import kr.ac.kopo.schedule.vo.ScheduleVO;

public class PaymentController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int no = Integer.parseInt(request.getParameter("no"));
		String[] seatList = request.getParameter("seat").trim().split("\\s+");

		ScheduleDAO scheduleDAO = new ScheduleDAO();
		ScheduleVO schedule = scheduleDAO.selectByNo(no);

		int count = seatList.length;

		request.setAttribute("schedule", schedule);
		request.setAttribute("seatList", seatList);
		request.setAttribute("count", count);
		return "/reservation/payment.jsp";
	}
}
