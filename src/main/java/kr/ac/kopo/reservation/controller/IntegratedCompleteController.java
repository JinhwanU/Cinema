package kr.ac.kopo.reservation.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.reservation.dao.ReservationDAO;
import kr.ac.kopo.reservation.vo.ReservationVO;
import kr.ac.kopo.schedule.vo.ScheduleVO;
import kr.ac.kopo.seat.dao.SeatDAO;
import kr.ac.kopo.seat.vo.SeatVO;
import oracle.net.ns.SessionAtts;

public class IntegratedCompleteController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int db = Integer.parseInt(request.getParameter("db"));
		int movieNo = Integer.parseInt(request.getParameter("movieNo"));
		String seatName = request.getParameter("seatName");
		int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
		int headcount = Integer.parseInt(request.getParameter("headcount"));
		int payment = Integer.parseInt(request.getParameter("payment"));
		String[] seatNoStrArr = request.getParameterValues("seatNo");
		int[] seatNoArr = new int[seatNoStrArr.length];
		 for (int i = 0; i < seatNoStrArr.length; i++) {
			 seatNoArr[i] = Integer.parseInt(seatNoStrArr[i]);
         }
		
		ReservationVO reservation = new ReservationVO();
		
		reservation.setMovieNo(movieNo);
		reservation.setSeatName(seatName);
		reservation.setScheduleNo(scheduleNo);
		reservation.setHeadcount(headcount);
		reservation.setPayment(payment);
		
		switch (db) {
		case 1:
			reservation.setMemberId("test");
			break;
		case 2:
			reservation.setMemberId("admin");
			break;
		case 3:
			reservation.setMemberId("test");
			break;
		}
		

		String[] seatNameArray = seatName.split(" ");

		List<SeatVO> seatList = new ArrayList<>();
		for (int i = 0; i < seatNameArray.length; i++) {
			seatList.add(new SeatVO(seatNoArr[i], seatNameArray[i], scheduleNo));
		}

		try {
			requestApi(db, seatList, reservation);
		} catch (Exception e) {
			return "/reservation/fail.jsp";
		}

		return "/reservation/integrated/integratedComplete.jsp";
	}

	private void requestApi(int db, List<SeatVO> seatList, ReservationVO reservation) throws IOException {
		URL url = new URL("http://172.31.7.184:8081/Cinema-API/completeForm.do?db=" + db);

		// HttpURLConnection 객체 열기
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		// POST 요청 설정
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/json; utf-8");
		conn.setDoOutput(true);

		// 객체를 JSON으로 변환
		Gson gson = new Gson();
		String seatListJson = gson.toJson(seatList);
		String reservationJson = gson.toJson(reservation);

		// JSON 데이터 병합
		String jsonString = String.format("{\"seatList\": %s, \"reservation\": %s}", seatListJson, reservationJson);

		// JSON 데이터를 POST 요청의 본문에 쓰기
		try (OutputStream os = conn.getOutputStream()) {
			byte[] input = jsonString.getBytes("utf-8");
			os.write(input, 0, input.length);
		}

		// 응답 코드 확인
		int responseCode = conn.getResponseCode();
		if (responseCode != HttpURLConnection.HTTP_OK) {
			throw new IOException("HTTP error code: " + responseCode);
		}

		// 연결 닫기
		conn.disconnect();
	}
}
