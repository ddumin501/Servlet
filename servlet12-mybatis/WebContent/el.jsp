<%@page import="com.my.vo.Post"%>
<%@page import="com.my.vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%--http://localhost:8080/servlet9/el.jsp?foo=hello --%>
요청전달데이터 [Expression] foo : <%=request.getParameter("foo") %><%--값없을때 null반환 --%><br>
[Expression Language] foo : ${param.foo}<%--값없을때 빈문자열반환 --%><hr>
<%
Customer c = new Customer();
c.setId("id1"); c.setPwd("p1");
Post p = new Post();
p.setBuildingno("987654321");
c.setPost(p);

request.setAttribute("c", c);
%>
요청속성[Expression] 고객의 아이디: <%=((Customer)request.getAttribute("c")).getId() %><br>
요청속성[Expression Language] 고객의 아이디: ${requestScope.c.id}<%--requestScope.c가 javabean유형이라 .사용 가능 --%>
<hr>
요청속성[Expression Language] 고객의 건물번호: ${requestScope.c.post.buildingno}
<hr>
웹컨텍스트경로 [Expression] : <%=request.getContextPath() %><br>
[Expression Language] : ${pageContext.request.contextPath}
<hr>
이미지파일의 실제 경로 [Expression] : <%=application.getRealPath("images/movie_image.jpg")%><br>
[Expression Language] : 제공안함<%-- ${pageContext.servletContext.} --%>
</body>
</html>