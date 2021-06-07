// created on 2002-2-26 at 20:54
package net.acai.forum;
/**
 * Title:        清清网络
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */
import net.acai.forum.UserNotFoundException;
import net.acai.database.*;
import net.acai.forum.util.*;
import net.acai.util.*;
import javax.servlet.http.*;
import java.sql.ResultSet;
import net.acai.filter.*;
public class User
{
	private String username,password,lastlogin;
	private int userID,article,logins,width,height,bbsType,lockUser,userClass,userWealth,userEP,userCP;
	private String userName,userEmail,userPassword,sign,sex,homePage,addDate;
	private String face,oicq,lastLogin,userGroup,title,showRE,reann;
	String errMSG="";
	public User(){
	}
	public void setUserID(int userID){
		this.userID=userID;
	}
	public int getUserID(){
		return this.userID;
	}
	public void setUserName(String userName){
		this.userName=userName;
	}
	public String getUserName(){
		return this.userName;
	}
	public void setUserEmail(String userEmail ){
		this.userEmail=userEmail;
	}
	public String getUserEmail(){
		return this.userEmail;
	}
	public void setArticle(int article ){
		this.article=article;
	}
	public int getArticle(){
		return this.article;
	}
	public void setUserPassword(String userPassword){
		this.userPassword=userPassword;
	}
	public String getUserPassword(){
		return this.userPassword;
	}
	public void setSign(String sign){
		this.sign=sign;
	}
	public String getNoFilterSign(){
		return this.sign;
	}
	public String getSign(){
		return (new MyFilter(StringUtils.replace(StringUtils.convertNewlines(StringUtils.escapeHTMLTags(this.sign))," ","&nbsp;"))).getFilterString();
	}
	public void setSex(String sex){
		this.sex=sex;
	}
	public String getSex(){
		return this.sex;
	}
	public void setHomePage(String homePage){
		this.homePage=homePage;
	}
	public String getHomePage(){
		return this.homePage;
	}
	public void setAddDate(String addDate){
		this.addDate=addDate;
	}
	public String getAddDate(){
		return this.addDate;
	}
	public void setLogins(int logins ){
		this.logins=logins;
	}
	public int getLogins(){
		return this.logins;
	}
	public void setFace(String face){
		this.face=face;
	}
	public String getFace(){
		return this.face;
	}
	public void setWidth(int width){
		this.width=width;
	}
	public int getWidth(){
		return this.width;
	}
	public void setHeight(int height ){
		this.height=height;
	}
	public int getHeight(){
		return this.height;
	}
	public void setOicq(String oicq){
		this.oicq=oicq;
	}
	public String getOicq(){
		return this.oicq;
	}
	public void setLastLogin(String lastLogin){
		this.lastLogin=lastLogin;
	}
	public String getLastLogin(){
		return this.lastLogin;
	}
	public void setBbsType(int bbsType){
		this.bbsType=bbsType;
	}
	public int getBbsType(){
		return this.bbsType;
	}
	public void setLockUser(int lockUser){
		this.lockUser=lockUser;
	}
	public int getLockUser(){
		return this.lockUser;
	}
	public void setUserClass(int userClass){
		this.userClass=userClass;
	}
	public int getUserClass(){
		return this.userClass;
	}
	public void setUserGroup(String userGroup ){
		this.userGroup=userGroup;
	}
	public String getUserGroup(){
		return this.userGroup;
	}
	public void setUserWealth(int userWealth){
		this.userWealth=userWealth;
	}
	public int getUserWealth(){
		return this.userWealth;
	}
	public void setUserEP(int userEP){
		this.userEP=userEP;
	}
	public int getUserEP(){
		return this.userEP;
	}
	public void setUserCP(int userCP){
		this.userCP=userCP;
	}
	public int getUserCP(){
		return this.userCP;
	}
	public void setTitle(String title ){
		this.title=title;
	}
	public String getTitle(){
		return this.title;
	}

	public void setReann(String reann ){
		this.reann=reann;
	}
	public String getReann(){
		return this.reann;
	}

	public User(String userName,String userPassword,int loginSign) throws UserNotFoundException ,Exception
	{

		boolean foundErr=false;
		if("".equals(userName)){
			errMSG=errMSG+"<br>"+"<li>请输入您的用户名。";
			foundErr=true;
		}

		if("".equals(userPassword)){
			errMSG=errMSG+"<br>"+"<li>请输入您的密码。";
			foundErr=true;
		}
		if(foundErr)
			throw new Exception(errMSG);
		this.userName=userName;
		this.userPassword=userPassword;
		if(loginSign>0)
		checkUser(loginSign);
	}
	public void checkUser(int loginSign) throws UserNotFoundException,Exception
	{
		try{
			MD5 md5=new MD5();

			/*
			DBConnect dbc=new DBConnect("select * from bbs.myuser where UserName=? and UserPassword=?");
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(2,(new String(md5.getMD5ofStr(userPassword).getBytes("ISO-8859-1"),"GBK")).getBytes());
			ResultSet rs=dbc.executeQuery();
			*/
			String s1 = new String(userName.getBytes("ISO-8859-1"),"GBK") ;
			String s2 = new String(md5.getMD5ofStr(userPassword).getBytes("ISO-8859-1"),"GBK") ;
			String sql1 = "select * from bbs.myuser where UserName='"+s1.trim()+"' and UserPassword='"+s2.trim()+"'";
			DBConnect dbc=new DBConnect();
			ResultSet rs=dbc.executeQuery(sql1);
//System.out.println(sql1);

			if(rs.next())
			{
				if(loginSign==4){
					//dbc.close();
					this.setUserClass(rs.getInt("userclass"));
					//System.out.println("____________"+this.getUserClass());
					this.setLastLogin(rs.getString("lastlogin"));
					return;
				}
//System.out.println("----------------");
				//use the resultset to define the varible used!
				lastLogin=rs.getString("lastlogin");
				article=rs.getInt("Article");
				userClass=rs.getInt("userclass");
				if (userClass<18){
					if (article<SkinUtil.getPoint(2)) userClass=1;
					for(int i=2;i<17;i++){
						if (article>=SkinUtil.getPoint(i) && article<SkinUtil.getPoint(i+1))
							 userClass=i;
					}
					if (article>=SkinUtil.getPoint(17)) userClass=17;
				}


				String thegetdate=Format.getDateTime();
				//此处对user的各种属性进行了重新定义；
				/*this.setUserID(rs.getInt(
				this.setUserName(rs.getString(13));
				this.setUserEmail(rs.getString(14));
				this.setHomePage(rs.getString(15));
				this.setOicq(rs.getString(16));
				this.setSign(rs.getString(17));
				this.setUserClass(rs.getInt(18));
				this.setTitle(rs.getString(19));
				this.setWidth(rs.getInt(20));
				this.setHeight(rs.getInt(21));
				this.setArticle(rs.getInt(22));
				this.setFace(rs.getString(23));
				this.setAddDate(rs.getString(24));
				this.setUserWealth(rs.getInt(25));
				this.setUserEP(rs.getInt(26));
				this.setUserCP(rs.getInt(27));
				*/
				this.lastLogin=rs.getString("lastlogin");
				//dbc.clearParameters();
				String sql="";
				int wealthLogin=Integer.parseInt(ForumPropertiesManager.getString("wealthLogin"));
				int epLogin=Integer.parseInt(ForumPropertiesManager.getString("epLogin"));
				int cpLogin=Integer.parseInt(ForumPropertiesManager.getString("cpLogin"));
				int wealthAnnounce=Integer.parseInt(ForumPropertiesManager.getString("wealthAnnounce"));
				int wealthReAnnounce=Integer.parseInt(ForumPropertiesManager.getString("wealthReannounce"));

				int epAnnounce=Integer.parseInt(ForumPropertiesManager.getString("epAnnounce"));
				int epReAnnounce=Integer.parseInt(ForumPropertiesManager.getString("epReannounce"));
				int cpAnnounce=Integer.parseInt(ForumPropertiesManager.getString("cpAnnounce"));
				int cpReAnnounce=Integer.parseInt(ForumPropertiesManager.getString("cpReannounce"));
				switch(loginSign){

					case 1:
						sql="update bbs.myuser set userWealth=userWealth+"+wealthLogin+",userEP=userEP+"+epLogin+",userCP=userCP+"+cpLogin+",userClass="+userClass+",lastlogin='"+thegetdate+"',logins=logins+1 where username='"+s1+"'";
						break;
					case 2:
						sql="update bbs.myuser set article=article+1,userWealth=userWealth+"+wealthAnnounce+",userEP=userEP+"+epAnnounce+",userCP=userCP+"+cpAnnounce+",userclass="+userClass+",lastlogin=getdate() where username='"+s1+"'";
						break;
					case 3:
						sql="update bbs.myuser set article=article+1,userWealth=userWealth+"+wealthReAnnounce+",userEP=userEP+"+epReAnnounce+",userCP=userCP+"+cpReAnnounce+",userclass="+userClass+",lastlogin=getdate() where username='"+s1+"'";
						break;

					default:
						sql="update bbs.myuser set userWealth=userWealth+"+wealthLogin+",userEP=userEP+"+epLogin+",userCP=userCP+"+cpLogin+",userClass="+userClass+",lastlogin='"+thegetdate+"',logins=logins+1 where username='"+s1+"'";
						break;
				}

				//dbc.prepareStatement(sql);
				//dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.executeUpdate(sql);
				dbc.close();
			}
			else
			{
				dbc.close();
				throw new UserNotFoundException("<br><li>对不起此用户不存在请检查你的密码与用户名");

			}
		}
		catch(UserNotFoundException ue)
		{
			ue.printStackTrace();
		}
		catch(java.sql.SQLException se)
		{
			se.printStackTrace();
		}
		catch(Exception e)
		{
			throw new Exception("<br><li>数据库操作失败，请与<a href=\"mailto:"+ForumPropertiesManager.getString("SystemEmail")+"\">系统管理员联系</a>");
		}
	}

	public String getUserClassStr(){
		String tempStr="";
		switch(this.getUserClass()){

			case 1:
			 	tempStr="&nbsp;&nbsp;<img src=pic/level0.gif>";
			 	break;
			case 2:
				 tempStr="&nbsp;&nbsp;<img src=pic/level1.gif>";
				break;
			case 3:
				tempStr="&nbsp;&nbsp;<img src=pic/level2.gif>";
				break;
			case 5:
				tempStr="&nbsp;&nbsp;<img src=pic/level3.gif>";
				break;
			case 6:
				tempStr="&nbsp;&nbsp;<img src=pic/level4.gif>";
				break;
			case 7:
				tempStr="&nbsp;&nbsp;<img src=pic/level5.gif>";
				break;
			case 8:
				tempStr="&nbsp;&nbsp;<img src=pic/level6.gif>";
				break;
			case 9:
				tempStr="&nbsp;&nbsp;<img src=pic/level7.gif>";
				break;
			case 10:
				tempStr="&nbsp;&nbsp;<img src=pic/level8.gif>";
				break;
			case 11:
				tempStr="&nbsp;&nbsp;<img src=pic/level9.gif>";
				break;
			case 12:
				tempStr="&nbsp;&nbsp;<img src=pic/level9.gif>";
				break;
			case 13:
				tempStr="&nbsp;&nbsp;<img src=pic/level9.gif>";
				break;
			case 14:
				tempStr="&nbsp;&nbsp;<img src=pic/level9.gif>";
				break;
			case 15:
				tempStr="&nbsp;&nbsp;<img src=pic/level9.gif>";
				break;
			case 16:
				tempStr="&nbsp;&nbsp;<img src=pic/level9.gif>";
				break;
			case 17:
				tempStr="&nbsp;&nbsp;<img src=pic/level9.gif>";
				break;
			case 18:
				tempStr="&nbsp;&nbsp;<img src=pic/level9.gif>";
				break;
			case 19:
				tempStr="&nbsp;&nbsp;<img src=pic/level10.gif>";
				break;
			case 20:
				tempStr="&nbsp;&nbsp;<img src=pic/level10.gif>";
				break;
		}
		return tempStr;

	}

}
