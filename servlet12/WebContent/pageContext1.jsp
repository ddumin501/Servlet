<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
포함된 pageContext1.jsp에서 pageContext내장 객체 : <%=pageContext %> 
<br>
request내장객체:<%=request%> <%--core.ApplicationHttpRequest--%>
<br>
pageContext1의 attr중 이름이 p1인 값 :<%=pageContext.getAttribute("p1")%>
<br>
request의 attr중 이름이 r2인 값 :<%=request.getAttribute("r2")%>
<%request.setAttribute("r3", "v3");%>