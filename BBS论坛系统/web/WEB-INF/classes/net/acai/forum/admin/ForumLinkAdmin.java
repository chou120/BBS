package net.acai.forum.admin;
/**
 * Title:        清清网络
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
public class ForumLinkAdmin{


	public ForumLinkAdmin(){}

	public static void saveNew(HttpServletRequest request) throws Exception{
		String url=ParamUtil.getString(request,"url");
		String readme=ParamUtil.getString(request,"readme");
		String name=ParamUtil.getString(request,"name");

		if(url==null||readme==null||name==null)
			throw new Exception("请输入完整联盟论坛信息。");
		DBConnect dbc=new DBConnect("insert into bbs.bbslink(boardname,readme,url) values(?,?,?)");

		dbc.setBytes(1,(new String(name.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String(readme.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(3,(new String(url.getBytes("ISO-8859-1"),"GBK")).getBytes());

		dbc.executeUpdate();
		dbc.close();
	}
	public static void saveEdit(HttpServletRequest request) throws Exception{
		int forumLinkID;
		try{
			forumLinkID=ParamUtil.getInt(request,"id");
		}
		catch(Exception e){
			throw new Exception("请您选择论坛的ID.");
		}

		DBConnect dbc=new DBConnect("update bbs.bbslink set boardname=?,readme=?,url=? where id="+forumLinkID);

		dbc.setBytes(1,(new String(ParamUtil.getString(request,"name","").getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String(ParamUtil.getString(request,"readme","").getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(3,(new String(ParamUtil.getString(request,"url","").getBytes("ISO-8859-1"),"GBK")).getBytes());

		dbc.executeUpdate();

		dbc.close();
	}
	public static void del(HttpServletRequest request) throws Exception{
		int forumLinkID;
		try{
			forumLinkID=ParamUtil.getInt(request,"id");
		}
		catch(Exception e){
			throw new Exception("请您选择论坛的ID.");
		}
		DBConnect dbc=new DBConnect("delete from bbs.bbslink where id="+forumLinkID);
		dbc.executeUpdate();
		dbc.close();
	}
	public static void updateOrders(HttpServletRequest request) throws Exception{
		int newforumLinkID;
		int forumLinkID;
		try{
			newforumLinkID=ParamUtil.getInt(request,"newid");
			forumLinkID=ParamUtil.getInt(request,"id");
		}
		catch(Exception e){
			throw new Exception("请您选择论坛的ID.");
		}
		DBConnect dbc=new DBConnect("update bbs.bbslink set id="+newforumLinkID+" where id="+forumLinkID);
		dbc.executeUpdate();
		dbc.close();
	}

}