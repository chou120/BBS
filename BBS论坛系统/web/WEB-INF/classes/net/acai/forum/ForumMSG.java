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
import net.acai.filter.*;
import net.acai.util.*;
import net.acai.database.*;

import java.sql.*;

public class ForumMSG{

	private int announceID,parentID,childNum,forumID;
	private String userName,userEmail,dateAndTime;
	public String topic,body="";
	private int hits,length,rootID,layer,orders,isBest;
	private String userIP,expression;
	private int times, lockTopic,signFlag,emailFlag,isTop,isVote;
	private User msgUser;
	public ForumMSG()
	{
		
	}
	public ForumMSG(int announceID){
		try{
			DBConnect dbc=new DBConnect("select * from bbs.bbs1 where announceID=?");
			dbc.setInt(1,announceID);
			ResultSet rs=dbc.executeQuery();
			rs.next();
			this.setAnnounceID(rs.getInt(1));
			this.setParentID(rs.getInt(2));
			this.setChildNum(rs.getInt(3));
			this.setForumID(rs.getInt(4));
			this.setUserName(rs.getString(5));
			this.setUserEmail(rs.getString(6));
			this.setTopic(rs.getString(7));
			this.setBody(rs.getString(8));
			this.setDateAndTime(rs.getString(9));
			this.setHits(rs.getInt(10));
			this.setLength(rs.getInt(11));
			this.setRootID(rs.getInt(12));
			this.setLayer(rs.getInt(13));
			this.setOrders(rs.getInt(14));
			this.setIsBest(rs.getInt(15));
			this.setUserIP(rs.getString(16));
			this.setExpression(rs.getString(17));
			this.setTimes(rs.getInt(18));
			this.setLockTopic(rs.getInt(19));
			this.setSignFlag(rs.getInt(20));
			this.setEmailFlag(rs.getInt(21));
			this.setIsTop(rs.getInt(22));
			this.setIsVote(rs.getInt(23));
			dbc.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	public void setUser(User msgUser){
		this.msgUser=msgUser;
	}
	public User getUser(){
		return msgUser;
	}
	
	public void setAnnounceID(int announceID){
		this.announceID=announceID;
	}
	public int getAnnounceID(){
		return this.announceID;
	}
	public void setParentID(int parentID){
		this.parentID=parentID;
	}
	public int getParentID(){
		return this.parentID;
	}
	public void setChildNum(int childNum){
		this.childNum=childNum;
	}
	public int getChildNum(){
		return this.childNum;
	}
	public void setForumID(int forumID){
		this.forumID=forumID;
	}
	public int getForumID(){
		return this.forumID;
	}
	public void setUserName(String userName){
		this.userName=userName;
	}
	public String getUserName(){
		return this.userName;
	}
	public void setUserEmail(String userEmail){
		this.userEmail=userEmail;
	}
	public String getUserEmail(){
		return this.userEmail;
	}
	public void setTopic(String topic){
		this.topic=topic;
	}
	public String getNoFilterTopic(){
		return this.topic;
	}
	public String getTopic(){
		return (new MyFilter(StringUtils.replace(StringUtils.convertNewlines(StringUtils.escapeHTMLTags(this.topic))," ","&nbsp;"))).getFilterString();
	}
	public void setBody(String body){
		this.body=body;
	}
	public String getNoFilterBody(){
		return this.body;
	}
	public String getBody(){
		return (new MyFilter(StringUtils.replace(StringUtils.convertNewlines(StringUtils.escapeHTMLTags(this.body))," ","&nbsp;"))).getFilterString();
	}
	public void setDateAndTime(String dateAndTime){
		this.dateAndTime=dateAndTime;
	}
	public String getDateAndTime(){
		return this.dateAndTime;
	}
	public void setHits(int hits){
		this.hits=hits;
	}
	public int getHits(){
		return this.hits;
	}
	public void setLength(int length){
		this.length=length;
	}
	public int getLength(){
		return this.length;
	}
	public void setRootID(int rootID){
		this.rootID=rootID;
	}
	public int getRootID(){
		return rootID;
	}
	public void setLayer(int layer){
		this.layer=layer;
	}
	
	public int getLayer(){
		return this.layer;
	}
	public void setOrders(int orders){
		this.orders=orders;
	}
	public int getOrders(){
		return this.orders;
	}
	public void setIsBest(int isBest){
		this.isBest=isBest;
	}
	public boolean getIsBest(){
		if(isBest==1)
			return true;
		else
			return false;
	}
	public void setUserIP(String userIP){
		this.userIP=userIP;
	}
	public String getUserIP(){
		return this.userIP;
	}
	public void setExpression(String expression){
		this.expression=expression;
	}
	public String getExpression(){
		return this.expression;
	}
	public void setTimes(int times){
		this.times=times;
	}
	public int getTimes(){
		return this.times;
	}
	public void setLockTopic(int lockTopic){
		this.lockTopic=lockTopic;
	}
	public boolean getLockTopic(){
		if(lockTopic>=1)
			return true;
		else
			return false;
	}
	public void setSignFlag(int signFlag){
		this.signFlag=signFlag;
	}
	public boolean getSignFlag(){
		if(signFlag==1)
			return true;
		else
			return false;
	}
	public void setEmailFlag(int emailFlag){
		this.emailFlag=emailFlag;
	}
	public boolean getEmailFlag(){
		if(emailFlag==1)
			return true;
		else
			return false;
	}
	public void setIsTop(int isTop){
		this.isTop=isTop;
	}
	public boolean getIsTop(){
		if(isTop==1)
			return true;
		else
			return false;
	}
	public void setIsVote(int isVote){
		this.isVote=isVote;
	}
	public boolean getIsVote(){
		if(isVote==1)
			return true;
		else
			return false;
	}
}	
	
	