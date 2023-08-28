<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String msg = (String)request.getAttribute("msg");//"아이디를 입력하지 않았습니다. 아이디를 입력해주세요."
		
		if(msg != null){//경고메세지가 저장되어 있을떄만? 경고메세지를 보여주자
			out.println("<h1>" + msg + "</h1>");
		}
	%>
	

	<%-- 로그인 요청 화면에서 ID와 비밀번호를 입력한 후  <form>태그의 action속성에 로그인요청할 result3.jsp주소를 작성해서 요청 --%>
	<form action="result3.jsp" method="post" >
		아이디 : <input type="text" name="userID"><br>
		비밀번호 : <input type="password" name="userPw"><br>
		
		<%--전송 버튼으로 만들수 있는 경우 --%>
		<input type="submit" value="로그인">
<!-- 	<button>로그인</button> -->
<!-- 	<input type="image" src="s.png"/> -->
		
		<input type="reset" value="다시 입력">
	</form>
	
	
	
</body>
</html>