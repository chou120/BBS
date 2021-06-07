package net.acai.forum;
/**
 * Title:        ÇåÇåÍøÂç
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */
import net.acai.forum.*;
import net.acai.database.DBConnect;
import java.sql.ResultSet;
import net.acai.util.*;
import net.acai.filter.*;
public class ForumTopic extends ForumMSG{

	String followMSG="-----",followUser="-------",followDateAndTime="-------";
	public ForumTopic(){
	}
	public ForumTopic(int forumRootID){
		super();
		try{
			String sql="select  username,dateandtime,topic,body from bbs.bbs1 where rootid=? and announceid!=? order by announceid desc";
			
			DBConnect dbc=new DBConnect(sql);
			dbc.setInt(1,forumRootID);
			dbc.setInt(2,forumRootID);
			ResultSet rs=dbc.executeQuery();
			if(rs.next()){
				followUser=rs.getString(1);
				followDateAndTime=rs.getString(2);
				String followTopic=rs.getString(3);
				if(followTopic!=null&&!"".equals(followTopic.trim()))
					followMSG=StringUtils.escapeHTMLTags(followTopic);
				else{
					if(rs.getString(4).length()>24)
						followMSG=StringUtils.escapeHTMLTags(rs.getString(4).substring(0,24).replaceAll("\\r|\\n","").replaceAll(" ","&nbsp;"));
					else
						followMSG=StringUtils.escapeHTMLTags(rs.getString(4).replaceAll("\\r|\\n","").replaceAll(" ","&nbsp;"));
				}
			}
			dbc.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
	}
	public String getNoFilterTopic(){
		
		if(topic!=null&&!"".equals(topic.trim()))
			return StringUtils.replace(StringUtils.replace(StringUtils.convertNewlines(StringUtils.escapeHTMLTags(topic))," ","&nbsp;"),"<BR>","");
		else{
			
			String tempString="";
			if(body.length()>24)
				tempString=body.substring(0,24);
			else
				tempString=body;
			
			
			return StringUtils.replace(StringUtils.replace(StringUtils.escapeHTMLTags(tempString).replaceAll("\\r|\\n","&nbsp;")," ","&nbsp;"),"<BR>","");

			
		}
		
			
	}
	public String getTopic(){
		
		if(topic!=null&&!("".equals(topic.trim())))
			return (new MyFilter(StringUtils.replace(StringUtils.convertNewlines(StringUtils.escapeHTMLTags(topic))," ","&nbsp;"))).getFilterString();
		else{
			if(body.length()>24)
				return (new MyFilter(StringUtils.replace(StringUtils.convertNewlines(StringUtils.escapeHTMLTags(body.substring(0,24)))," ","&nbsp;"))).getFilterString();
			else
				return (new MyFilter(StringUtils.replace(StringUtils.convertNewlines(StringUtils.escapeHTMLTags(body))," ","&nbsp;"))).getFilterString();
			
		}
			
	}
	public String getFollowMSG(){
		
		return followMSG;
	}
	public String getFollowUser(){
		return followUser;
	}
	public String getFollowDateAndTime(){
		return followDateAndTime;
	}
	
	
}
