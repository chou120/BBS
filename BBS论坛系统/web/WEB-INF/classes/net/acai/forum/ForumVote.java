package net.acai.forum;
/**
 * Title:        ÇåÇåÍøÂç
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */
import java.util.Vector;



public class ForumVote
{
	int voteID,announceID,voteType;
	
	String vote,voteNum,voteUser; 

	
	public ForumVote(){
		
	}
	public void setVoteID(int voteID){
		this.voteID=voteID;
	}
	public int getVoteID(){
		return voteID;
	}
	public void setAnnounceID(int announceID){
		this.announceID=announceID;
	}
	public int getAnnounceID(){
		return this.announceID;
	}
	public void setVoteType(int voteType){
		this.voteType=voteType;
	}
	public int getVoteType(){
		return this.voteType;
	}
	public void setVote(String vote){
		this.vote=vote;
	}
	public String getVote(){
		return vote;
	}
	public void setVoteNum(String voteNum){
		this.voteNum=voteNum;
	}
	public String getVoteNum(){
		return this.voteNum;
	}
	public void setVoteUser(String voteUser){
		this.voteUser=voteUser;
	}
	public String getVoteUser(){
		return voteUser;
	}


	public String [] getVoteS(){
		String reg="(\r|\n)";
		String [] tempString=vote.split(reg);
		return tempString; 
	}
	public int [] getVoteNumS(){
		String [] tempNumS=voteNum.split("\\|");
		int [] tempIntS= new int [tempNumS.length];
		for(int i=0;i<tempNumS.length;i++)
			tempIntS[i]=Integer.parseInt(tempNumS[i]);
		return tempIntS;
	}

	public boolean getUserSign(String userName){
		String [] users=voteUser.split("\\|");
		for(int i=0;i<users.length;i++){
			if(userName.equals(users[i])){
				return true;
			}
		}
		return false;

	}


}