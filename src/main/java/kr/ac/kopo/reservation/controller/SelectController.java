package kr.ac.kopo.reservation.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.reservation.dao.ReservationDAO;
import kr.ac.kopo.schedule.dao.ScheduleDAO;
import kr.ac.kopo.schedule.vo.ScheduleVO;

public class SelectController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int no = Integer.parseInt(request.getParameter("no"));

		ScheduleDAO scheduleDAO = new ScheduleDAO();
		ScheduleVO schedule = scheduleDAO.selectByNoAssociation(no);
		
		request.setAttribute("schedule", schedule);

		return "/reservation/select.jsp";
	}
}
