package mall.member;

import java.sql.Timestamp;

public class MemberDTO {
	private String id;
	private String pwd;
	private String name; 
	private String email; 
	private String tel; 
	private String address;
	private Timestamp regDate;
	
	public String getId() {
		return id;
	}
	public String getPwd() {
		return pwd;
	}
	public String getName() {
		return name;
	}
	public String getEmail() {
		return email;
	}
	public String getTel() {
		return tel;
	}
	public String getAddress() {
		return address;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	
	@Override
	public String toString() {
		return "Member [id="+id+", pwd="+pwd+", name="+name+", email="+email+", tel="+tel+", address="+address+", regDate="+regDate+"]";
	}
}
