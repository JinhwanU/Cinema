package kr.ac.kopo.post.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kopo.framework.Controller;
import kr.ac.kopo.post.dao.PostDAO;
import kr.ac.kopo.post.vo.PostVO;

public class PostListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PostDAO postDao = new PostDAO();
		List<PostVO> postList = postDao.selectAllPosts();
		request.setAttribute("postList", postList);

		return "/post/list.jsp";
	}

}
