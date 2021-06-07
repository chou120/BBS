package net.acai.forum;
/**
 * Title:        ÇåÇåÍøÂç
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */

public class ForumLink{
	int linkID;
	String forumName;
	String readMe;
	String forumURL;
	public ForumLink(){
	}
	public void setLinkID(int linkID){
		this.linkID=linkID;
	}
	public int getLinkID(){
		return this.linkID;
	}
	public void setForumName(String forumName){
		this.forumName=forumName;
	}
	public String getForumName(){
		return this.forumName;
	}
	public void setReadMe(String readMe){
		this.readMe=readMe;
	}
	public String getReadMe(){
		return this.readMe;
	}
	public void setForumURL(String forumURL){
		this.forumURL=forumURL;
	}
	public String getForumURL(){
		return this.forumURL;
	}
}
