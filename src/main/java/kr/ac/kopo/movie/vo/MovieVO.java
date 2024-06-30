package kr.ac.kopo.movie.vo;

public class MovieVO {
	private int no;
	private String title;
	private int runtime;
	private String openDate;
	private char status;

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getRuntime() {
		return runtime;
	}

	public void setRuntime(int runtime) {
		this.runtime = runtime;
	}

	public String getOpenDate() {
		return openDate;
	}

	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public char getStatus() {
		return status;
	}

	public void setStatus(char status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "MovieVO [no=" + no + ", title=" + title + ", runtime=" + runtime + ", openDate=" + openDate
				+ ", status=" + status + "]";
	}

}
