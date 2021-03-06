package net.acai.forum;
/**
 * Title:        ????????
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */
import net.acai.forum.*;
import net.acai.database.*;
import javax.servlet.http.*;
import java.sql.*;
import net.acai.util.*;
import java.util.Vector;
import net.acai.database.*;

public class FriendsManager
{
	String userName;
	String sql;
	public FriendsManager(HttpServletRequest request){
		userName=GCookie.getCookieValue(request,"UJBBUName","");

	}
	public static Vector getFriendList(HttpServletRequest request) throws Exception{
		String userName=GCookie.getCookieValue(request,"UJBBUName","");
		String sql="select F_friend from bbs.Friend where F_username=? order by F_addtime desc";
		DBConnect dbc=new DBConnect();
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		ResultSet rs=dbc.executeQuery();
		Vector friendList=new Vector();
		while(rs.next()){
			Friend friend=new Friend();
			friend.setFriendFriend(rs.getString(1));

			friendList.add(friend);
		}
		dbc.close();
		return friendList;

	}

	public Vector getFriendInfo(HttpServletRequest request) throws Exception{
		sql="select F.*,U.useremail,U.homepage,U.oicq from bbs.Friend F inner join bbs.myuser U on F.F_Friend=U.username where F.F_username=? order by F.f_addtime desc";

		DBConnect dbc=new DBConnect();
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		ResultSet rs=dbc.executeQuery();
		Vector friendInfo=new Vector();
		while(rs.next()){

			Friend friend=new Friend();
			friend.setFriendID(rs.getInt(1));
			friend.setFriendUserName(rs.getString(2));
			friend.setFriendFriend(rs.getString(3));
			friend.setFriendAddTime(rs.getString(4));
			friend.setFriendEmail(rs.getString(5));
			friend.setFriendHomePage(rs.getString(6));
			friend.setFriendOicq(rs.getString(7));

			friendInfo.add(friend);
		}

		dbc.close();
		return friendInfo;
	}
	public void delFriend(HttpServletRequest request) throws Exception{
		int ID=0;
		try{
			ID=ParamUtil.getInt(request,"id");
		}
		catch(Exception e){
			throw new Exception("??ָ?????ز?????");
		}
		String userName=GCookie.getCookieValue(request,"UJBBUName","");

		DBConnect dbc=new DBConnect();
		sql="delete from bbs.Friend where F_username=? and F_id="+ID;
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}
	public void allDelFriend() throws Exception{

		DBConnect dbc=new DBConnect();
		sql="delete from bbs.Friend where F_username=? ";
		dbc.prepareStatement(sql);
		dbc.executeUpdate();
		dbc.close();
	}
	public void saveFriend(HttpServletRequest request) throws Exception{
		String touser=ParamUtil.getString(request,"touser");
		if(touser==null||"".equals(touser.trim()))
			throw new Exception("????????д???Ͷ????˰ɡ?");
		String userName=GCookie.getCookieValue(request,"UJBBUName","");
		touser=touser.trim();
		String [] incept=touser.split(",");
		DBConnect dbc=new DBConnect();
		ResultSet rs;
		for(int i=0;i<incept.length;i++){
			if(i>4){
				dbc.close();
				throw new Exception("ÿ??????ֻ??????5λ?û???????????5λ?Ժ???????????д");
			}
			sql="select username from bbs.myuser where username=?";
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(incept[i].getBytes("ISO-8859-1"),"GBK")).getBytes());
			rs=dbc.executeQuery();
			if(!rs.next()){
				dbc.close();
				throw new Exception("??̳û???????û???????δ?ɹ???");
			}
			rs.close();
			sql="select F_friend from bbs.friend where F_username=? and  F_friend=?";
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(2,(new String(incept[i].getBytes("ISO-8859-1"),"GBK")).getBytes());
			rs=dbc.executeQuery();
			if(!rs.next()){
				sql="insert into bbs.friend (F_username,F_friend,F_addtime) values (?,?,getdate())";
				dbc.prepareStatement(sql);
				dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.setBytes(2,(new String(incept[i].getBytes("ISO-8859-1"),"GBK")).getBytes());
				dbc.executeUpdate();
			}
			rs.close();
		}
		dbc.close();
	}
}