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
import java.sql.*;
import net.acai.filter.*;
import net.acai.util.*;
import net.acai.forum.*;
import net.acai.util.Format;
import java.util.Vector;
import javax.servlet.http.*;
//import net.acai.forum.util.*;
import java.util.regex.*;

public class Forum{

	int forumID,forumClass,lockForum,forumSkin,lastBbsNum;
	int lastTopicNum,strAllowForumCode,strAllowHTML,strIMGInPosts;
	int strIcons,strFlash,lastRootID,todayNum;
	int voteID;
	String forumType,readMe,forumMaster;
	String tableBack,tableTitle,tableBody,aTableBody,tableFont,tableContent;
	String alertFont,lastPostUser,lastPostTime,forumLogo,indexIMG,lastTopic,forumUser;
	Vector forumOLUsers;
	int forumTopicNum;
	int forumOLGuestUsersNum=0,forumOLMemberUsersNum=0,forumsOLUsersNum=0;
	int forumMSGsNum=0;
	ForumTopic forumMSGTopic;
	public Forum(){
	}
	public Forum(HttpServletRequest request,HttpServletResponse response,int forumID) throws ForumNotFoundException{
		init(forumID);
		SkinUtil.checkUserStats(request,response,this.forumType);
		this.getOnline();
	}

	public Forum(int forumID) throws ForumNotFoundException{
		init(forumID);

		this.getOnline();
	}

	public void init(int forumID) throws ForumNotFoundException{
		try{
			DBConnect dbc=new DBConnect("select * from bbs.board where boardid=?");
			dbc.setInt(1,forumID);
			ResultSet rs=dbc.executeQuery();
			rs.next();
			this.forumID=rs.getInt(1);
			forumType=rs.getString(2);
			forumClass=rs.getInt(3);
			readMe=rs.getString(4);
			forumMaster=rs.getString(5);
			lockForum=rs.getInt(6);
			forumSkin=rs.getInt(7);
			tableBack=rs.getString(8);
			tableTitle=rs.getString(9);
			tableBody=rs.getString(10);
			aTableBody=rs.getString(11);
			tableFont=rs.getString(12);
			tableContent=rs.getString(13);
			alertFont=rs.getString(14);
			lastPostUser=rs.getString(15);
			lastPostTime=rs.getString(16);
			lastBbsNum=rs.getInt(17);
			lastTopicNum=rs.getInt(18);
			strAllowForumCode=rs.getInt(19);
			strAllowHTML=rs.getInt(20);
			strIMGInPosts=rs.getInt(21);
			strIcons=rs.getInt(22);
			strFlash=rs.getInt(23);
			forumLogo=rs.getString(24);
			indexIMG=rs.getString(25);
			lastRootID=rs.getInt(26);
			lastTopic=rs.getString(27);
			todayNum=rs.getInt(28);
			forumUser=rs.getString(29);
			dbc.clearParameters();
			dbc.close();
		}
		catch(Exception e){
			e.printStackTrace();
			throw new ForumNotFoundException();
		}
	}

	public Vector getOnline() throws ForumNotFoundException{
		try{
			DBConnect dbc=new DBConnect();
			dbc.prepareStatement("select * from bbs.online order by id");
			ResultSet rs=dbc.executeQuery();
			forumsOLUsersNum=rs.getRow();
			forumOLUsers=new Vector();
			dbc.prepareStatement("select * from bbs.online where stats like ? order by id");
			String tempForumType="%"+forumType+"%";
			dbc.setBytes(1,(new String(tempForumType.getBytes("ISO-8859-1"),"GBK")).getBytes());
			rs=dbc.executeQuery();

			while(rs.next()){//&&this.forumType.equals(rs.getString(4).trim())){

				OLUser tempOLUser=new OLUser();
				tempOLUser.setUserID(rs.getInt(1));
				if("guest".equals(rs.getString(2)))
					forumOLGuestUsersNum++;
				else
					forumOLMemberUsersNum++;
				tempOLUser.setUserName(rs.getString(2));
				tempOLUser.setUserClass(rs.getString(3));
				tempOLUser.setStats(rs.getString(4));
				tempOLUser.setUserIP(rs.getString(5));
				tempOLUser.setStartTime(rs.getString(6));
				tempOLUser.setLastTimeBK(rs.getString(7));
				tempOLUser.setLastTime(rs.getString(8));
				tempOLUser.setBrowser(rs.getString(9));
				tempOLUser.setActForIP(rs.getString(10));
				tempOLUser.setComeFrom(rs.getString(11));
				tempOLUser.setActCome(rs.getString(12));
				forumOLUsers.add(tempOLUser);

			}

			dbc.close();
			return forumOLUsers;
		}
		catch(Exception e){
			e.printStackTrace();
			throw new ForumNotFoundException();
		}
	}

	public Vector getForumTopics  (int forumID,int start ,int Page) throws ForumTopicNotFoundException{
		try
		{
			//DBConnect dbc=new DBConnect(2,0);
			DBConnect dbc=new DBConnect();
			ResultSet rs=dbc.executeQuery("select count(announceid) from bbs.bbs1 where boardID="+forumID+" and parentID=0  and  locktopic!=2");
			rs.next();
			forumTopicNum=rs.getInt(1);

			String sql="select count(Announceid) from bbs.bbs1 where istop=1 and layer=1 and boardid="+forumID;
			rs=dbc.executeQuery(sql);
			rs.next();
			int topNum=rs.getInt(1);
			rs.close();
			int maxAnnouncePerPage=Integer.parseInt(ForumPropertiesManager.getString("MaxAnnouncePerPage"));

			/*if(Page>1)
				sql="select * from bbs1 where boardID="+forumID+" and parentID=0\n and times < (select all (times) from bbs1 where boardID="+forumID+" and istop=0 and parentID=0 order by times desc limit 0,"+((Page-1)*maxAnnouncePerPage-topNum)+")  and\n  locktopic!=2 ORDER BY istop desc,times desc,announceid desc limit\n 0,"+maxAnnouncePerPage;
			else*/
				sql="select * from bbs.bbs1 where boardID="+forumID+" and parentID=0  and  locktopic!=2\n ORDER BY istop desc,times desc,announceid desc\n";

			dbc.prepareStatement(sql);
			rs=dbc.executeQuery();
			int num1 = ((Page-1)*maxAnnouncePerPage) ;
			int num2 = (((Page-1)*maxAnnouncePerPage)+maxAnnouncePerPage) ;
			int i = 0 ;
			int n = 0 ;
			Vector forumTopics=new Vector();
			while(rs.next()){
			
					i++;
					if(i<num1)continue;

					n++;
					if(n>num2)break;

					ForumTopic theTopic=new ForumTopic(rs.getInt(12));
					theTopic.setAnnounceID(rs.getInt(1));
					theTopic.setParentID(rs.getInt(2));
					theTopic.setChildNum(rs.getInt(3));
					theTopic.setForumID(rs.getInt(4));
					theTopic.setUserName(rs.getString(5));
					theTopic.setUserEmail(rs.getString(6));
					theTopic.setTopic(rs.getString(7));
					theTopic.setBody(rs.getString(8));
					theTopic.setDateAndTime(rs.getString(9));
					theTopic.setHits(rs.getInt(10));
					theTopic.setLength(rs.getInt(11));
					theTopic.setRootID(rs.getInt(12));
					theTopic.setLayer(rs.getInt(13));
					theTopic.setOrders(rs.getInt(14));
					theTopic.setIsBest(rs.getInt(15));
					theTopic.setUserIP(rs.getString(16));
					theTopic.setExpression(rs.getString(17));
					theTopic.setTimes(rs.getInt(18));
					theTopic.setLockTopic(rs.getInt(19));
					theTopic.setSignFlag(rs.getInt(20));
					theTopic.setEmailFlag(rs.getInt(21));
					theTopic.setIsTop(rs.getInt(22));
					theTopic.setIsVote(rs.getInt(23));
					forumTopics.add(theTopic);

				}

			dbc.close();
			return forumTopics;
		}
		catch ( ForumTopicNotFoundException  oe )
		{
			oe.printStackTrace();
			return null;
		}
		catch ( SQLException s3 )
		{
			s3.printStackTrace();
			return null;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw new ForumTopicNotFoundException();
		}
	}
	public Vector getForumBestTopics  (int forumID,int start ,int perPage) throws ForumTopicNotFoundException{
		try{
			//DBConnect dbc=new DBConnect(2,0);
			DBConnect dbc=new DBConnect();
			dbc.prepareStatement("select * from bbs.bbs1 where boardID=? and isBest=1 and locktopic!=2  ORDER BY bbs1.times desc,bbs1.announceid desc");
			dbc.setInt(1,forumID);
			ResultSet rs=dbc.executeQuery();
			if(rs.last())
			forumTopicNum=rs.getRow();
			rs.absolute(start);
			int i=0;
			Vector forumTopics=new Vector();
			do
				{

					ForumTopic theTopic=new ForumTopic(rs.getInt(12));
					theTopic.setAnnounceID(rs.getInt(1));
					theTopic.setParentID(rs.getInt(2));
					theTopic.setChildNum(rs.getInt(3));
					theTopic.setForumID(rs.getInt(4));
					theTopic.setUserName(rs.getString(5));
					theTopic.setUserEmail(rs.getString(6));
					theTopic.setTopic(rs.getString(7));
					theTopic.setBody(rs.getString(8));
					theTopic.setDateAndTime(rs.getString(9));
					theTopic.setHits(rs.getInt(10));
					theTopic.setLength(rs.getInt(11));
					theTopic.setRootID(rs.getInt(12));
					theTopic.setLayer(rs.getInt(13));
					theTopic.setOrders(rs.getInt(14));
					theTopic.setIsBest(rs.getInt(15));
					theTopic.setUserIP(rs.getString(16));
					theTopic.setExpression(rs.getString(17));
					theTopic.setTimes(rs.getInt(18));
					theTopic.setLockTopic(rs.getInt(19));
					theTopic.setSignFlag(rs.getInt(20));
					theTopic.setEmailFlag(rs.getInt(21));
					theTopic.setIsTop(rs.getInt(22));
					theTopic.setIsVote(rs.getInt(23));
					forumTopics.add(theTopic);
					i++;
					if(i==perPage)
					break;
				}
			while(rs.next());
			dbc.close();
			return forumTopics;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw new ForumTopicNotFoundException();
		}
	}

	public static Vector getFollowTopics (int forumID,int rootID){
			Vector followTopics=new Vector();
			try{
				String sql="select announceID,layer,bbs.bbs1.boardID,rootID,topic,body,userName,child,hits from bbs.bbs1,bbs.board where bbs.bbs1.boardid="+forumID+" and bbs.bbs1.rootid="+rootID+" and bbs.bbs1.announceid<>"+rootID+" and bbs.bbs1.boardid=bbs.board.boardid and  bbs.bbs1.locktopic!=2 order by bbs.bbs1.rootid desc,bbs.bbs1.orders";
				//DBConnect dbc=new DBConnect(2,0);
				DBConnect dbc=new DBConnect();
				ResultSet rs=dbc.executeQuery(sql);

				while(rs.next()){
					ForumTopic theMSG=new ForumTopic();
					theMSG.setAnnounceID(rs.getInt("announceID"));
					theMSG.setLayer(rs.getInt("layer"));
					theMSG.setForumID(rs.getInt("boardID"));
					theMSG.setRootID(rs.getInt("rootID"));
					theMSG.setAnnounceID(rs.getInt("announceID"));

					/*
					if(rs.getString("topic")==null||rs.getString("topic").trim().equals("")){
						String m=rs.getString("body");
						if(rs.getString("body").length()>22)
							theMSG.setTopic(m.substring(0,22).replaceAll("\\n|\\r"," ").replaceAll(">", "&gt;").replaceAll("<", "&lt;"));
						else{

							theMSG.setTopic(m.replaceAll("\\r|\\n"," ").replaceAll(">", "&gt;").replaceAll("<", "&lt;"));
						}
					}
					else*/
					theMSG.setTopic(rs.getString("topic"));
					theMSG.setBody(rs.getString("body"));
					theMSG.setUserName(rs.getString("userName"));
					theMSG.setChildNum(rs.getInt("child"));
					theMSG.setHits(rs.getInt("hits"));

					followTopics.add(theMSG);
				}
				dbc.close();

			}
			catch(Exception e){
				e.printStackTrace();
			}

			return followTopics;

	}
	public ForumMSG getForumMSGTopic(){
		return this.forumMSGTopic;
	}
	public Vector getForumMSGs  (int forumID,int rootID,int announceID,int start ,int perPage) throws ForumMSGNotFoundException{
		try{
			DBConnect dbc=new DBConnect();
			ResultSet rs=dbc.executeQuery("select topic,istop,isbest,username,hits,times from bbs.bbs1 where announceID="+rootID);
			rs.next();
			forumMSGTopic=new ForumTopic();
			forumMSGTopic.setTopic(rs.getString(1));
			forumMSGTopic.setIsTop(rs.getInt(2));
			forumMSGTopic.setIsBest(rs.getInt(3));
			forumMSGTopic.setUserName(rs.getString(4));
			forumMSGTopic.setHits(rs.getInt(5));
			forumMSGTopic.setTimes(rs.getInt(6));
			forumMSGTopic.setAnnounceID(rootID);
			rs.close();


			String sql="Select B.AnnounceID,B.boardID,B.UserName,B.Topic,B.dateandtime,B.body,"+
				"B.Expression,B.ip,B.rootid,B.signflag,B.isbest,B.isvote,"+
				"U.username,U.useremail,U.homepage,U.oicq,U.sign,U.userclass,"+
				"U.title,U.width,U.height,U.article,U.face,U.addDate,"+
				"U.userWealth,U.userEP,U.userCP,B.hits,B.isTop,B.lockTopic"+
				" from bbs.bbs1 B inner join bbs.myuser U on U.username=B.username "+
				"where B.boardid="+forumID+" and B.rootid="+rootID+" and B.lockTopic!=2 order by announceid";

			rs=dbc.executeQuery(sql);

			//if(rs.last())				forumMSGsNum=rs.getRow();
			forumMSGsNum = 0 ;
			while(rs.next())
			{
				forumMSGsNum  ++ ;
			}

			rs=dbc.executeQuery(sql);
			int t = 1 ;
			if(t<start)
			{
				while(rs.next())
				{
					if(t==start)break;
					t++;
				}
			}

			//rs.absolute(start);

			int i=0;
			Vector forumMSGs=new Vector();
			while(rs.next())
				{

					ForumMSG theMSG=new ForumMSG();
					theMSG.setAnnounceID(rs.getInt(1));
					theMSG.setForumID(rs.getInt(2));
					theMSG.setUserName(rs.getString(3));
					theMSG.setTopic(rs.getString(4));
					theMSG.setDateAndTime(rs.getString(5));
					theMSG.setBody(rs.getString(6));
					theMSG.setExpression(rs.getString(7));
					theMSG.setUserIP(rs.getString(8));
					theMSG.setRootID(rs.getInt(9));
					theMSG.setSignFlag(rs.getInt(10));
					theMSG.setIsBest(rs.getInt(11));
					theMSG.setIsVote(rs.getInt(12));
					theMSG.setIsTop(rs.getInt(29));
					theMSG.setLockTopic(rs.getInt(30));
					theMSG.setHits(rs.getInt(28)+1);
					User msgUser=new User();
					msgUser.setUserName(rs.getString(13));
					msgUser.setUserEmail(rs.getString(14));
					msgUser.setHomePage(rs.getString(15));
					msgUser.setOicq(rs.getString(16));
					msgUser.setSign(rs.getString(17));
					msgUser.setUserClass(rs.getInt(18));
					msgUser.setTitle(rs.getString(19));
					msgUser.setWidth(rs.getInt(20));
					msgUser.setHeight(rs.getInt(21));
					msgUser.setArticle(rs.getInt(22));
					msgUser.setFace(rs.getString(23));
					msgUser.setAddDate(rs.getString(24));
					msgUser.setUserWealth(rs.getInt(25));
					msgUser.setUserEP(rs.getInt(26));
					msgUser.setUserCP(rs.getInt(27));
					theMSG.setUser(msgUser);
					forumMSGs.add(theMSG);
					i++;
					if(i==perPage)
					break;
				}
			sql="update bbs.bbs1 set hits=hits+1 where announceID="+announceID;
			dbc.executeUpdate(sql);
			dbc.close();
			return forumMSGs;
		}
		catch(SQLException se)
		{
			se.printStackTrace();
			throw new ForumMSGNotFoundException();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw new ForumMSGNotFoundException();
		}
	}
	public static Vector getForumTextMSGs  (HttpServletRequest request) throws ForumMSGNotFoundException{
		try{
			int forumID,rootID;
			try{
				forumID=ParamUtil.getInt(request,"forumID");
				rootID=ParamUtil.getInt(request,"rootID");

			}
			catch(Exception e){
				throw new Exception("?Բ?????û?з??????ӣ?");
			}


			//DBConnect dbc=new DBConnect(2,0);
			DBConnect dbc=new DBConnect();
			String sql="Select UserName,Topic,dateandtime,body from bbs.bbs1 where boardid="+forumID+" and rootid="+rootID+" order by announceid";

			ResultSet rs=dbc.executeQuery(sql);

			/*if(!rs.next())
				throw new Exception("?Բ???û?з???????!");*/

			Vector forumMSGs=new Vector();
			while(rs.next())
				{

					ForumMSG theMSG=new ForumMSG();
					//theMSG.setAnnounceID(rs.getInt(1));
					//theMSG.setForumID(rs.getInt(2));
					theMSG.setUserName(rs.getString(1));
					theMSG.setTopic(rs.getString(2));
					theMSG.setDateAndTime(rs.getString(3));
					theMSG.setBody(rs.getString(4));
					/*theMSG.setExpression(rs.getString(7));
					theMSG.setUserIP(rs.getString(8));
					theMSG.setRootID(rs.getInt(9));
					theMSG.setSignFlag(rs.getInt(10));
					theMSG.setIsBest(rs.getInt(11));
					theMSG.setIsVote(rs.getInt(12));
					theMSG.setIsTop(rs.getInt(29));
					theMSG.setLockTopic(rs.getInt(30));
					theMSG.setHits(rs.getInt(28)+1);
					User msgUser=new User();
					msgUser.setUserName(rs.getString(13));
					msgUser.setUserEmail(rs.getString(14));
					msgUser.setHomePage(rs.getString(15));
					msgUser.setOicq(rs.getString(16));
					msgUser.setSign(rs.getString(17));
					msgUser.setUserClass(rs.getInt(18));
					msgUser.setTitle(rs.getString(19));
					msgUser.setWidth(rs.getInt(20));
					msgUser.setHeight(rs.getInt(21));
					msgUser.setArticle(rs.getInt(22));
					msgUser.setFace(rs.getString(23));
					msgUser.setAddDate(rs.getString(24));
					msgUser.setUserWealth(rs.getInt(25));
					msgUser.setUserEP(rs.getInt(26));
					msgUser.setUserCP(rs.getInt(27));
					theMSG.setUser(msgUser);*/
					forumMSGs.add(theMSG);

				}

			dbc.close();
			return forumMSGs;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw new ForumMSGNotFoundException(e.getMessage());
		}
	}
	public int getForumMSGsNum(){
		return this.forumMSGsNum;
	}
	public int getForumTopicNum(){
		return forumTopicNum;
	}

	public int getForumID(){
		return forumID;
	}
	public String getForumType(){
		return forumType;
	}
	public int getForumClass(){
		return forumClass;
	}
	public String getReadMe(){
		return readMe;
	}
	public String getForumMaster(){
		return forumMaster;
	}
	public int getLockForum(){
		return lockForum;
	}
	public int getForumSkin(){
		return forumSkin;
	}
	public String getTableBack(){
		return tableBack;
	}
	public String getTableTitle(){
		return tableTitle;
	}
	public String getTableBody(){
		return tableBody;
	}
	public String getATableBody(){
		return aTableBody;
	}
	public String getTableFont(){
		return tableFont;
	}
	public String getTableContent(){
		return tableContent;
	}
	public String getAlertFont(){
		return alertFont;
	}
	public String getLastPostUser(){
		return lastPostUser;
	}
	public String getLastPostTime(){
		return lastPostTime;
	}
	public int getLastBbsNum(){
		return lastBbsNum;
	}
	public int getLastTopicNum(){
		return lastTopicNum;
	}
	public boolean getStrAllowForumCode(){
		if(strAllowForumCode==1)
			return true;
		else
			return false;
	}
	public boolean getStrAllowHTML(){
		if(strAllowHTML==1)
			return true;
		else
			return false;
	}
	public boolean getStrIMGInPosts(){
		if(strIMGInPosts==1)
			return true;
		else
			return false;
	}
	public boolean getStrIcons(){
		if(strIcons==1)
			return true;
		else
			return false;
	}
	public boolean getStrFlash(){
		if(strFlash==1)
			return true;
		else
			return false;
	}
	public String getForumLogo(){
		return forumLogo;
	}
	public String getIndexIMG(){
		return indexIMG;
	}
	public int getLastRootID(){
		return lastRootID;
	}
	public String getLastTopic(){
		return StringUtils.escapeHTMLTags(this.lastTopic);
	}
	public int getTodayNum(){
		return todayNum;
	}
	public String getForumUser(){
		return forumUser;
	}
	public Vector getForumOLUsers(){
		return forumOLUsers;
	}
	public int getForumOLGuestUsersNum(){
		return this.forumOLGuestUsersNum;
	}
	public int getForumOLMemberUsersNum(){
		return this.forumOLMemberUsersNum;
	}

	public int getForumsOLUsersNum(){
		return this.forumsOLUsersNum;
	}

	public String getForumIMG(String lastlogin){
		String strIMG="";
		switch(this.getForumSkin())
		{
			case 1:
			if(Format.compareTo(lastlogin,this.lastPostTime))
				strIMG="<img src=pic/foldernew.gif width=13 height=16 alt=??????̳??????????>";
			else
				strIMG="<img src=pic/ifolder.gif width=13 height=16 alt=??????̳??????????>";
			break;
			case 2:
			if(Format.compareTo(lastlogin,this.lastPostTime))
				strIMG="<img src=pic/folderallnew.gif width=13 height=16 alt=??????̳??????????>";
			else
				strIMG="<img src=pic/folderall.gif width=13 height=16 alt=??????̳??????????>";
			break;
			case 3:
			if(Format.compareTo(lastlogin,this.lastPostTime))
				strIMG="<img src=pic/follownew.gif width=13 height=16 alt=??????̳??????????>";
			else
				strIMG="<img src=pic/follow.gif width=13 height=16 alt=??????̳??????????>";
			break;
			case 4:
			if(Format.compareTo(lastlogin,this.lastPostTime))
				strIMG="<img src=pic/jinghua.gif width=13 height=16 alt=????????????????>";
			else
				strIMG="<img src=pic/jinghua.gif width=13 height=16 alt=????????????????>";
			break;
			case 5:
			if(Format.compareTo(lastlogin,this.lastPostTime))
				strIMG="<img src=pic/lock_l.gif width=13 height=16 alt=??֤??̳??????????>";
			else
				strIMG="<img src=pic/lock_b.gif width=13 height=16 alt=??֤??̳??????????>";
			break;
			case 6:
			if(Format.compareTo(lastlogin,this.lastPostTime))
				strIMG="<img src=pic/foldernew.gif width=13 height=16 alt=??????̳??????????>";
			else
				strIMG="<img src=pic/ifolder.gif width=13 height=16 alt=??????̳??????????>";
			break;
			default:
		}

	return strIMG;
	}

	public String authorSaveMSG(HttpServletRequest request,HttpServletResponse response) throws Exception{

		String userName=ParamUtil.getString(request,"userName","");
		String userPassword=ParamUtil.getString(request,"userPassword","");
		String sql="";
		String char_changed = "[align=right][???????Ѿ?????????"+Format.getDateTime()+"?༭??][/align]";
        	try{

        		User tempUser=new User(userName,userPassword,4);
				DBConnect dbc=new DBConnect();
				ResultSet rs;
        		int forumID=ParamUtil.getInt(request,"forumID");
				int announceID=ParamUtil.getInt(request,"announceID");
				int rootID=ParamUtil.getInt(request,"rootID");
				dbc.prepareStatement("select * from bbs.bbs1 where announceID=? and rootID=? and userName=?");
				dbc.setInt(1,announceID);
				dbc.setInt(2,rootID);
				dbc.setBytes(3,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
				rs=dbc.executeQuery();
				if(!rs.next())
					throw new Exception("<li>?Բ???????û??Ȩ???༭?????ӣ?</li>");
        		String subject=ParamUtil.getString(request,"subject","");
        		String content=ParamUtil.getString(request,"content","")+"\n\n\n\n"+char_changed;
        		String expression=ParamUtil.getString(request,"expression","");
        		int signFlag=ParamUtil.getInt(request,"signFlag",1);
        		int emailFlag=ParamUtil.getInt(request,"emailFlag",0);
        		if(subject.equals("")) throw new Exception("û??????????");

			sql="update bbs.bbs1 set Topic=?,Body=?,DateAndTime=getdate(),length=?,ip=?,expression=?,signflag=?,emailflag=? where announceID=?";
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(subject.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(2,(new String(content.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setInt(3,content.length());
			dbc.setString(4,request.getRemoteAddr());
			dbc.setString(5,expression);
			dbc.setInt(6,signFlag);
			dbc.setInt(7,emailFlag);
			dbc.setInt(8,announceID);


			dbc.executeUpdate();
			dbc.close();
			return "dispbbs.jsp?forumID="+forumID+"&rootID="+rootID+"&announceID="+announceID+"#"+announceID;
  		}
  		catch(UserNotFoundException e){
  			throw new Exception("û?з????û?");
  		}
  		catch(Exception e){
  			e.printStackTrace();
  			throw new Exception("<Br>"+"<li>"+e.getMessage());
		}
	}
	public String masterSaveMSG(HttpServletRequest request,HttpServletResponse response) throws Exception{

		String userName=GCookie.getCookieValue(request,"UJBBUName","");

		//String userPassword=ParamUtil.getString(request,"userPassword","");
		String sql="";
		String char_changed = "[align=right][???????Ѿ???"+userName+"??"+Format.getDateTime()+"?༭??][/align]";
        	try{

        		User tempUser=SkinUtil.checkUser(request,response,4);
				DBConnect dbc=new DBConnect();
				ResultSet rs;
        		int forumID=ParamUtil.getInt(request,"forumID");
				int announceID=ParamUtil.getInt(request,"announceID");
				int rootID=ParamUtil.getInt(request,"rootID");

        		String subject=ParamUtil.getString(request,"subject","");
        		String content=ParamUtil.getString(request,"content","")+"\n\n\n\n"+char_changed;
        		String expression=ParamUtil.getString(request,"expression","");
        		int signFlag=ParamUtil.getInt(request,"signFlag",1);
        		int emailFlag=ParamUtil.getInt(request,"emailFlag",0);
        		if(subject.equals("")) throw new Exception("û??????????");

			sql="update bbs.bbs1 set Topic=?,Body=?,DateAndTime=getdate(),length=?,ip=?,expression=?,signflag=?,emailflag=? where announceID=?";
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(subject.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(2,(new String(content.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setInt(3,content.length());
			dbc.setString(4,request.getRemoteAddr());
			dbc.setString(5,expression);
			dbc.setInt(6,signFlag);
			dbc.setInt(7,emailFlag);
			dbc.setInt(8,announceID);


			dbc.executeUpdate();
			dbc.close();
			return "dispbbs.jsp?forumID="+forumID+"&rootID="+rootID+"&announceID="+announceID+"#"+announceID;
  		}
  		catch(UserNotFoundException e){
  			throw new Exception("û?з????û?");
  		}
  		catch(Exception e){
  			e.printStackTrace();
  			throw new Exception("<Br>"+"<li>"+e.getMessage());
		}
	}
	public String addTopic(HttpServletRequest request,HttpServletResponse response) throws Exception{

		String userName=ParamUtil.getString(request,"userName","");
		String userPassword=ParamUtil.getString(request,"userPassword","");
		String sql="";

        	try{

        		//SkinUtil.userLogin(request,response,2);
        		User tempUser=new User(userName,userPassword,2);
				DBConnect dbc=new DBConnect();
        		int forumID=ParamUtil.getInt(request,"forumID",1);
        		String subject=ParamUtil.getString(request,"subject","");
        		String content=ParamUtil.getString(request,"content","");
        		String expression=ParamUtil.getString(request,"expression","");
				int isVote=ParamUtil.getInt(request,"isVote",0);
        		int signFlag=ParamUtil.getInt(request,"signFlag",1);
        		int emailFlag=ParamUtil.getInt(request,"emailFlag",0);
        		if(subject.equals("")) throw new Exception("û??????????");

			sql="insert into bbs.bbs1(Boardid,ParentID,Child,username,topic,body,DateAndTime,hits,length,rootid,layer,orders,ip,Expression,locktopic,signflag,emailflag,istop,isbest,isvote,times) values "+
				"("+
				forumID+",0,0,?,?,?,'"+
				Format.getDateTime()+"',0,"+
				content.length()+",0,1,0,'"+request.getRemoteAddr()+"','"+
				expression+".gif',0,"+signFlag+","+emailFlag+",0,0,"+isVote+",0)";

			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(2,(new String(subject.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(3,(new String(content.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.executeUpdate();
			ResultSet rs=dbc.executeQuery("select announceid from bbs.bbs1 order by announceid desc");
	        	rs.next();
	        	int announceID=rs.getInt(1);
				voteID=announceID;
			sql="update bbs.bbs1 set rootid="+announceID+",times="+announceID+" where announceid="+announceID;
			dbc.executeUpdate(sql);
			String shortTopic="";
			if ("".equals(subject))
				if(content.length()>21)
					shortTopic=content.substring(0,20);
				else
					shortTopic=content;
			else
				if(subject.length()>21)
					shortTopic=subject.substring(0,20);
				else
					shortTopic=subject;
			ResultSet tmprs=dbc.executeQuery("Select count(announceid) from bbs.bbs1 Where day(dateandtime)-day(getdate())=0 and boardid="+forumID);
	    		tmprs.next();
	    		int forumToday=tmprs.getInt(1);
	    		tmprs=null;
			sql="update bbs.board set lastpostuser=?,lastposttime='"+Format.getDateTime()+"',lastbbsnum=lastbbsnum+1,lasttopicnum=lasttopicnum+1,todaynum="+forumToday+",lastrootid="+announceID+",lasttopic=? where  boardid="+forumID;
			dbc.clearParameters();
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(2,(new String(shortTopic.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.executeUpdate();
			tmprs=dbc.executeQuery("Select count(announceid) from bbs.bbs1 Where day(dateandtime)-day(getdate())=0");
	    		tmprs.next();
	    		int allTodays=tmprs.getInt(1);
			dbc.executeUpdate("update bbs.config set topicnum=topicnum+1,bbsnum=bbsnum+1,todayNum="+allTodays);
			dbc.close();
			ForumPropertiesManager.resetManager();
			return "dispbbs.jsp?forumID="+forumID+"&rootID="+announceID+"&announceID="+announceID;
  		}
  		catch(UserNotFoundException e){
  			throw new Exception("û?з????û?");
  		}
  		catch(Exception e){
  			e.printStackTrace();
  			throw new Exception("<Br>"+"<li>???ݿ?????ʧ?ܣ????Ժ?????");
		}
	}
	public String addMSG(HttpServletRequest request,HttpServletResponse response)throws UserNotFoundException ,Exception{
		//try{
			String userName=ParamUtil.getString(request,"userName","");
			String userPassword=ParamUtil.getString(request,"userPassword","");
			//SkinUtil.userLogin(request,response,3);
			User tempUser=new User(userName,userPassword,3);
        		DBConnect dbc=new DBConnect();
        		int forumID=this.forumID;
        		String subject=ParamUtil.getString(request,"subject","");
        		String content=ParamUtil.getString(request,"content","");
        		String expression=ParamUtil.getString(request,"expression","face7.gif");
				String sql="";
				int rootID=ParamUtil.getInt(request,"rootID");
				ResultSet rs;
				dbc.prepareStatement("select locktopic from bbs.bbs1 where announceid="+rootID);
				rs=dbc.executeQuery();
				if(!rs.next()){
					dbc.close();
					throw new Exception("<li>?Բ?????û?з??ִ????⣡</li>");
				}
				else{
					//rs.next();
					if(rs.getInt(1)==1||rs.getInt(1)==2){
						dbc.close();
						throw new Exception("?Բ??𣬴??????Ѿ????????????ܻظ???");
					}
				}

				int iLayer,iOrders;
        		int signFlag=ParamUtil.getInt(request,"signFlag",1);
        		int emailFlag=ParamUtil.getInt(request,"emailFlag",0);

				int parentID=ParamUtil.getInt(request,"parentID",rootID);
				sql="select layer,orders from bbs.bbs1 where announceid="+parentID;
				rs=dbc.executeQuery(sql);
				if(rs.next()){
					if(rs.getString(1)!=null)
						iLayer=0;
					else
						iLayer=rs.getInt(1);
					if(rs.getString(2)!=null)
						iOrders=0;
					else
						iOrders=rs.getInt(2);
				}
				else{
					iLayer=0;
					iOrders=0;
				}
				rs.close();
				if (rootID!=0){
					iLayer=iLayer+1;
					dbc.executeUpdate("update bbs.bbs1 set orders=orders+1 where rootid="+rootID+" and orders>"+iOrders);
					iOrders=iOrders+1;
		     	}
        		sql="insert into bbs.bbs1(Boardid,ParentID,Child,username,topic,body,DateAndTime,hits,length,rootid,layer,orders,ip,Expression,locktopic,signflag,emailflag,istop,isbest,isvote,times) values "+
				"("+
				forumID+","+parentID+",0,"+
				"?,?,?,'"+
				Format.getDateTime()+"',0,"+
				content.length()+","+rootID+","+iLayer+","+iOrders+",'"+request.getRemoteAddr()+"','"+
				expression+"',0,"+signFlag+","+emailFlag+",0,0,0,0)";
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(2,(new String(subject.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(3,(new String(content.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.executeUpdate();
			rs=dbc.executeQuery("select announceid from bbs.bbs1 order by announceid desc");
        	rs.next();
        	int announceID=rs.getInt(1);
			sql="update bbs.bbs1 set child=child+1,times="+announceID+" where rootID="+rootID;
          		dbc.executeUpdate(sql);
          	String shortTopic="";

           if ("".equals(subject))
				if(content.length()>21)
					shortTopic=content.substring(0,20);
				else
					shortTopic=content;
			else
				if(subject.length()>21)
					shortTopic=subject.substring(0,20);
				else
					shortTopic=subject;
			ResultSet tmprs=dbc.executeQuery("Select count(announceid) from bbs.bbs1 Where day(dateandtime)-day(getdate())=0 and boardid="+forumID);
	    		tmprs.next();
	    		int forumToday=tmprs.getInt(1);
	    		tmprs=null;

			sql="update bbs.board set lastpostuser=?,lastposttime='"+Format.getDateTime()+"',lastbbsnum=lastbbsnum+1,todaynum="+forumToday+",lastrootid="+rootID+",lasttopic=? where  boardid="+forumID;
			dbc.clearParameters();
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(2,(new String(shortTopic.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.executeUpdate();
			tmprs=dbc.executeQuery("Select count(announceid) from bbs.bbs1 Where day(dateandtime)-day(getdate())=0");
	    		tmprs.next();
	    		int allTodays=tmprs.getInt(1);
			dbc.executeUpdate("update bbs.config set bbsnum=bbsnum+1,todayNum="+allTodays);
			dbc.close();
			ForumPropertiesManager.resetManager();
			return "dispbbs.jsp?forumID="+forumID+"&rootID="+rootID+"&announceID="+announceID+"#"+announceID;


	}
	public String addVote(HttpServletRequest request,HttpServletResponse response) throws Exception{
		try{

			String vote=ParamUtil.getString(request,"vote");
			String userName=ParamUtil.getString(request,"userName","");
			if(vote==null)		throw new Exception("<li>????????ѡ??????</li>");
			String voteNum="";

		String reg="(\r|\n)";
		String [] tempString=vote.split(reg);


		for(int i=0;i<tempString.length;i++)

			if(!tempString[i].trim().equals(""))
				if(i==tempString.length-1)
					voteNum+="0";
				else
					voteNum+="0|";








			int voteType=ParamUtil.getInt(request,"voteType",0);

			String url=this.addTopic(request,response);
			DBConnect dbc=new DBConnect("insert into bbs.vote(announceID,vote,voteNum,voteType,voteUser) values(?,?,?,?,?)");
			dbc.setInt(1,voteID);
			dbc.setBytes(2,(new String(vote.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setString(3,voteNum);
			dbc.setInt(4,voteType);
			dbc.setBytes(5,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.executeUpdate();
			dbc.close();
			return url;
		}
		catch(Exception e){
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}

	}
	public ForumVote getForumVote(int announceID) throws Exception{
		DBConnect dbc=new DBConnect("select * from bbs.vote where announceID=?");
		dbc.setInt(1,announceID);
		ResultSet rs=dbc.executeQuery();
		if(rs.next()){
		ForumVote forumVote=new ForumVote();
		forumVote.setVoteID(rs.getInt(1));
		forumVote.setAnnounceID(rs.getInt(2));
		forumVote.setVote(rs.getString(3));
		forumVote.setVoteNum(rs.getString(4));
		forumVote.setVoteUser(rs.getString(5));
		forumVote.setVoteType(rs.getInt(6));
		return forumVote;
		}
		else
			throw new Exception("<li>???󣬶Բ?????û?з???ͶƱ??</li>");
	}
	public String addVoteNum(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String userName=GCookie.getCookieValue(request,"UJBBUName","");
		String userPassword=GCookie.getCookieValue(request,"UJBBUPSW","");
		User tempUser=new User(userName,userPassword,1);
		int announceID=ParamUtil.getInt(request,"announceID");
		int forumID=ParamUtil.getInt(request,"forumID");
		ForumVote theVote=this.getForumVote(announceID);
		String voteNum="";
		int [] voteNumS=theVote.getVoteNumS();
		if(theVote.getUserSign(userName))
			throw new Exception("<li>?Բ????????Ѿ?ͶƱ?ˣ?</li>");
		else{
			if(theVote.getVoteType()==0){
				int postID=ParamUtil.getInt(request,"postVote");
				voteNumS[postID]++;
			}
			else{
				for(int i=0;i<voteNumS.length;i++){
					if(ParamUtil.getString(request,"postVote_"+(i))!=null)
						voteNumS[i]++;
					}
			}

			for(int i=0;i<voteNumS.length;i++)
				if(i==voteNumS.length-1)
					voteNum+=Integer.toString(voteNumS[i]);
				else
					voteNum+=Integer.toString(voteNumS[i])+"|";

		}
		DBConnect dbc=new DBConnect("select * from bbs.vote where announceID="+announceID);
		ResultSet rs=dbc.executeQuery();
		rs.next();
		String voteUser=rs.getString(5);
		voteUser+="|"+userName;
		dbc.prepareStatement("update bbs.vote set voteNum='"+voteNum+"',voteUser=? where announceID="+announceID);
		dbc.setBytes(1,(new String(voteUser.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();

		return "dispbbs.jsp?forumID="+forumID+"&rootID="+announceID+"&announceID="+announceID;



	}
}

