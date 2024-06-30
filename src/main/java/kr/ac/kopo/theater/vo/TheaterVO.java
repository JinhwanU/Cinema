package kr.ac.kopo.theater.vo;

public class TheaterVO {
	private String theaterName;
	private int totalSeats;

	public final String getTheaterName() {
		return theaterName;
	}

	public final void setTheaterName(String theaterName) {
		this.theaterName = theaterName;
	}

	public final int getTotalSeats() {
		return totalSeats;
	}

	public final void setTotalSeats(int totalSeats) {
		this.totalSeats = totalSeats;
	}

	@Override
	public String toString() {
		return "TheaterVO [theaterName=" + theaterName + ", totalSeats=" + totalSeats + "]";
	}

}
