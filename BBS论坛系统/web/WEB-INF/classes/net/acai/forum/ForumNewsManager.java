package net.acai.forum;
/**
 * Title:        ????????
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */


import net.acai.forum.ForumNewsNotFoundException;
import net.acai.database.*;
import java.util.Vector;
import java.sql.*;
public class ForumNewsManager{
	
	public static ForumNews getForumNews(int forumID)
	throws ForumNewsNotFoundException{
		try{
			ForumNews temp=new ForumNews(forumID);
			return temp;
		}
		catch(Exception e)
		{
			throw new ForumNewsNotFoundException();
		}
		
		
	}
	public static ForumNews getSignalForumNews(int newsID) throws Exception{
	
		
		DBConnect dbc=new DBConnect("select * from bbs.bbsnews where id="+newsID);
		ResultSet rs=dbc.executeQuery();
		rs.next();
		ForumNews forumNews=new ForumNews();
			
		forumNews.setId(rs.getInt(1));
		forumNews.setBoardid(rs.getInt(2));
		forumNews.setTitle(rs.getString(3));
		forumNews.setContent(rs.getString(4));
		forumNews.setUserName(rs.getString(5));
		forumNews.setAddTime(rs.getString(6));

		return forumNews;
	}
	public static Vector getForumNewsVector() throws Exception{
		DBConnect dbc=new DBConnect("select * from bbs.bbsnews  order by id desc");
		ResultSet rs=dbc.executeQuery();
		Vector forumNewsVector=new Vector();
		while(rs.next()){
			ForumNews forumNews=new ForumNews();
			
			forumNews.setId(rs.getInt(1));
			forumNews.setBoardid(rs.getInt(2));
			forumNews.setTitle(rs.getString(3));
			forumNews.setContent(rs.getString(4));
			forumNews.setUserName(rs.getString(5));
			forumNews.setAddTime(rs.getString(6));
			
			
			forumNewsVector.add(forumNews);
			
		}
		dbc.close();
		return forumNewsVector;
	}
	public static Vector getForumNewsVector(int forumID) throws Exception{
		DBConnect dbc=new DBConnect("select * from bbs.bbsnews where boardID="+forumID+" order by id desc");
		ResultSet rs=dbc.executeQuery();
		Vector forumNewsVector=new Vector();
		while(rs.next()){
			ForumNews forumNews=new ForumNews();
			
			forumNews.setId(rs.getInt(1));
			forumNews.setBoardid(rs.getInt(2));
			forumNews.setTitle(rs.getString(3));
			forumNews.setContent(rs.getString(4));
			forumNews.setUserName(rs.getString(5));
			forumNews.setAddTime(rs.getString(6));
			
			
			forumNewsVector.add(forumNews);
			
		}
		dbc.close();
		return forumNewsVector;
	}

}

		
		
	