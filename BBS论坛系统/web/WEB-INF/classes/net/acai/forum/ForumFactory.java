package net.acai.forum;
/**
 * Title:        清清网络
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */
import net.acai.forum.*;
import net.acai.database.DBConnect;
import net.acai.util.*;
import java.util.Vector;
import java.sql.ResultSet;
import javax.servlet.http.*;

public class ForumFactory{

	public static Vector getForums(int gateWayID)
	throws ForumNotFoundException{
		try{
			DBConnect dbc=new DBConnect("select * from bbs.board where class=?");

			dbc.setInt(1,gateWayID);
			Vector forumVector=new Vector();
			ResultSet rs=dbc.executeQuery();
			while(rs.next()){
				int forumID=rs.getInt(1);
				Forum theForum=new Forum(forumID);
				forumVector.add(theForum);
			}
			dbc.close();
			return forumVector;
		}
		catch(Exception e){
			throw new ForumNotFoundException("字符出错");
		}
	}
	public static Forum getForum(int forumID) throws ForumNotFoundException{
		try{
			Forum theForum=new Forum(forumID);
			return theForum;
		}
		catch(Exception e){
			e.printStackTrace();
			throw new ForumNotFoundException();
		}
	}
	public static Forum getForum(HttpServletRequest request,HttpServletResponse response,HttpSession session,int forumID) throws ForumNotFoundException{

			Forum theForum=new Forum(request,response,forumID);
			return theForum;

	}


	public static Vector getOLUsers(String sign){
		try{
			DBConnect dbc=new DBConnect("select * from bbs.online order by id");
			Vector forumOLUsers=null;
			forumOLUsers=new Vector();
			ResultSet rs;
			rs=dbc.executeQuery();
			while(rs.next()){
				if(sign.equals("guest")&&rs.getString(2).equals("guest")){
					OLUser tempOLUser=new OLUser();
					tempOLUser.setUserID(rs.getInt(1));
					tempOLUser.setUserName(rs.getString(2));
					tempOLUser.setUserClass(rs.getString(3));
					tempOLUser.setStats(rs.getString(4));
					tempOLUser.setUserIP(rs.getString(5));
					tempOLUser.setStartTime(rs.getString(6));
					tempOLUser.setLastTimeBK(rs.getString(7));
					tempOLUser.setLastTime(rs.getString(8));
					tempOLUser.setBrowser(rs.getString(9));
					tempOLUser.setActForIP(rs.getString(10));
					tempOLUser.setComeFrom(rs.getString(11));
					tempOLUser.setActCome(rs.getString(12));
					forumOLUsers.add(tempOLUser);
				}
				else if(sign.equals("member")&&!rs.getString(2).equals("guest")){
					OLUser tempOLUser=new OLUser();
					tempOLUser.setUserID(rs.getInt(1));
					tempOLUser.setUserName(rs.getString(2));
					tempOLUser.setUserClass(rs.getString(3));
					tempOLUser.setStats(rs.getString(4));
					tempOLUser.setUserIP(rs.getString(5));
					tempOLUser.setStartTime(rs.getString(6));
					tempOLUser.setLastTimeBK(rs.getString(7));
					tempOLUser.setLastTime(rs.getString(8));
					tempOLUser.setBrowser(rs.getString(9));
					tempOLUser.setActForIP(rs.getString(10));
					tempOLUser.setComeFrom(rs.getString(11));
					tempOLUser.setActCome(rs.getString(12));
					forumOLUsers.add(tempOLUser);
				}
				else if(sign.equals("total")){
					OLUser tempOLUser=new OLUser();
					tempOLUser.setUserID(rs.getInt(1));
					tempOLUser.setUserName(rs.getString(2));
					tempOLUser.setUserClass(rs.getString(3));
					tempOLUser.setStats(rs.getString(4));
					tempOLUser.setUserIP(rs.getString(5));
					tempOLUser.setStartTime(rs.getString(6));
					tempOLUser.setLastTimeBK(rs.getString(7));
					tempOLUser.setLastTime(rs.getString(8));
					tempOLUser.setBrowser(rs.getString(9));
					tempOLUser.setActForIP(rs.getString(10));
					tempOLUser.setComeFrom(rs.getString(11));
					tempOLUser.setActCome(rs.getString(12));
					forumOLUsers.add(tempOLUser);

				}

			}

			dbc.close();
			return forumOLUsers;
		}
		catch(Exception e){
			e.printStackTrace();
			return null;
			//throw new ForumNotFoundException("字符出错");
		}
	}

	public static Vector getOLGuestUsers(){
		return getOLUsers("guest");
	}
	public static int getOLGuestUsersNum(){
		return getOLGuestUsers().size();
	}
	public static Vector getOLMemberUsers(){
		return getOLUsers("member");
	}
	public static int getOLMemberUsersNum(){
		return getOLMemberUsers().size();
	}

	public static int getOLUsersNum(){
		return getOLUsers("total").size();
	}
	public static void addUser(HttpServletRequest request,int wealthReg,int epReg,int cpReg) throws Exception{
		String userName=ParamUtil.getString(request,"userName","");

		String psw=ParamUtil.getString(request,"psw","");
		String userPassword="";
		String pswc=ParamUtil.getString(request,"pswc","");
		String userEmail=ParamUtil.getString(request,"userEmail","");
		String face=ParamUtil.getString(request,"face","");
		int width=ParamUtil.getInt(request,"width",0);
		int height=ParamUtil.getInt(request,"height",0);
		String oicq=ParamUtil.getString(request,"oicq");
		String sign=ParamUtil.getString(request,"sign","");
		String myFace=ParamUtil.getString(request,"myface","");
		boolean foundErr=false;
		String errMSG="";
		int sex=0;
		int showRe=0;
		if("".equals(userName)||userName.length()>20)
		{
			errMSG=errMSG+"<br>"+"<li>请输入您的用户名(长度不能大于20)。";
			foundErr=true;
		}
		if (userName.indexOf('=')>-1||userName.indexOf('%')>-1||userName.indexOf('?')>-1||userName.indexOf('&')>-1 || userName.indexOf(';')>-1 ||userName.indexOf(',')>0 || userName.indexOf('\'')>-1 || userName.indexOf('+') >-1){
			errMSG=errMSG+"<br>"+"<li>用户名中含有非法字符。";
			foundErr=true;
		}
		try{
			sex=ParamUtil.getInt(request,"sex");
		}
		catch(NumberFormatException e)
		{
			errMSG=errMSG+"<br>"+"<li>请选择您的性别。";
			foundErr=true;
		}
		try{
			showRe=ParamUtil.getInt(request,"showRe");
		}
		catch(NumberFormatException e){
			errMSG=errMSG+"<br>"+"<li>请选择您的帖子有回复时是否要提示您。";
			foundErr=true;
		}
		if("".equals(psw) || psw.length()>10){
			errMSG=errMSG+"<br>"+"<li>请输入您的密码(长度不能大于10)。";
			foundErr=true;
		}
		if (!pswc.equals(psw)){
			errMSG=errMSG+"<br>"+"<li>您输入的密码和确认密码不一致。";
			foundErr=true;
		}
		else
			userPassword=psw;

		if (userEmail.indexOf('@')<0||userEmail.indexOf('.')<0){
			errMSG=errMSG+"<br>"+"<li>您的Email有错误。";
   			foundErr=true;
   		}
   		if (!"".equals(myFace)){
   			if (width==0 || height==0){
				errMSG=errMSG+"<br>"+"<li>请输入图片的宽度和高度。";
				foundErr=true;
			}
			else if (width<20|| width>80){
				errMSG=errMSG+"<br>"+"<li>您输入的图片宽度不符合标准。";
				foundErr=true;
			}
			else if (height<20 || height>80){
				errMSG=errMSG+"<br>"+"<li>您输入的图片高度不符合标准。";
				foundErr=true;
			}
			else face=myFace;

		}
		else
			if ("".equals(face)){
				errMSG=errMSG+"<br>"+"<li>请选择您的个性头像。";
				foundErr=true;
			}
			else if (face.endsWith(".gif")){
				width=32;
				height=32;
			}
			else{

				errMSG=errMSG+"<br>"+"<li>您选择了错误的头像。";
				foundErr=true;
			}
		if(oicq==null)
			oicq="";
		else
			try{
				Integer.parseInt(oicq);
			}
			catch(NumberFormatException e)
			{

				errMSG=errMSG+"<br>"+"<li>Oicq号码只能是4-10位数字，您可以选择不输入。";
				foundErr=true;
			}

		if(!foundErr)
		{
			try{
				DBConnect dbc=new DBConnect("select * from bbs.myuser where username=?");
				dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());

				ResultSet rs=dbc.executeQuery();
				if(rs.next()){
					dbc.close();
					throw new UserAlreadyExistException();
				}
				MD5 md5=new MD5();
				dbc.clearParameters();
				dbc.prepareStatement("insert into bbs.myuser ( userName,userPassword,userEmail,userClass,sign,oicq,article,lockuser,sex,showRe,addDate,face,width,height,logins,lastlogin,userWealth,userEP,userCP) values( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.setBytes(2,(new String(md5.getMD5ofStr(userPassword).getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.setBytes(3,(new String(userEmail.getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.setInt(4,1);
				dbc.setBytes(5,(new String(sign.getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.setBytes(6,(new String(oicq.getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.setInt(7,0);
				dbc.setInt(8,0);
				dbc.setInt(9,sex);
				dbc.setInt(10,showRe);
				dbc.setString(11,Format.getDateTime());
				dbc.setBytes(12,(new String(face.getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.setInt(13,width);
				dbc.setInt(14,height);
				dbc.setInt(15,1);
				dbc.setString(16,Format.getDateTime());
				dbc.setInt(17,wealthReg);
				dbc.setInt(18,epReg);
				dbc.setInt(19,cpReg);
				dbc.executeUpdate();

				dbc.clearParameters();
				dbc.prepareStatement("update bbs.config set usernum=usernum+1,lastUser=?");
				dbc.setBytes(1,userName.getBytes());
				dbc.executeUpdate();

				String forumName=ForumPropertiesManager.getString("ForumName");
				String sender=forumName;
				String title=forumName+"欢迎您的到来";
				String body=forumName+"全体管理人员欢迎您的到来\n如有任何疑问请及时联系系统管理员。\n如有任何使用上的问题请查看论坛帮助。\n感谢您注册本系统，让我们一起来建设这个网上家园！";
				String sql="insert into bbs.message(incept,sender,title,content,sendtime,flag,issend) values(?,?,?,?,getdate(),0,1)";
				dbc.prepareStatement(sql);
				dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.setBytes(2,(new String(sender.getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.setBytes(3,(new String(title.getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.setBytes(4,(new String(body.getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.executeUpdate();
				dbc.close();
				ForumPropertiesManager.resetManager();
			}
			catch(UserAlreadyExistException e){
				errMSG=errMSG+"<br>"+"<li>对不起，您输入的用户名已经被注册，请重新输入。";
				throw new Exception(errMSG);
			}
			catch(Exception e){
				e.printStackTrace();
				throw e;
			}

		}
		if(foundErr)
			throw new Exception(errMSG);
	}




}
