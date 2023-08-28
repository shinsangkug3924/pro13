<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//1. 한글처리 (request객체 메모리 영역에 요청한 데이터중에서 
				   //한글문자가 하나라도 존재하면 꺼내올때 꺠져서 꺼내와지기 떄문에 request객체메모리에 인코딩방식 UTF-8로 설정)
		request.setCharacterEncoding("UTF-8");
	
		//2. 요청한 값 얻기 (입력받은 아이디 얻기)
		String userID = request.getParameter("userID");
		
		//3. 요청한값을 조건식에 작성하여 판단후 응답
		//아이디를 입력하지 않았다면?
		if(userID.length()==0){
			//디스패처 방식으로 login.jsp서버페이지를 포워딩(재요청)시~ 현재 result.jsp가 사용하는 request객체 메모리 공유~
			//자바코드
			/*
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp"); 
							  dispatcher.forward(request, response);
			*/ 
	%>	
			<%-- 
				아이디를 입력하지 않았으면 다시 login.jsp를 재요청(포워딩)
				forward액션 태그 
			 --%>		
			 <jsp:forward page="login.jsp"/>
	<%	
		}
	%>

	 <h1>환영합니다 <%=userID%>님!!</h1>


</body>
</html>




