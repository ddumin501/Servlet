package control;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//private BoardController boardC;

	public DispatcherServlet() {
		//boardC = new BoardController();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("DispatcherServlet의 service()가 호출됨!");
		String uri = request.getRequestURI();
		System.out.println("uri=" + uri);

		String contextPath = request.getContextPath();/* =/servlet12 */
		int index = contextPath.length();
		// 실제 요청한 url
		String servletPath = uri.substring(index);
		System.out.println(servletPath);
		String path = "/error/err404.jsp";
		
		/*if ("/boardlist".equals(servletPath)) {
			path = boardC.boardList(request, response);
		} else if ("/boarddetail".equals(servletPath)) {
			path = boardC.boardDetail(request, response);
		}*/
		//1)dispatcher.properties파일의 프로퍼티이름과 값 가져오기
		ServletContext sc = getServletContext();
		String realPath = sc.getRealPath("dispatcher.properties");
		
		Properties env = new Properties(); //Map계열  API
		env.load(new FileInputStream(realPath));//프로퍼티파일 로드
									//파일에 있는 프로퍼티들이 env에 저장됨
		//2)servletPath변수값과 같은 프로퍼티 찾기
		String classNMethodName = env.getProperty(servletPath);
	
		//3)프로퍼티값 얻기, 분석
		int classNMethodIndex = classNMethodName.lastIndexOf(".");
		String className = classNMethodName.substring(0, classNMethodIndex);
		String methodName = classNMethodName.substring(classNMethodIndex+1);
		
		//4)클래스이름과 메서드 이름 찾기 -- ★리플렉션★
		try {
			Class clazz = Class.forName(className);//클래스이름에 해당하는 클래스 찾기
			//5)클래스이름에 해당하는 객체 찾기 -- 싱글톤패턴
			//Object obj = clazz.newInstance();//클래스타입의 객체생성
			Method getInstanceMethod = clazz.getMethod("getInstance",null); //static변수
			Object obj = getInstanceMethod.invoke(null, null); //싱글톤 패턴의 controller 리턴
			//6)객체가 갖고있는 메서드 이름으로 메서드 찾기
			Method method = clazz.getMethod(methodName, 
					HttpServletRequest.class, 
					HttpServletResponse.class);//메서드이름에 해당하는 메서드 찾기
			//7)메서드 호출하기
			path = (String)method.invoke(obj, request, response);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) { //접근오류
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		if(path.equals("-1")) {
			return;
		}
		RequestDispatcher rd = request.getRequestDispatcher(path);
		rd.forward(request, response);
	}

	
}
