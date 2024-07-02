package kr.ac.kopo.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.schedule.dao.ScheduleDAO;
import kr.ac.kopo.schedule.vo.ScheduleVO;

public class ScheduleController implements Controller{

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ScheduleVO schedule = new ScheduleVO();
		schedule.setTheaterName(request.getParameter("theaterName"));
		schedule.setScreenTime(request.getParameter("screenTime"));
		
		ScheduleDAO scheduleDao = new ScheduleDAO();
		List<ScheduleVO> scheduleList = scheduleDao.selectByTheaterAssociation(schedule);
		
		request.setAttribute("scheduleList", scheduleList);
		return "/admin/schedule.jsp";
	}
}
