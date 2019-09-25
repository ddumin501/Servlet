<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!-- 외부 라이브러리 사용 할때 써야함-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:set var ="num" value="1"/>
c:set으로 선언한 num변수 : ${num}
<hr>
<c:set var ="foo" value="${param.foo}"/>
c:set으로 선언한 foo변수 : ${foo}
<!-- c:set으로 선언한 foo변수 + 1: ${foo + 1} -->
<hr>
<c:if test="${param.foo == 'hello'}">환영합니다</c:if> <!-- test의 속성값에는 el표기법 -->
<%-- <c:if test="${param.foo == null || param.foo == ''}"> --%><!-- 비어있을때 -->
<c:if test="${empty param.foo}">
<span style="color:red"> 요청전달데이터 foo가 없습니다.</span>
</c:if>
<c:choose>
<c:when test ="${param.foo == null}">환영합니다</c:when>
	<%-- <c:when test ="${param.foo == 'hello'}">환영합니다</c:when> --%>
	<c:when test ="${param.foo == 'bye'}">BYE BYE</c:when>
	<c:otherwise>${param.foo}</c:otherwise>
</c:choose>
<hr>
<c:forEach var="i" begin="1" end="5" step="2" >
${i}<br>
</c:forEach>
<hr>
<c:forEach var="i" begin="1" end="5" step="1" >
${i}<br>
</c:forEach>
<hr>
1~10까지합
<c:set var ="sum" value="0"/>
<c:forEach var='i' begin="1" end="10">
	<c:set var ="sum" value="${sum+i}"/>
</c:forEach>
:${sum}
<hr>
<c:forEach var="i" begin="1" end="20" step="3" varStatus="status">
${status.count}:${i}<br>
</c:forEach>
<hr>
<%
List<String> list = new ArrayList<>();
list.add("one");list.add("two");list.add("three");
request.setAttribute("list", list);
%>
향상된 for문<br>
<c:forEach var="s" items = "${requestScope.list}"> 
${s}<br>
</c:forEach>
<hr>
<%
Map<String, Integer>map = new HashMap<>();
map.put("one",1); map.put("two",2); map.put("three", 3);
request.setAttribute("map",map);
%>
<c:forEach var="obj" items = "${requestScope.map}"> 
${obj.key} : ${obj.value }<br>
</c:forEach>
</body>
</html>