package kr.ac.kopo.schedule.vo;

import java.util.List;

import kr.ac.kopo.movie.vo.MovieVO;
import kr.ac.kopo.seat.vo.SeatVO;

public class ScheduleVO {
	private int no;
	private int movieNo;
	private String theaterName;
	private String screenTime;
	private MovieVO movie;
	private int seatCnt;
	private List<SeatVO> seatList;

	public final int getNo() {
		return no;
	}

	public final void setNo(int no) {
		this.no = no;
	}

	public final int getMovieNo() {
		return movieNo;
	}

	public final void setMovieNo(int movieNo) {
		this.movieNo = movieNo;
	}

	public final String getTheaterName() {
		return theaterName;
	}

	public final void setTheaterName(String theaterName) {
		this.theaterName = theaterName;
	}

	public final String getScreenTime() {
		return screenTime;
	}

	public final void setScreenTime(String screenTime) {
		this.screenTime = screenTime;
	}

	public final MovieVO getMovie() {
		return movie;
	}

	public final void setMovie(MovieVO movie) {
		this.movie = movie;
	}

	public final int getSeatCnt() {
		return seatCnt;
	}

	public final void setSeatCnt(int seatCnt) {
		this.seatCnt = seatCnt;
	}

	public final List<SeatVO> getSeatList() {
		return seatList;
	}

	public final void setSeatList(List<SeatVO> seatList) {
		this.seatList = seatList;
	}

	@Override
	public String toString() {
		return "ScheduleVO [no=" + no + ", movieNo=" + movieNo + ", theaterName=" + theaterName + ", screenTime="
				+ screenTime + ", movie=" + movie + ", seatCnt=" + seatCnt + ", seatList=" + seatList + "]";
	}
}
