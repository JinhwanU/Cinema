package kr.ac.kopo.reservation.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.movie.vo.MovieVO;
import kr.ac.kopo.reservation.dao.ReservationDAO;
import kr.ac.kopo.schedule.dao.ScheduleDAO;
import kr.ac.kopo.schedule.vo.ScheduleVO;

public class IntegratedSelectController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int db = Integer.parseInt(request.getParameter("db"));
		int no = Integer.parseInt(request.getParameter("no"));

		ScheduleVO schedule = requestApi(db, no);
		request.setAttribute("schedule", schedule);

		return "/reservation/integrated/integratedSelect.jsp";
	}
	
	private ScheduleVO requestApi(int db,int no) throws IOException{
		URL url = new URL("http://172.31.7.184:8081/Cinema-API/selectForm.do?db="+db+"&no="+no);

        // HttpURLConnection 객체 열기
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        // GET 요청 설정
        conn.setRequestMethod("GET");

        // 응답 코드 확인
        int responseCode = conn.getResponseCode();
        if (responseCode != HttpURLConnection.HTTP_OK) {
            throw new IOException("HTTP error code: " + responseCode);
        }

        // 응답 내용 읽기
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String line;
        StringBuilder sb = new StringBuilder();
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }
        br.close();

        // JSON 문자열 파싱
        Gson gson = new Gson();
        String jsonString = sb.toString();
        ScheduleVO schedule = gson.fromJson(jsonString, new TypeToken<ScheduleVO>() {}.getType());

        // 연결 닫기
        conn.disconnect();
		
        return schedule;
	}
}
