package kr.ac.kopo.movie.vo;

public class MovieVO {
	private int no;
	private String title;
	private int runtime;
	private String openDate;
	private char status;
	private String kmdbUrl;
	private String posterUrl;
	private String rating;

	public final int getNo() {
		return no;
	}

	public final void setNo(int no) {
		this.no = no;
	}

	public final String getTitle() {
		return title;
	}

	public final void setTitle(String title) {
		this.title = title;
	}

	public final int getRuntime() {
		return runtime;
	}

	public final void setRuntime(int runtime) {
		this.runtime = runtime;
	}

	public final String getOpenDate() {
		return openDate;
	}

	public final void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public final char getStatus() {
		return status;
	}

	public final void setStatus(char status) {
		this.status = status;
	}

	public final String getKmdbUrl() {
		return kmdbUrl;
	}

	public final void setKmdbUrl(String kmdbUrl) {
		this.kmdbUrl = kmdbUrl;
	}

	public final String getPosterUrl() {
		return posterUrl;
	}

	public final void setPosterUrl(String posterUrl) {
		this.posterUrl = posterUrl;
	}

	public final String getRating() {
		return rating;
	}

	public final void setRating(String rating) {
		this.rating = rating;
	}

	@Override
	public String toString() {
		return "MovieVO [no=" + no + ", title=" + title + ", runtime=" + runtime + ", openDate=" + openDate
				+ ", status=" + status + ", kmdbUrl=" + kmdbUrl + ", posterUrl=" + posterUrl + ", rating=" + rating
				+ "]";
	}

}
