package kr.ac.kopo.mypage.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.reservation.dao.ReservationDAO;
import kr.ac.kopo.reservation.vo.ReservationVO;
import kr.ac.kopo.schedule.vo.ScheduleVO;

public class ReservationLogController implements Controller {
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String memberId = "test";
		ReservationDAO reservDao = new ReservationDAO();
		List<ReservationVO> reservList = reservDao.selectListByMemberId(memberId);
		System.out.println(reservList.toString());
		request.setAttribute("reservList", reservList);
		
		return "/mypage/log.jsp";
	}
}
