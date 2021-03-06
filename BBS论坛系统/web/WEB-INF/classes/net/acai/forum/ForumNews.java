package net.acai.forum;
/**
 * Title:        ????????
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */
import net.acai.database.*;
import java.sql.ResultSet;
import net.acai.forum.ForumNewsNotFoundException;


public class ForumNews
{
	private int id,boardid;
	private String title,content,username,addtime;
	public ForumNews(){}
	public ForumNews(int boardid) throws ForumNewsNotFoundException,Exception{
		
		DBConnect dbc=new DBConnect("select * from bbs.bbsnews where boardid=? order by id desc");
		dbc.setInt(1,boardid);
		ResultSet rs=dbc.executeQuery();
		if(rs.next()){
			this.id=rs.getInt(1);
			this.boardid=boardid;
			this.title=rs.getString(3);
			this.content=rs.getString(4);
			this.username=rs.getString(5);
			this.addtime=rs.getString(6);
			dbc.close();
		}
		else {
			dbc.close();
			throw new ForumNewsNotFoundException(); 
		}
	}
	
	public int getId(){
		return this.id;
	}
	public void setId(int id){
		this.id=id;
	}

	public int getBoardid(){
		return this.boardid;
	}
	public void setBoardid(int boardid){
		this.boardid=boardid;
	}
	public String getTitle(){
		return this.title;
	}
	public void setTitle(String title){
		this.title=title;
	}
	public String getContent(){
		return this.content;
	}
	public void setContent(String content){
		this.content=content;
	}
	public String getUserName(){
		return this.username;
	}
	public void setUserName(String username){
		this.username=username;
	}
	public String getAddTime(){
		return this.addtime;
	}
	public void setAddTime(String addtime){
		this.addtime=addtime;
	}
}

	