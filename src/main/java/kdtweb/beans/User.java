package kdtweb.beans;

import java.sql.Timestamp;

public class User {
	
   private int id;	
   private String userid;	
   private String userpass;
   private String username;
   private String useremail;
   private String usertel;
   private int userpost;
   private String useraddr1;
   private String useraddr2;
   private String useraddrexc;
   private Timestamp rdate;
   private int grade;
   
   
   public Timestamp getRdate() {
	return rdate;
	}
	
	public void setRdate(Timestamp rdate) {
		this.rdate = rdate;
	}
	
	public int getGrade() {
		return grade;
	}
	
	public void setGrade(int grade) {
		this.grade = grade;
	}

   public int getId() {
	return id;
   }

   public void setId(int id) {
	this.id = id;
   }
   
   public String getUserid() {
	 return userid;
   }
   
   public void setUserid(String userid) {
	  this.userid = userid;
   }
   
	public String getUserpass() {
		return userpass;
	}
	public void setUserpass(String userpass) {
		this.userpass = userpass;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUseremail() {
		return useremail;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public String getUsertel() {
		return usertel;
	}
	public void setUsertel(String usertel) {
		this.usertel = usertel;
	}
	public int getUserpost() {
		return userpost;
	}
	public void setUserpost(int userpost) {
		this.userpost = userpost;
	}
	public String getUseraddr1() {
		return useraddr1;
	}
	public void setUseraddr1(String useraddr1) {
		this.useraddr1 = useraddr1;
	}
	public String getUseraddr2() {
		return useraddr2;
	}
	public void setUseraddr2(String useraddr2) {
		this.useraddr2 = useraddr2;
	}
	public String getUseraddrexc() {
		return useraddrexc;
	}
	public void setUseraddrexc(String useraddrexc) {
		this.useraddrexc = useraddrexc;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", userid=" + userid + ", userpass=" + userpass + ", username=" + username
				+ ", useremail=" + useremail + ", usertel=" + usertel + ", userpost=" + userpost + ", useraddr1="
				+ useraddr1 + ", useraddr2=" + useraddr2 + ", useraddrexc=" + useraddrexc + ", rdate=" + rdate
				+ ", grade=" + grade + "]";
	}


		   
}
