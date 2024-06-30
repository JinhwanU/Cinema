package kr.ac.kopo.reservation.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.schedule.dao.ScheduleDAO;
import kr.ac.kopo.schedule.vo.ScheduleVO;

public class ScheduleController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ScheduleVO schedule = new ScheduleVO();
		schedule.setMovieNo(Integer.parseInt(request.getParameter("movieNo")));
		schedule.setScreenTime(request.getParameter("date"));
		
		System.out.println(schedule.toString());

		ScheduleDAO scheduleDao = new ScheduleDAO();
		List<ScheduleVO> scheduleList = scheduleDao.selectWhere(schedule);
		request.setAttribute("scheduleList", scheduleList);
		
		return "/reservation/scheduleList.jsp";
	}
}
