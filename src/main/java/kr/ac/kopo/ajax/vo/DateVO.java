package kr.ac.kopo.ajax.vo;

public class DateVO {
	private String date;
	private String formattedDate;

	public final String getDate() {
		return date;
	}

	public final void setDate(String date) {
		this.date = date;
	}

	public final String getFormattedDate() {
		return formattedDate;
	}

	public final void setFormattedDate(String formattedDate) {
		this.formattedDate = formattedDate;
	}

	@Override
	public String toString() {
		return "DateVO [date=" + date + ", formattedDate=" + formattedDate + "]";
	}

}
