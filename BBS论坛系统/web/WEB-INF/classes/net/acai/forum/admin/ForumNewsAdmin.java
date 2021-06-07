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
public class ForumNewsAdmin
{
	int forumID;
	String userName,sql;

	User theUser;
	public ForumNewsAdmin(HttpServletRequest request,HttpServletResponse response) throws Exception{
		userName=GCookie.getCookieValue(request,"UJBBUName","");
		theUser=SkinUtil.checkUser(request,response,4);
		checkAdmin(request,response);
		adminNews(request,response);
	}

	public void checkAdmin(HttpServletRequest request,HttpServletResponse response) throws Exception{


		forumID=ParamUtil.getInt(request,"forumID");

		if(forumID==0){
			if(theUser.getUserClass()<20)
			throw new Exception("请指定论坛版面");
		}
		else{
		Forum theForum=new Forum(forumID);
		if((theForum==null||theForum.getForumMaster().indexOf(userName)<0)&&theUser.getUserClass()<20)
			throw new Exception("您不是该版面斑竹或者系统管理员。");
		}
	}
	public void adminNews(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String action=ParamUtil.getString(request,"action");
		if(action==null||"".equals(action))
			return;

		if(action.equals("new"))
			saveNews(request);
		else if(action.equals("update"))
			updateNews(request);
		else if(action.equals("del"))
			delNews(request);
		else if(action.equals("saveditbm"))
			saveForumMaster(request);
		else if(action.equals("savebmset"))
			saveForumInfo(request);
		else if(action.equals("savebmcolor"))
			saveForumColor(request);



	}
	public void  saveNews(HttpServletRequest request) throws Exception{

		String title=ParamUtil.getString(request,"title");
		if(title==null||"".equals(title.trim()))
			throw new Exception("请输入新闻标题。");
		String content=ParamUtil.getString(request,"content");
		if(content==null||"".equals(content.trim()))
			throw new Exception("请输入新闻内容。");

		sql="insert into bbs.bbsnews(userName,title,content,addtime,boardID) values(?,?,?,getdate(),"+forumID+")";
		DBConnect dbc=new DBConnect();
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String(title.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(3,(new String(content.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}

	public void updateNews(HttpServletRequest request) throws Exception{
		String title=ParamUtil.getString(request,"title");
		if(title==null||"".equals(title.trim()))
			throw new Exception("请输入新闻标题。");
		String content=ParamUtil.getString(request,"content");
		if(content==null||"".equals(content.trim()))
			throw new Exception("请输入新闻内容。");
		int newsID=ParamUtil.getInt(request,"newsID");

		sql="update bbs.bbsnews set username=?,title=?,content=?,addtime=getdate(),boardID="+forumID+" where ID="+newsID;
		DBConnect dbc=new DBConnect();
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String(title.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(3,(new String(content.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}


	public void delNews(HttpServletRequest request) throws Exception{
		int newsID=ParamUtil.getInt(request,"newsID");
		sql="delete from bbs.bbsnews where ID="+newsID;
		DBConnect dbc=new DBConnect();
		dbc.prepareStatement(sql);
		dbc.executeUpdate();
		dbc.close();
	}
	public void saveForumMaster(HttpServletRequest request) throws Exception{
		String boardmaster=ParamUtil.getString(request,"boardmaster","");
		String readme=ParamUtil.getString(request,"readme","");
		sql = "update bbs.board set boardmaster=?,readme=? where boardID="+forumID;

		DBConnect dbc=new DBConnect();
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(boardmaster.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String(readme.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}
	public void saveForumInfo(HttpServletRequest request) throws Exception{
/*
Forum_Setting=TimeAdjust & "," & ScriptTimeOut & "," & EmailFlag & "," & request("Uploadpic") & "," & request("IpFlag") & "," & request("FromFlag") & "," & TitleFlag & "," & uploadFlag & "," & kicktime & "," & request("guestlogin") & "," & openmsg & "," & request("MaxAnnouncePerPage") & "," & request("Maxtitlelist") & "," & request("AnnounceMaxBytes") & "," & request("online_u") & "," & request("online_g") & "," & LinkFlag & "," & request("TopicFlag") & "," & request("VoteFlag") & "," & request("ReflashFlag") & "," & request("ReflashTime") & "," & ForumStop & "," & RegTime & "," & EmailReg & "," & EmailRegOne & "," & RegFlag & "," & online_n & "," & ViewUser_g & "," & ViewUser_u & "," & BirthFlag & "," & request("runtime") & "," & FastLogin & "," & GroupFlag & "," & request("uploadsize") & "," & request("strAllowForumCode") & "," & request("strAllowHTML") & "," & request("strIMGInPosts") & "," & request("strIcons") & "," & request("strflash") & "," & request("vote_num") & "," & facenum & "," & imgnum & "," & request("relaypost") & "," & request("relayposttime") & "," & facename & "," & imgname & "," & smsflag & "," & SendRegEmail & "," & request("Search_G") & "," & bmFlag_1 & "," & bmFlag_2 & "," & bmFlag_3 & "," & bmFlag_4 & "," & bmFlag_5 & "," & RegFaceNum & "," & request("viewcolor")
'response.write forum_setting
'response.end
sql="update board set Forum_Setting='"&Forum_Setting&"',Forum_upload='"&request("Forum_upload")&"' where forumID="&request("forumID")
conn.execute(sql)
response.write "设置成功。"*/
	}

	public void saveForumColor(HttpServletRequest request) throws Exception{
/*
Forum_body=request("tableBackColor") & "," & request("aTablebackcolor") & "," & request("tableTitleColor") & "," & request("aTableTitleColor") & "," & request("tableBodyColor") & "," & request("aTablebodycolor") & "," & request("tableFontColor") & "," & request("tableContentColor") & "," & request("AlertFontColor") & "," & request("ContentTitle") & "," & request("AlertFontColor") & "," & request("ForumBody") & "," & request("tableWidth") & "," & request("bodyFontColor") & "," & request("BoardLinkColor") & "," & request("user_fc") & "," & request("user_mc") & "," & request("bmaster_fc") & "," & request("bmaster_mc") & "," & request("master_fc") & "," & request("master_mc") & "," & request("vip_fc") & "," & request("vip_mc")
'response.write Forum_body
'response.end
sql = "update board set Forum_body='"&Forum_body&"' where forumID="&request("forumID")
conn.execute(sql)
response.write "设置成功！"*/
}

}