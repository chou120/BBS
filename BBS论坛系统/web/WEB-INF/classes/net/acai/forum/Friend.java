package net.acai.forum;
/**
 * Title:        ????????
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */



public class Friend
{
	private int friendID;
	private String friendUserName,friendFriend,friendAddTime;
	private String friendEmail,friendHomePage,friendOicq;
	public Friend(){}
	public void setFriendID(int friendID){
		this.friendID=friendID;
	}
	public int getFriendID(){
		return this.friendID;
	}

	public void setFriendUserName(String friendUserName){
		this.friendUserName=friendUserName;
	}
	public String getFriendUserName(){
		return friendUserName;
	}
	public void setFriendFriend(String friendFriend){
		this.friendFriend=friendFriend;
	}
	public String getFriendFriend(){
		return this.friendFriend;
	}
	public void setFriendAddTime(String friendAddTime){
		this.friendAddTime=friendAddTime;
	}
	public String getFriendAddTime(){
		return friendAddTime;
	}
	public String getFriendEmail(){
		return this.friendEmail;
	}
	public void setFriendEmail(String friendEmail){
		this.friendEmail=friendEmail;
	}
	public String getFriendHomePage(){
		return friendHomePage;
	}
	public void setFriendHomePage(String friendHomePage){
		this.friendHomePage=friendHomePage;
	}
	public void setFriendOicq(String friendOicq){
		this.friendOicq=friendOicq;
	}
	public String getFriendOicq(){
		return this.friendOicq;
	}
	


}