<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//include1.jsp페이지에 작성한 <jsp:include>액션태그에 의해 재요청 당한 duke_image.jsp파일 입니다.
	//재요청 하여 공유받은  request객체 메모리에 접근해서  재요청할때의 값을 꺼내어 사용
	
	//1.인코딩 방식 UTF-8설정
	request.setCharacterEncoding("UTF-8");
	
	//2.재요청시 요청한 값 얻기 (param액션태그를 이용해  duke_image.jsp재요청시  요청한 값은  request의 getParameter메소드를 이용한다.)
	String name = request.getParameter("name"); // <jsp:param name="name" value="듀크" />액션태그에 작성한 name속성값 "name"작성
	String imgName = request.getParameter("imgName"); //<jsp:param name="imgName" value="duke.png" />
													  //액션태그에 작성한 name속성값 "imgName"작성 
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>include1.jsp</title>
</head>
<body>
<br><br>
<h1>이름은 <%=name%>입니다.</h1>
<br><br>
<img src="./image/<%=imgName%>"/>    
</body>
</html>








