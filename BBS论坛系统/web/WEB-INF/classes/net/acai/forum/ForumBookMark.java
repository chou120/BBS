package net.acai.forum;
/**
 * Title:        清清网络
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.qingqing.com
 * @author:       qingqing
 * @version 1.0
 */
import net.acai.forum.*;
import net.acai.database.*;
import javax.servlet.http.*;
import java.sql.*;
import net.acai.util.*;
import java.util.Vector;
import net.acai.database.*;

public class ForumBookMark
{
	public ForumBookMark(){
	}
	public  static void addFav(HttpServletRequest request) throws Exception{
		int forumID;
		try{
			forumID=ParamUtil.getInt(request,"forumID");
		}
		catch(Exception e){
			throw new Exception("请指定论坛版面。");
		}
		int announceID;
		try{
			announceID=ParamUtil.getInt(request,"announceID");
		}
		catch(Exception e){
			throw new Exception("请指定相关贴子或者是非法的贴子参数。");
		}

		int rootID;
		try{
			rootID=ParamUtil.getInt(request,"rootID");
		}
		catch(Exception e){
			throw new Exception("请指定相关贴子或者是非法的贴子参数。");
		}

		////////////////////////////////////
		String url="dispbbs.jsp?forumID="+forumID+"&rootID="+rootID+"&announceID="+announceID;
		DBConnect dbc=new DBConnect();
		String sql="select topic,rootid,announceid,boardid from bbs.bbs1 where announceid="+announceID+" and rootid="+rootID+" and boardid="+forumID;
		ResultSet rs=dbc.executeQuery(sql);
		if(!rs.next()){
			dbc.close();
			throw new Exception("没有相关贴子。");
		}
		//rs.next();
		String topic=rs.getString(1);
		rs.close();

		String userName=GCookie.getCookieValue(request,"UJBBUName","");

		sql="insert into bbs.bookmark(username,topic,url,addtime) values(?,?,'"+url+"',getdate())";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String(topic.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();

	}
	public static Vector getBookMarkList(HttpServletRequest request) throws Exception{
		String userName=GCookie.getCookieValue(request,"UJBBUName","");
		String sql="select * from bbs.bookmark where username=? order by id desc";
		DBConnect dbc=new DBConnect();
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		ResultSet rs=dbc.executeQuery();
		Vector bookMarkList=new Vector();
		while(rs.next()){
			BookMark bookMark=new BookMark();
			bookMark.setID(rs.getInt(1));
			bookMark.setUserName(rs.getString(2));
			bookMark.setURL(rs.getString(3));
			bookMark.setTopic(rs.getString(4));
			bookMark.setAddTime(rs.getString(5));
			bookMarkList.add(bookMark);
		}
		dbc.close();
		return bookMarkList;

	}
	public static void delBookMark(HttpServletRequest request) throws Exception{
		int ID;
		String userName=GCookie.getCookieValue(request,"UJBBUName","");

		try{
			ID=ParamUtil.getInt(request,"id");
		}
		catch(Exception e){
			throw new Exception("请指定相应的参数！");
		}
		String 		sql="delete from bbs.bookmark where username=? and id="+ID;
		DBConnect dbc=new DBConnect(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}

}