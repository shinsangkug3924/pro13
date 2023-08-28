package sec01.ex01;

import java.sql.Date;

//자바빈 역할을 하는 VO클래스
//- 회원테이블 (t_member)의  정보를 조회해와 변수에 저장하고, 회원한사람의 정보를 객체 단위로 공유하기 위한 클래스 
public class MemberBean {

	//t_member회원테이블의 컬럼명 자료형과 동일하게 변수이름과 자료형으로 변수선언합니다.
	private String id;
	private String pwd;
	private String name;
	private String email;
	private Date joinDate;
	
	//아무일도 하지 않는 기본생성자
	public MemberBean() {}

	//MemberBean클래스로 부터 객체 생성시 가입날짜를 제외한 인스턴스변수의 값들을 초기화 시킬 생성자
	public MemberBean(String id, String pwd, String name, String email) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
	}

	//MemberBean클래스로 부터 객체 생성시 객체 내부의 인스턴스변수의 값들을 모두 초기화 시킬 생성자
	public MemberBean(String id, String pwd, String name, String email, Date joinDate) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.joinDate = joinDate;
	}


	//privte으로 선언된 위 인스턴스변수에 저장된 값들을  새롭게 설정하는 setter와
	//private으로 선언된 위 인스턴스변수에 저장된 값들을 외부 클래스에 반환해서 공유할 목적의 getter 메소드들 만들기
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	
	
	
	

}






