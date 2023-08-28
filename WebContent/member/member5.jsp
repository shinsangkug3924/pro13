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

%> 
	<%--기본생성자를 호출해 MemberBean객체를 생성하게 됩니다. --%>
	<jsp:useBean id="memberBean" class="sec01.ex01.MemberBean" scope="page"/>
		
    <%--2. 요청한 값 얻기(가입을 위해 입력한 값들 request에서 얻기)
    	3. MemberBean객체를 생성해서 각인스턴스변수에 요청한값 저장
    	
    	<jsp:setProperty>액션태그에 param속성을 다음과 같이 생략하고
    	property속성값만 지정하되......
    	회원가입창(memberForm.html)의 <input>태그의 name속성값과....
    	<jsp:setProperty>액션태그의 property속성값이  일치하면?
    	자동으로 request메모리영역에서 요청한 값을 얻어  MemberBean의 변수에 저장시킵니다.
    	
     --%>	
	<%--setId(String id)메소드 호출시  매개변수 id로  value속성에 적은 값을 전달해서  property속성에적은 id변수에 저장 --%>
	<jsp:setProperty name="memberBean" property="id" />
	<jsp:setProperty name="memberBean" property="pwd"/>
	<jsp:setProperty name="memberBean" property="name" />
	<jsp:setProperty name="memberBean" property="email" />

<%--
	setProperty액션태그는  자바빈역할을하는 VO의 setter메소드를 자바코드대신 작성할 태그이다.
	
	<jsp:setProperty   name="useBean액션태그의 id속성 값"  
					   property="setter메소드호출시 매개변수로 전달해서 저장할 변수명" 
					   value="setter메소드 호출시 매개변수로 전달할 값을 넣어줌"
					   />



	useBean액션태그는 자바코드 객체 생성하는 구문을 대체해서 작성할수 있는 태그이다.

	id속성에는 생성한 객체의 참조변수명을 지정해서 생성한 객체를 식별할 유일한 고유값을 지정합니다.
	class속성에는  사용하려는 자바빈역할을 하는 객체의 실제 패키지명을 포함한 클래스명을 지정합니다.
	scope속성에는  자바빈역할을 하는 VO또는 DTO객체를 생성후 저장될 내장객체메모리영역종류를 값으로 작성합니다.

	<jsp:useBean id="생성한객체를 식별할 고유값(참조변수명설정)"  
	            class="객체 생성시 사용될 클래스파일이 저장된 경로"  
	            scope="생성한객체는 어떤 내장객체 메모리에 저장할지 종류" />
	
 --%>	
<%	
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








