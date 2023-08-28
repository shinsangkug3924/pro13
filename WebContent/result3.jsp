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
	%>
	
	<%!
		//login3.jsp화면에서 아이디를 입력받지 않고  로그인 버튼을 누르면  재요청에의해 login3.jsp에 보여질 경고메세지 저장할 변수
		String msg = "아이디를 입력하지 않았습니다. 아이디를 입력해주세요.";

	%>

	<%
		request.setAttribute("msg", msg); //바인딩
	
		//2. 요청한 값 얻기 (입력받은 아이디 얻기)
		String userID = request.getParameter("userID");
		
		//3. 요청한값을 조건식에 작성하여 판단후 응답
		//아이디를 입력하지 않았다면?
		if(userID.length()==0){
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("login3.jsp");
			dispatcher.forward(request, response);
		}
	%>

	 <h1>환영합니다 <%=userID%>님!!</h1>


</body>
</html>




