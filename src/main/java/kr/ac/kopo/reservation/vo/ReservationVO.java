package kr.ac.kopo.reservation.vo;

public class ReservationVO {
	private int no;
	private String memberId;
	private int movieNo;
	private String seatName;
	private int scheduleNo;
	private int headcount;
	private int payment;
	private String regDate;

	public final int getNo() {
		return no;
	}

	public final void setNo(int no) {
		this.no = no;
	}

	public final String getMemberId() {
		return memberId;
	}

	public final void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public final int getMovieNo() {
		return movieNo;
	}

	public final void setMovieNo(int movieNo) {
		this.movieNo = movieNo;
	}

	public final String getSeatName() {
		return seatName;
	}

	public final void setSeatName(String seatName) {
		this.seatName = seatName;
	}

	public final int getScheduleNo() {
		return scheduleNo;
	}

	public final void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}

	public final int getHeadcount() {
		return headcount;
	}

	public final void setHeadcount(int headcount) {
		this.headcount = headcount;
	}

	public final int getPayment() {
		return payment;
	}

	public final void setPayment(int payment) {
		this.payment = payment;
	}

	public final String getRegDate() {
		return regDate;
	}

	public final void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "ReservationVO [no=" + no + ", memberId=" + memberId + ", movieNo=" + movieNo + ", seatName=" + seatName
				+ ", scheduleNo=" + scheduleNo + ", headcount=" + headcount + ", payment=" + payment + ", regDate="
				+ regDate + "]";
	}

}
