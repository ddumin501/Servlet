<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
span:hover{
 position: relative;
}
span:hover:after {
	content: attr(data);
    position: absolute;
	bottom: 100%; 
	left: 0;    
	width: 100%;
	
    background-color: rgba(0, 0, 0, 0.8);
	color: #FFFFFF;
	font-size: 8px;
	z-index: 9999;
}
</style>
</head>
<body>
<%String star = request.getParameter("star");%>
<h1><%=star%>점을 선택하셨습니다.</h1>
<%--int cnt=0; //__jspService()내부 지역변수--%>
<%!int cnt=0; //__jspService()외부 인스턴스변수%>
<%!int sum = 0;%>
<% sum += Integer.parseInt(star); %> 
참여인원 <%= ++cnt %>명<br>
<%double avg = (float)sum/cnt; %>
평점 :<%= avg%> 점(별점누적값:<span data="총점"><%= sum %></span>/참여인원:<span data="참여인원"><%=cnt %></span>명)
</body>
</html>