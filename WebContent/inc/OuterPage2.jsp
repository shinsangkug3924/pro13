<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포함될 외부JSP파일</title>
</head>
<body>
	<h2>외부 파일 2</h2>
	<%
		String newVar2 = "백제 온조왕";
	%>
	<%--  page와 request내장객체 영역에서 속성값을 읽어와 출력   --%>
	<ul>
		<li>page내장객체 영역 속성 : <%=pageContext.getAttribute("pAttr") %></li>
		<li>request내장객체 영역 속성 : <%=request.getAttribute("rAttr") %></li>
	</ul>


</body>
</html>