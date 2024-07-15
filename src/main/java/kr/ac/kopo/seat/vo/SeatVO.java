package kr.ac.kopo.seat.vo;

public class SeatVO {

	private int no;
	private String theaterName;
	private String seatName;
	private int available;
	private int scheduleNo;

	public SeatVO() {
	}

	
	public SeatVO(String theaterName, String seatName, int scheduleNo) {
		this.theaterName = theaterName;
		this.seatName = seatName;
		this.scheduleNo = scheduleNo;
	}

	public SeatVO(int no, String seatName, int scheduleNo) {
		super();
		this.no = no;
		this.seatName = seatName;
		this.scheduleNo = scheduleNo;
	}


	public final int getNo() {
		return no;
	}

	public final void setNo(int no) {
		this.no = no;
	}

	public final String getTheaterName() {
		return theaterName;
	}

	public final void setTheaterName(String theaterName) {
		this.theaterName = theaterName;
	}

	public final String getSeatName() {
		return seatName;
	}

	public final void setSeatName(String seatName) {
		this.seatName = seatName;
	}

	public final int getAvailable() {
		return available;
	}

	public final void setAvailable(int available) {
		this.available = available;
	}

	public final int getScheduleNo() {
		return scheduleNo;
	}

	public final void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}

	@Override
	public String toString() {
		return "SeatVO [no=" + no + ", theaterName=" + theaterName + ", seatName=" + seatName + ", available="
				+ available + ", scheduleNo=" + scheduleNo + "]";
	}

}
