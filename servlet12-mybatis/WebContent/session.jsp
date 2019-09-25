<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>session.jsp</title>
</head>
<body>
서블릿에서 HttpSession객체 얻기: request.getSession();<br>
JSP에는 이미 session내장객체가 제공됨!<hr>
세션 ID: <%=session.getId() %><br>
세션 생성 여부 : <%=session.isNew()?"지금 생성된 세션객체":"이전에 생성된 세션객체 참조" %><br>
세션 최종 사용시간 : <%=new Date(session.getLastAccessedTime())%>
</body>
</html>