<%@page import="java.util.List"%>
<%@page import="sec01.ex01.MemberDAO"%>
<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	/*
		member.jsp설명
		- memberForm.html(회원가입을 위해 입력한 정보를 요청하는 화면)에서 입력한 가입할 정보들을
		  request객체 메모리에서 가져온후 ...
		  MemberBean클래스의 객체 생성후 각 인스턴스변수에 저장 시킵니다.
		  그런 다음 MemberDAO객체를 생성해서 addMember()메소드 호출시~~ 이메소드의 매개변수로 MemberBean객체의 주소를 전달합니다
		  addMember메소드 내부에서  회원가입정보를 DB의 t_member테이블에 INSERT시킨후~
		  INSERT에 성공하면 다시 ~ MemberDAO객체의 listMembers()메소드를 호출해!!
		  DB의 t_member테이블에 저장된 가입된 회원정보들을 조회해와서 현재 member.jsp에 목록으로 출력(응답)합니다.
	*/
	
	//1. 한글 인코딩 UTF-8설정
	request.setCharacterEncoding("UTF-8");

	//2. 요청한 값 얻기(가입을 위해 입력한 값들 request에서 얻기)
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	//out.println(id + "," + pwd + "," + name + "," + email);
	
	//3. 요청한값을 통해 비즈니스로직 처리한 응답할 값을 마련
	//MemberBean객체를 생성해서 각인스턴스변수에 요청한값 저장
	MemberBean memberBean = new MemberBean(id,pwd,name,email);
	//MemberDAO객체를 생성해서 addMember메소드 호출시 addMember메소드의 매개변수로 DB에 insert할 정보가 저장된 MemberBean객체의 주소 전달
	MemberDAO memberDAO = new MemberDAO();
			  memberDAO.addMember(memberBean); //DB의 t_member테이블에 입력한 새회원 정보 추가 INSERT
			  
	//DB의 t_member테이블에 저장되어 있는 모든 회원정보들을 조회SELECT하기 위해 MemberDAO객체의 listMembers()메소드 호출!
	List membersList = memberDAO.listMembers();
			  
	//out.println(membersList.size());	  
	
%>     
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
			<td width="5%">가입일</td>
		</tr>
<%
	//t_member테이블에 조회 한 회원정보가 없으면?(t_member테이블에 저장된 회원이 없으면?)
	if(membersList.size() == 0){
%>		
		<tr>
			<td colspan="5">등록된 회원이 없습니다.</td>	
		</tr>
<%	
	}else{ //t_member테이블에 조회한 회원이 있다면?(ArrayList배열에 조회된 MemberBean객체들이 저장되어 있다면?)
			
		//for반복문을 이용해 ArrayList배열에 저장된 MemberBean객체를 하나씩 얻은후
		//얻은 MemberBean객체의 각인스턴스변수의 회원정보 데이터를 getter메소드들을 호출해 최종얻어 한사람 정보씩 한행에 출력합니다.
		for(int i=0;  i<membersList.size();  i++){
			MemberBean bean = (MemberBean)membersList.get(i);
%>			
		<tr align="center">
			<td width="7%"><%=bean.getId()%></td>
			<td width="7%"><%=bean.getPwd()%></td>
			<td width="5%"><%=bean.getName()%></td>
			<td width="11%"><%=bean.getEmail()%></td>
			<td width="5%"><%=bean.getJoinDate()%></td>
		</tr>	
<%			
		}//for 닫기 
		
	}//else 닫기 

%>	
		<tr height="1" bgcolor="#99ccff">
			<td colspan="5"></td>
		</tr>
	</table>

</body>
</html>








