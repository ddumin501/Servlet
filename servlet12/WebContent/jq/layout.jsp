<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jq/layout.html</title>
<style>
header>nav>ul>li {
	display: inline-block;
	margin: 10px;
}

header>nav>ul>li>a {
	text-decoration: none;
}

header>nav>ul>li>a:hover {
	background-color: gray;
	font-weight: bold;
}

section {
	position:relative;
	width: 100%;
	height: 700px; /* 높이는 %단위 안된다.*/
}

section>div {
	float: left;
	width: 70%;
	height: 100%; /*부모가 정확한 px단위로 정해놓았기때문에 %단위 가능*/
}

article {
	/*display:inline-block;*/
	/*float:left;*/
	border: 1px solid;
	height: 30%;
	overflow: auto;
	margin-top: 10px;
}

aside {
	border: 1px solid;
	background-color: gray;
	width: 20%;
	height: 50%;
	/*display:inline-block;*/
	float: right;
}

footer {
	background-color: #777;
	color: white;
	text-align: center;
	margin-top: 10px;
	padding: 15px;
	position: absolute;
	bottom: 0;
	left: 0;
	right: 0;
}
</style>
</head>
<body>

	<!-- <div>HEADER</div>
		 <div>SECTION</div>
		 <div>FOOTER</div> -->

	<header style="background-color: #ccffee; border: 1px solid">
		<h1 style="text-align: center;">KITRI</h1>
		<nav style="background-color: white;">
			<!-- <ul>
				<li><a href="#">게시판</a></li>
				<li><a href="#">공지사항</a></li>
				<li><a href="login.html">로그인</a></li>
				<li><a href="join.html">가입</a></li>
				<li><a href="display.html">display.html</a></li>
			</ul> -->
			<!-- menu.html포함 rd.include() -->
			<jsp:include page="menu.jsp"></jsp:include>
			
		</nav>
	</header>
	<section>
		<div>
			<article>여기는 로그인창이다.</article>
			<article>여기는 회원가입창이다.</article>
		</div>
		<aside>광고</aside>
	</section>
	<footer>주소: 서울시 구로구 디지털로34길 &nbsp; &nbsp; &nbsp; &nbsp;연락처:
		02-869-8301</footer>

</body>
</html>