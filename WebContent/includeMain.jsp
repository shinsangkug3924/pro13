<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 두 외부 파일을  include디렉티브태그(지시어태그)와  include액션태그로 
	// 각각 인클루드하여  어떤 차이가 있는지 알아보겠습니다.
	
	//1.포함할 파일의 경로를 변수에 저장합니다.
	String outerPath1 = "./inc/OuterPage1.jsp"; //첫번째 외부파일 경로 
	String outerPath2 = "./inc/OuterPage2.jsp"; //두번째 외부파일 경로 
	
	//2. page영역과 request영역에 속성을 바인딩(저장)합니다.
	// 여기서 바인딩한 속성은  두 파일에서 읽어 올수 있는지 확인하기 위한 용도 입니다.
	pageContext.setAttribute("pAttr", "동명왕");
	request.setAttribute("rAttr", "온조왕");
%>    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>include디렉티브(지시어)태그와   include액션태그 동작 방식 비교</h2>
	
	<%-- include디렉티브 태그 방식 --%>
	<h3>include디렉티브 태그로 외부페이지 소스 포함시키기</h3>
	
		<%@ include file="./inc/OuterPage1.jsp" %>
	
<%-- 표현식을 사용한다면 에러가 발생합니다. --%>
<%-- 	<%@ include file="<%=outerPath1%>"> --%>

<%-- OuterPage1.jsp외부파일에 작성한 newVar1변수에 저장된 문자열 출력  --%>
<%-- 출력되는 이유 : 
	include디렉티브태그를 위에서 사용했기 때문에 includeMain.jsp실행하기 전에 
	외부파일의 코드를 포함시켜 컴파일을 한번만 진행하므로 
	includeMain.jsp와 OuterPage1.jsp둘이는 결국 같은 하나의 페이지로 
	톰캣서버가 인식해서 실행하기 떄문입니다.
 --%>
	<p>외부 파일에 선언한 변수 : <%=newVar1%></p>
		
	<%-- include액션태그 방식 --%>
	<h3>include액션태그로 외부페이지 소스 포함하기</h3>
	
	<%-- 모든 include액션태그로 외부 페이지의 소스내용을 포함시킵니다. --%>
	<jsp:include page="./inc/OuterPage2.jsp"/>
	<jsp:include page="<%=outerPath2%>"/>
	
	<%-- 에러 발생 이유 : 액션태그 방식에서는 실행의 흐름만 이동(재요청)시켜
        외부파일에서 실행된 결과값만 가져와 현재페이지에 포함시키기 떄문입니다. --%>
	<p>외부 파일에 선언한 변수  : <%-- <%=newVar2%> --%>     </p>
</body>
</html>









