package kr.ac.kopo.post.vo;

import kr.ac.kopo.movie.vo.MovieVO;

public class PostVO {
	private int no;
	private int movieNo;
	private String writer;
	private String content;
	private int grade;
	private int viewCnt;
	private String regDate;
	private String imgUrl;
	private char status;
	private MovieVO movie;

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

	public final String getWriter() {
		return writer;
	}

	public final void setWriter(String writer) {
		this.writer = writer;
	}

	public final String getContent() {
		return content;
	}

	public final void setContent(String content) {
		this.content = content;
	}

	public final int getGrade() {
		return grade;
	}

	public final void setGrade(int grade) {
		this.grade = grade;
	}

	public final int getViewCnt() {
		return viewCnt;
	}

	public final void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}

	public final String getRegDate() {
		return regDate;
	}

	public final void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public final String getImgUrl() {
		return imgUrl;
	}

	public final void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public final char getStatus() {
		return status;
	}

	public final void setStatus(char status) {
		this.status = status;
	}

	public final MovieVO getMovie() {
		return movie;
	}

	public final void setMovie(MovieVO movie) {
		this.movie = movie;
	}

	@Override
	public String toString() {
		return "PostVO [no=" + no + ", movieNo=" + movieNo + ", writer=" + writer + ", content=" + content + ", grade="
				+ grade + ", viewCnt=" + viewCnt + ", regDate=" + regDate + ", imgUrl=" + imgUrl + ", status=" + status
				+ ", movie=" + movie + "]";
	}

}
