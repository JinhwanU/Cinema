package kr.ac.kopo.reservation.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import kr.ac.kopo.ajax.vo.DateVO;
import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.movie.dao.MovieDAO;
import kr.ac.kopo.movie.vo.MovieVO;

public class IntegratedTimetableController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		LocalDate currentDate = LocalDate.now();

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MM-dd");

		String[] dayNames = { "월", "화", "수", "목", "금", "토", "일" };
		
		List<DateVO> dateList = new ArrayList<>();

		for (int i = 0; i < 14; i++) {
			LocalDate date = currentDate.plusDays(i);
			DayOfWeek dayOfWeek = date.getDayOfWeek();
			String dayName = dayNames[(dayOfWeek.getValue()-1) % 7]; // Java의 DayOfWeek 값은 월요일이 1, 일요일이 7입니다.
			
			DateVO dateVO = new DateVO();
			dateVO.setDate(date.format(formatter));
			dateVO.setFormattedDate(date.format(dateFormatter)+"("+dayName+")");
			
			dateList.add(dateVO);
		}

//		List<MovieVO> movieList = requestApi();

		request.setAttribute("dateList", dateList);
//		request.setAttribute("movieList", movieList);
		return "/reservation/integrated/integratedTimetable.jsp";
	}
	
	
	private List<MovieVO> requestApi() throws IOException{
		URL url = new URL("http://172.31.7.184:8081/Cinema-API/timetable.do");

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
        List<MovieVO> movieList = gson.fromJson(jsonString, new TypeToken<List<MovieVO>>() {}.getType());

        // 파싱된 데이터 출력
//        System.out.println(movieList.toString());

        // 연결 닫기
        conn.disconnect();
		
        return movieList;
	}
}
