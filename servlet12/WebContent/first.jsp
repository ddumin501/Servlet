<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	첫번째 JSP입니다.
	<div>
		<h3>JSP구성요소</h3>
		<ul>
			<li>html요소 <!-- html주석 -->
			</li>
			<li>JSP요소 <%--JSP주석 --%>
				<ol>
					<li>scriptinig
						<ul>
							<li>scriptlet: __jspService()내부의 자바구문 <%
								int num; //__jspService()내부 지역변수 
								num = 15;
								//System.out.println(num);
							%><br> <%
 	out.print(num);
 %><br> <%
 	out.print(request.getParameter("opt"));
 %>
								<br> <%
 	out.print(new java.util.Date());
 %>
							</li>
							<li>expression:__jspService()내부 저장될 자바구문 out.print()자동호출됨 <br><%=num%>
								<br><%=request.getParameter("opt")%> <br><%=new java.util.Date()%></li>
							<li>declaration: __jspService()외부에 저장될 자바구문 <%!void m() {//out.println("mmm");
	}

	int num;//인스턴스변수%> 지역변수 num=<%=num%>, 인스턴스변수 num=<%=this.num%>
							</li>
						</ul>
					</li>
					<li>directive
						<ol>
							<li>page directive: .java만들어질때 필요한 정보를 설정<br>
								contentType, import, buffer, errorPage, isErrorPage속성 <%@page
									contentType="text/html; charset=utf-8"%> <%@page
									import="java.util.List"%> <%@page
									import="java.util.Map"%> <%@page
									import="java.util.Calendar"%> <%@page
									import="java.io.FileInputStream"%> <%@page
									import="java.io.FileNotFoundException"%>
								<%@page buffer="1000kb"%><%--기본 8kb,none  --%>
								<%
									List<String> list;
									Map<String, Object> map;
									Calendar calendar;
								%> <%--<%for(int i = 0; i <1000; i ++){
						if(i%100==0){%><br>
						<%}%>
						<%=i %>,
						<%				
					}--%> <%--
					FileInputStream fis = null;
					String FileName = "a.txt";
					try{
					fis = new FileInputStream(FileName);			
					}catch(FileNotFoundException e){
						request.setAttribute("exception", e);
						String path = "err.jsp";
						RequestDispatcher rd = request.getRequestDispatcher(path);
						rd.forward(request, response);
					}--%> <%@page errorPage="err.jsp"%> <%--
					FileInputStream fis = null;
					String FileName = "a.txt";				
					fis = new FileInputStream(FileName);			
					--%>
							</li>
							<li>include directive: <%@include file="jq/menu.jsp"%>
								<!--include 지시자는 html그대로 긁어옴  -->
							<li>taglib directive:</li>
						</ol>
					</li>
					<li>action tag
						<ol>
							<li>standard action tag -include tag <!--include태그는 html파일을 method의 인자로 받음 :실행될때 결과만 전달 -->
								<jsp:include page="jq/menu.jsp"></jsp:include>
								<hr>
													 -forward tag :잘 안씀
								<%--<jsp:forward page="jq/menu.jsp"></jsp:forward> --%>
								<hr>
								-useBean tag(아래주석과 같은역할)
								<jsp:useBean class = "com.my.vo.Customer" id = "c" scope="request"></jsp:useBean> 
								<%-- <%com.my.vo.Customer c = (Customer)request.getAttribute("c");
								if (c==null){
									c=new Customer();
									request.setAttribute("c",c);
								}
								%> --%> 
								<hr>
								setProperty / getProperty tag(아래주석과 같은역할)
								<jsp:setProperty name="c" property="pwd" value="p3"/>
								<%-- <% c.setPwd("p3"); %> --%>
								<jsp:getProperty name="c" property="pwd"/>
								<%-- <% c.getPwd; %> --%>
								
								<%--확장성 떨어짐 EL, JSTL-->
								<%-- <%=c.getPost().getZipcode() %> --%> 
							</li>
							<li>custom action tag</li>
						</ol>
					</li>
				</ol>
				<div>
				Default Object[내장객체]:
				.java파일의 __jspService()내부에 미리 선언되어있는 매개변수와 지역변수들
				<ul>
					<li>request-HttpServletRequest</li>
					<li>response-HttpServletResponse</li>
					<li>page - Object :현재객체</li>
					<li>out - JSPWriter :  응답출력스트림(PrintWriter+BufferedWriter)</li>
					<li>config -  ServletConfig</li>
					<li>session - HttpSession: 세션트래킹(서버사이드 상태정보 유지기술)</li>
					<li>application - ServletContext : 
					웹 어플리케이션의 정보(servlet, api, version, realpath..)를 담고있는 객체.
					웹컨텍스트 내의 Servlet과 JSP 사이의 공유객체로 사용됨
					</li>			
					<li>pageContext-PageContext:
					현재사용중인 JSP의 정보(request/response/out..)를 담고있는 객체
					</li>
					<li>exception : page지시자의 isErrorPage속성값이 true일때만 만들어짐
					(ex:err.jsp)</li>
				</ul>
				</div>
			</li>
		</ul>
	</div>
</body>
</html>