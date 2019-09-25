package control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.service.ZipService;

public class ZipController {

	private ZipService service;

	static private ZipController controller = new ZipController();

	private ZipController() { // 외부 new객체 생성 못하게
		service = new ZipService();
	}

	static public ZipController getInstance() {
		return controller;
	}

	public String searchZip(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String doro = request.getParameter("doro");

		String str = service.searchZip(doro);

		request.setAttribute("result", str);
		String path = "/result.jsp";
		return path;

	}
}
