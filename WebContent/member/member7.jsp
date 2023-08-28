<%@page import="java.util.List"%>
<%@page import="sec01.ex01.MemberDAO"%>
<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
//1. 한글 인코딩 UTF-8설정
  request.setCharacterEncoding("UTF-8");
%> 
<jsp:useBean id="memberBean" class="sec01.ex01.MemberBean" scope="page"/>
<jsp:setProperty name="memberBean" property="*" />
	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- t_member테이블에서 조회된 모든 회원 정보를 표의 목록형태로 출력 --%>
	<table align="center" width="100%">
		<tr align="center" bgcolor="#99ccff">
			<td width="7%">아이디</td>
			<td width="7%">비밀번호</td>
			<td width="5%">이름</td>
			<td width="11%">이메일</td>
		</tr>
		<%-- getProperty액션태그 사용
			 - 자바빈 역할을 하는 VO객체의 private으로 은닉화된 인스턴스변수의 값을 반환시킬 getter메소드들을 
			      자바코드 대신 호출하는 태그.
			 - 자바코드의 for반복문이랑 같이 사용할수 없습니다. 그러나 JSTL태그의 반복문문법과는 같이 사용할수 있다.
		 	
		 	 - 문법
		 	 	<jsp:getProperty  name="useBean액션태그의 id속성에 작성한값"  property="반환받을 값이 저장된 변수명"/>
		 --%>
		 <tr align="center">
			<td width="7%"><jsp:getProperty  name="memberBean" property="id"/></td>
			<td width="7%"><jsp:getProperty  name="memberBean" property="pwd"/> </td>
			<td width="5%"><jsp:getProperty  name="memberBean" property="name" /> </td>
			<td width="11%"><jsp:getProperty name="memberBean" property="email"/> </td>
		</tr>
		 




		<tr height="1" bgcolor="#99ccff">
			<td colspan="5"></td>
		</tr>
	</table>

</body>
</html>








