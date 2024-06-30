package kr.ac.kopo.framework;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
	 * 						요청URI					응답JSP					Controller
	 * 전체게시글 조회 		/board/list.do			/board/list.jsp			BoardListController
	 * 새글등록양식			/board/writeForm.do		/board/writeForm.jsp	BoardWriteFormController
	 * 새글등록			/board/write.do			/board/write.jsp		BoardWriteController
 */

public class DispatcherServlet extends HttpServlet {

	private HandlerMapping mappings;

	@Override
	public void init(ServletConfig config) throws ServletException {
		String propLoc = config.getInitParameter("propLoc");
		mappings = new HandlerMapping(propLoc);
	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String uri = request.getRequestURI();
		uri = uri.substring(request.getContextPath().length());

		System.out.println("요청 URI : " + uri);

		try {
			Controller control = mappings.getController(uri);
			String callPage = control.handleRequest(request, response);

			RequestDispatcher dispatcher = request.getRequestDispatcher(callPage);
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
	}
}