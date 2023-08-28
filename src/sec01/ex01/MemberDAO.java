package sec01.ex01;



import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/*
 MemberDAO클래스의 역할
 -> 오라클 DBMS의 XE데이터베이스 내부에 만들어 놓은 t_member테이블과 연결하여 작업할 클래스 
*/

public class MemberDAO {
		
		//위 4가지 접속 설정값을 이용해서 오라클 DB와 접속한 정보를 지니고 있는 Connection객체를 저장할 참조변수 선언
		private Connection con;
		
		//DB와 연결 후 우리 개발자가 만든 SQL문장을 오라클 DB의 테이블에 전송하여 실행할 역할을 하는 Statement실행객체의 주소를 저장할 참조변수 선언
		//private Statement stmt;
		private PreparedStatement pstmt;
			
		//SELECT문을 실행한 검색결과를 임시로 저장해 놓은 ResultSet객체의 주소를 저장할 참조변수 선언
		private ResultSet rs;
	
		//DataSouce커넥션풀 역할을 하는 객체의 주소를 저장할 참조변수
		private DataSource dataSource;
		
		//MemberDAO클래스의 기본생성자
		//역할 : new MemberDAO(); 객체 생성시 호출되는 생성자로 !!
		//     생성자 내부에서 커넥션풀 역할을 하는 DataSouce객체를 얻는 작업을 하게 됩니다.
		public MemberDAO() {
		
			try {
				//1.톰캣서버가 실행되면 context.xml파일에 적은 <Resouce>태그의 설정을 읽어와서
				//  톰캣서버의 메모리에 <Context>태그에 대한 Context객체들을 생성하여 저장해 둡니다.
				// 이때 InitialContext객체가 하는 역할은  톰캣서버 실행시 context.xml에 의해서 생성된 
				// Context객체들에 접근하는 역할을 하기때문에 생성합니다.
				Context ctx = new InitialContext();
				
				//2.JNDI기법(key를 이용해 값을 얻는 기법)으로 접근하기 위해 기본경로(java:/comp/env)를 지정합니다.
				// lookup("java:/comp/env"); 는 그중 톰캣서버의 환경설정에 관련된 Context객체들에 접근하기 위한 기본 경로 주소를 설정하는 것입니다
				Context envContext = (Context) ctx.lookup("java:/comp/env");
				
				//3.그런후 다시 톰캣서버는  context.xml에 설정한 <Resouce name="jdbc/oracle"....../>태그의
				// name속성값  "jdbc/oracle"(JNDI기법을 사용하기위한 key)를 이용해 톰캣 서버가 미리연결을 맺은 Connection객체들을 보관하고 있는
				// DataSouce커넥션풀 객체를 찾아서 반환해 줍니다.
				dataSource = (DataSource) envContext.lookup("jdbc/oracle");
				
			} catch (Exception e) {
				System.out.println("DataSouce커넥션풀 객체 얻기 실패  : " + e);
			}
		
		}
		
		
		//DB작업관련 객체 메모리들 자원해제 하는 메소드 
		public void ResourceClose() {	
			try {
				if(pstmt != null) {
					pstmt.close();
				}
				if(rs != null) {
					rs.close();
				}
				if(con != null) {
					con.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//오라클 DBMS서버 내부의 XE데이터베이스 내부에 만들어 놓은 t_member테이블의 모든회원정보들을 한번에 조회 해서 제공 하는 메소드
		public ArrayList listMembers() {//<----- member.jsp페이지에서 모든회원정보를 조회하기 위해 호출하는 메소드
			
			//t_member테이블에 저장된 모든 회원정보들을 조회해서 가져와 
			//배열의 각 index위치에 임시로 저장할 배열공간인? ArrayList생성
			ArrayList list = new ArrayList();
			
			try {
				//DB와의 접속!
				//위 dataSouce참조변수에 저장된 DataSource커넥션풀 객체 내부에 존재하는
				//미리 DB의 테이블과 미리연결을 맺은  Connection객체를 빌려옵니다.(반환받는다)
				con = dataSource.getConnection();
			
				//순서4. PreparedStatement실행 객체 얻기
				//순서5. Query(SQL문) 작성하기 
				//t_member테이블에 저장된 모든 회원을 조회 하는 SELECT SQL문 작성
				String query = "select * from t_member";
				pstmt = con.prepareStatement(query);
				
				//순서6. Query(SQL문)을 DB의 t_member테이블에 전송하여 실행!(조회됨)
				//select * from t_member SQL문을 이용하여 조회후 조회한 결과 데이터들을 ResultSet객체 메모리에 저장후 반환 받습니다.
				//단! 조회된 화면의  커서(화살표)위치는  가장 처음에는  조회된 테이블의 제목열 행을 가리키고 있다.
			   //rs = stmt.executeQuery(query);
				 rs = pstmt.executeQuery();
				
				
				//순서7. 조회한 회원 레코드들이 ResultSet객체 메모리에 표형태로 저장되어 있으면 계속 반복해서 
				//      회원 레코드(행)단위의 조회된 열 값들을 차례로 얻어  
				//      MemberBean객체를 생성하여 각 인스턴스변수에 저장시킵니다.
				//      MemberBean객체를  ArrayList가변길이 배열에 반복해서 추가시킵니다.
				while( rs.next() ) {
					//회원 레코드(행)단위의 조회된 열 값들을 차례로 얻어
					String id = rs.getString("ID");
					String pwd = rs.getString("PWD");
					String name = rs.getString("NAME");
					String email = rs.getString("EMAIL");
					Date joinDate = rs.getDate("JOINDATE");
					
					//MemberBean객체를 생성하여 각 인스턴스변수에 저장시킵니다.
					MemberBean vo = new MemberBean(id, pwd, name, email, joinDate);
					
					//MemberBean객체를  ArrayList가변길이 배열에 반복해서 추가시킵니다.
					list.add(vo);
				}
			
			} catch (Exception e) {
				System.out.println("listMembers메소드 내부에서 SQL문 실행 오류 : " + e);
			} finally {
				
				//순서9. DB작업관련 객체 메모리들 자원해제
				ResourceClose();
			}
			
			return list;//ArrayList배열 자체를 member.jsp으로 반환(리턴)
		
		}//listMembers메소드 닫기 
		
		
		//memberForm.html에서 입력한 가입할 회원 내용을
		//MemberBean객체의 각 인스턴스변수에 저장한 뒤~~~~
		//addMember메소드 호출시!!! 매개변수로 전달 받아  INSERT문장을 만들고
		//INSERT문장을 DB의 t_member테이블에 전송해서  새 회원을 추가 시키는 기능의 메소드 
		public void addMember(MemberBean   memberVO) { //<---- member.jsp 내부에서 호출하는 메소드 
			
			try {
				//1. 커넥션풀(DataSouce)에서 미리 DB와 연결을 맺은 Connection객체 얻기 
				//요약 : DB연결
				con = dataSource.getConnection();
				
				//2. t_member테이블에 INSERT할 값 ! 즉! 우리가 입력한 회원정보들은 MemberBean객체의 각 인스턴스변수에 저장되어 있으므로
				//   MemberBean객체의 getter메소드들을 호출해서 각 인스턴스 변수에 저장된 입력한 값들을 반환받자.
				String id = memberVO.getId();
				String pwd = memberVO.getPwd();
				String name = memberVO.getName();
				String email = memberVO.getEmail();
				
				//3. insert SQL문장 만들기  Verson1.  Statement실행객체를 사용할때 만드는 방법
				//String query = "insert into t_member(id, pwd, name, email)values('"+id+"','"+pwd+"','"+name+"','"+email+"')"; 
				
				//3. insert SQL문장 만들기 Verson2. PreparedStatement실행객체를 사용할떄 만드는 방법
				String query = "insert into t_member(id, pwd, name, email)values(?,?,?,?)"; 
				
				//4. query변수에 저장된 전체 insert문자열을 미리 로드한 OraclePreparedStatementWrapper실행 객체 얻기
				pstmt = con.prepareStatement(query);
				//4.1 OraclePreparedStatementWrapper실행객체에 위 변수에 저장된 값들을 ?기호에 대응되게 설정
				pstmt.setString(1, id); //입력하여 추가할 아이디
				pstmt.setString(2, pwd); //입력하여 추가할 비밀번호 
				pstmt.setString(3, name);//입력하여 추가할 이름 
				pstmt.setString(4, email);//입력하여 추가할 이메일
				//참고. 회원가입 날짜 정보가 저장되는  joinDate열의 값은 t_member테이블 만들때  default설정을 통해 sysdate로 값을 적어 놓았기떄문에
				//     따로 insert하지 않으면  현재 날짜정보가 sysdate예약어에 의해 자동으로 같이 insert됩니다. 
				
				//5. OralcePreparedStatementWrapper실행객체에  설정된 전체 insert문장을 DB의 테이블에 전송해서 실행!
				pstmt.executeUpdate(); //insert에 성공하면 insert에 성공한 레코드 갯수 1을 반환 , 실패하면 0을 반환 !
							
			} catch (Exception e) {
				System.out.println("MemberDAO의 addMember메소드 내부에서  SQL문 실행 오류  : " + e);
			} finally {
				//자원해제 
				ResourceClose();
			}
			
		}//addMember메소드 닫기 


		//삭제 <a>링크를 클릭했을때.. 서블릿으로 전송해온  삭제할 회원의 id를 매개변수로 전달 받아서
		//DELETE문장 완성후 ~  DB의 회원한사람의 정보를 삭제시키는 기능의 메소드 
		//참고.  DELETE FROM 삭제할테이블명  where 삭제할조건열=삭제할조건값;
		public void delMember(String id) {
			
			try {
				//1.커넥션풀(DataSouce)객체 내부에 있는 Connection객체 얻기(DB연결)
				con = dataSource.getConnection();
				//2.매개변수로 전달 받은 삭제할 회원 아이디를 이용해 DELETE SQL문장 만들기
				String query = "delete from t_member where id=?";
				//3. delete문장 전체를 미리 로드한 OraclcePreparedStatementWrapper실행 객체 얻기
				pstmt = con.prepareStatement(query);
				//3.1 ? 설정
				pstmt.setString(1, id);
				//4. 완성된 delete전체 문장을  DB에 전송해서 실행!
				pstmt.executeUpdate(); //삭제에 성공하면 1을 반환 , 삭제에 실패하면 0을 반환 
				
			} catch (Exception e) {
				System.out.println("MemberDAO의 delMember메소드 내부에서 SQL문 실행 오류 : " + e);
			} finally {
				//자원해제 
				ResourceClose();
			}
		}


		//로그인 처리를 위한  입력한 아이디와 비밀번호가 DB의 테이블에서 조회되면?
		//true반환 하고 조회가 되지 않으면 false를 반환 하는 메소드 !
		public boolean isExitsted(MemberBean memberVO) {

			//플래그변수 : 조회되면 true저장, 조회안되면 false를 저장
			boolean result = false;
			
			try {
				//1.커넥션풀(DataSouce)객체 내부에 있는 Connection객체 얻기(DB연결)
				con = dataSource.getConnection();
				//2.입력한 아이디와 비밀번호가 DB의 t_member테이블에 저장되어 있는지 판단하는 SELECT문 작성
				String query = "select  decode( count(*), 1, 'true','false') as RESULT from t_member where id=? and pwd=?";
				//참고. 오라클에서 제공하는 decode()함수는  조회한 정보가 있으면 true반환하고 없으면 false를 반환하는 함수
				//     decode( count(*), 1, 'true','false');
			/*	
				decode 함수는 오라클 데이터베이스에서 제공하는 조건식 함수로, 
				여러 개의 값을 비교하여 일치하는 값이 있을 경우 특정 값을 반환하는 역할을 합니다. 
				일반적으로 CASE 문과 비슷한 기능을 수행하지만, 문법과 용도가 약간 다릅니다.

				decode 함수의 기본 문법
					decode(expression, value1, result1, value2, result2, ..., default_result)
				
				- expression: 비교할 값 또는 표현식입니다. 이 값이 `value1`, `value2`, ...와 일치하는지 확인합니다.
				- value1: expression과 비교할 첫 번째 값입니다.
				- result1: expression이 value1과 일치하는 경우 반환할 결과 값입니다.
				- value2, result2: 추가적인 값을 비교하고 결과 값을 지정할 수 있습니다. 필요한 만큼 쌍을 추가할 수 있습니다.
				- default_result: 모든 비교 값과 일치하지 않을 때 반환할 기본 결과 값입니다.

				decode 함수의 동작과정
				1. expression의 값이 value1과 일치하면, result1을 반환합니다.
				2. expression의 값이 value1과 일치하지 않고, value2와 일치하면, result2를 반환합니다.
				3. 이와 같이 비교가 계속됩니다. 만약 어떤 값과도 일치하지 않으면 default_result를 반환합니다. 
				   default_result를 생략하면 NULL이 반환됩니다.
			 */
					
				
				
				
				
				//3. 위 query변수에 저장된 select문장 전체를 미리 담은 PreparedStatement실행 객체 얻기
				pstmt = con.prepareStatement(query);
				//3.1  ? 두개 대신 우리가 입력한 아이디와  비밀번호로 설정
				pstmt.setString(1, memberVO.getId());
				pstmt.setString(2, memberVO.getPwd());
				//4. PreparedStatment객체 메모리에 설정된 전체 select문장을 DB의 t_member테이블에 전송해서 실행합니다.
				//   실행한 조회 결과를 ResultSet임시 객체 메모리에 담아서 받아옵니다.
				rs = pstmt.executeQuery();
				//4.1 조회결과 ResultSet객체 메모리의 커서 위치가 조회된 제목열이름을 가리키고 있으므로  next()메소드를 호출하여 
				//   조회된 행 줄이 있는지 검사한후 커서의 위치를 내려준다.
				if( rs.next() ) {
					//4.2 ResultSet객체 메모리의 커서가 위치한 행줄의 result별칭열에 대한 조회된 "true"또는 "false"를 ResultSet객체에서 얻자
					 String resultStr  = rs.getString("RESULT");
					 result = Boolean.parseBoolean(resultStr); //true또는 false가 저장됨.  true는 조회됨. false는 조회X.
				}
				 System.out.println("result=" + result);
					
			} catch (Exception e) {
				System.out.println("MemberDAO객체의 isExitsted메소드 내부에서  SELECT문 실행 오류 : " + e);
			} finally {
				//자원해제 
				ResourceClose();
			}
		
			return result;//입력한 아이디 비밀번호가 DB에서 조회되면? true반환   조회되지 않으면?  false를 반환
						  //메소드를 호출한 LoginServlet서블릿의 doHandle메소드 내부로 반환!
		}//isExited메소드
			

}//MemberDAO클래스 닫기 











