package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.my.service.CustomerService;
import com.my.vo.Customer;
import com.my.vo.Post;

public class CustomerController {
	private CustomerService service;

	static private CustomerController controller = new CustomerController();

	private CustomerController() { // 외부 new객체 생성 못하게
		service = new CustomerService();
	}

	static public CustomerController getInstance() {
		return controller;
	}

	public String join(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Customer c = new Customer();
		Post p = new Post();
		c.setId(request.getParameter("id"));
		c.setPwd(request.getParameter("pwd"));
		c.setName(request.getParameter("name"));
		p.setBuildingno(request.getParameter("buildingno"));
		c.setPost(p);
		c.setAddr(request.getParameter("addr2"));

		String str = service.join(c);
		request.setAttribute("result", str);

		String path = "/result.jsp";
		return path;
	}

	public String login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		session.removeAttribute("loginInfo"); // 초기화

		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");

		String str = service.login(id, pwd);
		/*----로그인 성공시 HttpServlet HttpSession객체의 속성으로 추가-----------*/
		JSONParser parser = new JSONParser();
		try {
			Object obj = parser.parse(str);
			JSONObject jsonObj = (JSONObject) obj;
			if ((Long) jsonObj.get("status") == 1) {// 로그인 성공
				session.setAttribute("loginInfo", id);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		request.setAttribute("result", str); // request의 attribute에 저장 -> forward시 필요한 공유객체 생성

		String path = "/result.jsp";
		return path;
	}

	public String logout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		// session.removeAttribute("loginInfo");
		session.invalidate();
		String path = "/jq/layout.jsp";
		return path;
	}

	public String dupchk(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");

		String str = service.dupchk(id);

		request.setAttribute("result", str);
		return "-1";
	}
}
