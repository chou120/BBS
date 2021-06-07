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
public class ForumMSGAdmin
{	int forumID,rootID,announceID;
	String userName,sql,url,action;
	User theUser;
	public ForumMSGAdmin(){
	}
	public ForumMSGAdmin(HttpServletRequest request,HttpServletResponse response) throws Exception{
		userName=GCookie.getCookieValue(request,"UJBBUName","");

		theUser=SkinUtil.checkUser(request,response,4);
		checkAdmin(request,response);
		adminMSG(request,response);
	}

	public void checkAdmin(HttpServletRequest request,HttpServletResponse response) throws Exception{

		action=ParamUtil.getString(request,"action");
		if(action==null||"".equals(action))
			throw new Exception("错误请求！");

		forumID=ParamUtil.getInt(request,"forumID");
		if(!action.equals("delall")){
			rootID=ParamUtil.getInt(request,"rootID");
			announceID=ParamUtil.getInt(request,"announceID");
		}
		if(forumID==0)
			throw new Exception("请指定论坛版面");
		Forum theForum=new Forum(forumID);
		if(theForum==null||(theForum.getForumMaster().indexOf(userName)<0&&theUser.getUserClass()<20))
			throw new Exception("您不是该版面斑竹或者系统管理员。");
	}
	public void adminMSG(HttpServletRequest request,HttpServletResponse response) throws Exception{

		if (action.equals("lock"))
		 lockMSG();
		else if (action.equals("unlock"))
		 unlockMSG();
		else if (action.equals("deltopic"))
		 delTopic();
		else if (action.equals("move")){
			String tempString=ParamUtil.getString(request,"checked");
			if(tempString!=null&&"yes".equals(tempString))
				moveTopic(request);
			else
				return;
		}
		else if (action.equals("delall")){
			String tempString=ParamUtil.getString(request,"checked");
			if(tempString!=null&&"yes".equals(tempString))
				delAll(request);
			else
				return;
		}
		else if (action.equals("copy")){
			String tempString=ParamUtil.getString(request,"checked");
			if(tempString!=null&&"yes".equals(tempString))
				copyTopic(request);
		}

		else if (action.equals("top"))
		 topMSG();
		else if (action.equals("untop"))
		 untopMSG();
		else if (action.equals("delmsg" ))
		 delMSG();
		else if (action.equals("isbest"))
		 bestMSG();
		else if (action.equals("nobest" ))
		 unbestMSG();
		else
			throw new Exception ("请选择相应操作。");
	}
	public void  delAll(HttpServletRequest request) throws Exception{
		String username=ParamUtil.getString(request,"username");
		if(username==null||"".equals(username))
			throw new Exception("请输入被帖子删除用户名。");
		DBConnect dbc=new DBConnect();
		sql="Select Count(announceID) from bbs.bbs1 where boardID="+forumID+" and username=?";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(username.getBytes("ISO-8859-1"),"GBK")).getBytes());

		ResultSet rs=dbc.executeQuery();
		rs.next();
		int titlenum=rs.getInt(1);
    	rs.close();

		if(titlenum!=0){
			int wealthDel=Integer.parseInt(ForumPropertiesManager.getString("wealthDel"));

			int epDel=Integer.parseInt(ForumPropertiesManager.getString("epDel"));

			int cpDel=Integer.parseInt(ForumPropertiesManager.getString("cpDel"));

			sql="update bbs.bbs1 set locktopic=2 where boardID="+forumID+" and  username=?";
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(username.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.executeUpdate();
			sql="update bbs.myuser set article=article-"+titlenum+",userWealth=userWealth-"+(titlenum*wealthDel)+",userEP=userEP-"+(titlenum*epDel)+",userCP=userCP-"+(titlenum*cpDel)+" where username=?";
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(username.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.executeUpdate();


			sql="select count(announceid) from bbs.bbs1 where boardID="+forumID;
			rs=dbc.executeQuery(sql);
			rs.next();
			int NewAnnounceNum=rs.getInt(1);
			rs.close();

			sql="select count(announceid) from bbs.bbs1 where ParentID=0 and boardID="+forumID;
			rs=dbc.executeQuery(sql);
			rs.next();
			int NewTopicNum=rs.getInt(1);
			rs.close();

			sql="update bbs.board set lastbbsnum="+NewAnnounceNum+",lasttopicnum="+NewTopicNum+" where boardID="+forumID;
			dbc.executeUpdate();
		}
		dbc.close();
	}
	public void copyTopic(HttpServletRequest request) throws Exception{
		int newForumID=ParamUtil.getInt(request,"newForumID");
		DBConnect dbc=new DBConnect();
		ResultSet rs;
		if (forumID==newForumID){
			dbc.close();
			throw new Exception("不能在相同版面内进行转移操作。");
		}
		else{

			sql="select boardID,announceid,Parentid from bbs.bbs1 where announceid="+announceID+" and boardID="+forumID;
			dbc.prepareStatement(sql);
			rs=dbc.executeQuery();

			if(!rs.next()){
				dbc.close();
				throw new Exception ("您选择的贴子并不存在。");
			}
			else {
				//rs.next();
				if(rs.getInt(3)!=0){
					dbc.close();
					throw new Exception("您必须选择一个主题，而不是贴子。");
				}
			}
		}



		String  newtopic,username,body,dateandtime,ip,Expression;
		int msgLength, announceid;
		sql="select topic,username,body,dateAndTime,length,ip,Expression from bbs.bbs1 where announceid="+announceID;
		rs=dbc.executeQuery(sql);
		if(!rs.next()){
			dbc.close();
			throw new Exception("没有此贴!");
		}
		//rs.next();
		newtopic=rs.getString(1) + "-->" + userName + "添加";
		username=rs.getString(2);
		body=rs.getString(3);
		dateandtime=rs.getString(4);
		msgLength=rs.getInt(5);
		ip=rs.getString(6);
		Expression=rs.getString(7);
		rs.close();


		sql="insert into bbs.bbs1(boardID,parentID,child,userName,topic,\n body,dateandtime,hits,length,rootID,layer,orders,ip,Expression,locktopic,signflag,emailflag,times,isvote,istop,isbest) \n values("+newForumID+",0,0,?,?,?,'"+dateandtime+"', 0,"+msgLength+",0,1,0,'"+ip+"','"+Expression+"',\n 0,0,0,0,0,0,0)";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(username.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String(newtopic.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(3,(new String(body.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();


		sql="select announceID from bbs.bbs1 order by announceID desc";
		rs=dbc.executeQuery(sql);
		rs.next();
		announceid=rs.getInt(1);
		rs.close();

		sql="update bbs.bbs1 set rootID="+announceid+",times="+announceid+" where announceID="+announceid;
		dbc.executeUpdate(sql);


		int postNum,todayNum;

		sql="select count(*) from bbs.bbs1 where rootID="+rootID;
		dbc.prepareStatement(sql);
		rs=dbc.executeQuery();
		rs.next();
		postNum=rs.getInt(1);
		rs.close();

		sql="select count(*) from bbs.bbs1 where rootID="+rootID+" and day(dateandtime)=day(getdate())";
		rs=dbc.executeQuery(sql);
		rs.next();
		todayNum=rs.getInt(1);
		rs.close();

//'更新论坛贴子数据
		//LastCount(forumID)
		//LastCount(newForumID)
		//call BoardNumAdd(newForumID,1,postNum,todayNum)
		//call AllboardNumAdd(todayNum,postNum,1)

		lastCount(forumID);
		lastCount(newForumID);
		forumNumAdd(newForumID,0,1,todayNum,dbc);

		allForumNumAdd(todayNum,1,0,dbc);


		url="dispbbs.jsp?forumID="+newForumID+"&rootID="+announceid+"&announceID="+announceid;

		sql="insert into bbs.log (l_username,l_content,l_url) values (?,?,'"+url+"')";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String("拷贝帖子".getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
		ForumPropertiesManager.resetManager();

	}
	public void moveTopic(HttpServletRequest request) throws Exception{
		int newForumID=ParamUtil.getInt(request,"newForumID");
		DBConnect dbc=new DBConnect();
		ResultSet rs;
		if (forumID==newForumID){
			dbc.close();
			throw new Exception("不能在相同版面内进行转移操作。");
		}
		else{

			sql="select boardID,announceid,Parentid from bbs.bbs1 where announceid="+announceID+" and boardID="+forumID;
			dbc.prepareStatement(sql);
			rs=dbc.executeQuery();

			if(!rs.next()){
				dbc.close();
				throw new Exception ("您选择的贴子并不存在。");
			}
			else {
				//rs.next();
				if(rs.getInt(3)!=0){
					dbc.close();
					throw new Exception("您必须选择一个主题，而不是贴子。");
				}
			}
		}

		String leavemessage=ParamUtil.getString(request,"leavemessage");
		if(leavemessage==null||leavemessage.equals("")){
			dbc.close();
			throw new Exception("请选择相应的操作！");
		}



		if (leavemessage.equals("yes")) {
			//'ON ERROR RESUME NEXT
		}

		else if (leavemessage.equals("no")) {
			String newtopic;

			sql="select topic from bbs.bbs1 where announceid="+rootID;
			dbc.prepareStatement(sql);
			rs=dbc.executeQuery();
			rs.next();
			newtopic=rs.getString(1)+ "-->" + userName + "转移";
			rs.close();

			sql="update bbs.bbs1 set topic=? where announceid="+rootID;
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(newtopic.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.executeUpdate();

			sql="update bbs.bbs1 set boardID="+newForumID+" where rootID="+rootID;
			dbc.prepareStatement(sql);
			dbc.executeUpdate();

			int postNum,todayNum;

			sql="select count(*) from bbs.bbs1 where rootID="+rootID;
			dbc.prepareStatement(sql);
			rs=dbc.executeQuery();
			rs.next();
			postNum=rs.getInt(1);
			rs.close();

			sql="select count(*) from bbs.bbs1 where rootID="+rootID+" and day(dateandtime)=day(getdate())";
			rs=dbc.executeQuery(sql);
			rs.next();
			todayNum=rs.getInt(1);
			rs.close();

//'更新论坛贴子数据
			lastCount(forumID);
			forumNumSub(forumID,0,1,todayNum,dbc);
			lastCount(newForumID);
			forumNumAdd(newForumID,0,1,todayNum,dbc);
			//allForumNumSub(todayNum,1,0,dbc);



//'更新论坛数据结束

			url="dispbbs.jsp?forumID="+newForumID+"&rootID="+rootID+"&announceID="+rootID;
			sql="insert into bbs.log (l_username,l_content,l_url) values (?,?,'"+url+"')";
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(2,(new String("转移主题".getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.executeUpdate();
			dbc.close();
			ForumPropertiesManager.resetManager();
		}
		else{
			dbc.close();
			throw new Exception("请选择相应操作。");
		}
}
	//public void copyMSG() throws Exception{}

	public void lockMSG() throws Exception{
		sql="update bbs.bbs1 set locktopic=1 where boardID="+forumID+" and rootID="+rootID;
		DBConnect dbc=new DBConnect();
		dbc.executeUpdate(sql);
		url="dispbbs.jsp?forumID="+forumID+"&rootID="+rootID+"&announceID="+rootID;
		sql="insert into bbs.log (l_username,l_content,l_url) values (?,?,'"+url+"')";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String("锁定帖子".getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}

	public void unlockMSG() throws Exception{
		DBConnect dbc=new DBConnect();
		sql="update bbs.bbs1 set locktopic=0 where boardID="+forumID+" and rootID="+rootID;
		dbc.executeUpdate(sql);
		url="dispbbs.jsp?forumID="+forumID+"&rootID="+rootID+"&announceID="+rootID;
		sql="insert into bbs.log (l_username,l_content,l_url) values (?,?,'"+url+"')";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String("解除锁定".getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}
	public void topMSG() throws Exception{
		DBConnect dbc=new DBConnect();
		sql="update bbs.bbs1 set istop=1 where boardID="+forumID+" and rootID="+rootID;
		dbc.executeUpdate(sql);
		url="dispbbs.jsp?forumID="+forumID+"&rootID="+rootID+"&announceID="+rootID;
		sql="insert into bbs.log (l_username,l_content,l_url) values (?,?,'"+url+"')";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String("固顶帖子".getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}
	public void untopMSG() throws Exception{
		DBConnect dbc=new DBConnect();
		sql="update bbs.bbs1 set istop=0 where boardID="+forumID+" and rootID="+rootID;
		dbc.executeUpdate(sql);
		url="dispbbs.jsp?forumID="+forumID+"&rootID="+rootID+"&announceID="+rootID;
		sql="insert into bbs.log (l_username,l_content,l_url) values (?,?,'"+url+"')";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String("解除固顶".getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}
	public void bestMSG() throws Exception{
		DBConnect dbc=new DBConnect();
		sql="update bbs.bbs1 set isbest=1 where boardID="+forumID+" and announceid="+announceID;
		dbc.executeUpdate(sql);
		url="showannounce.jsp?forumID="+forumID+"&rootID="+rootID+"&announceID="+announceID;
		sql="insert into bbs.log (l_username,l_content,l_url) values (?,?,'"+url+"')";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String("加入精华".getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}
	public void unbestMSG() throws Exception{
		DBConnect dbc=new DBConnect();
		sql="update bbs.bbs1 set isbest=0 where boardID="+forumID+" and announceid="+announceID;
		dbc.executeUpdate(sql);
		url="showannounce.jsp?forumID="+forumID+"&rootID="+rootID+"&announceID="+announceID;
		sql="insert into bbs.log (l_username,l_content,l_url) values (?,?,'"+url+"')";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String("解除精华".getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}
	public void delMSG() throws Exception{
		DBConnect dbc=new DBConnect();
		sql="update bbs.bbs1 set locktopic=2 where boardID="+forumID+" and ParentID!=0 and announceid="+announceID;
		dbc.executeUpdate(sql);
		sql="select Max(announceid) from bbs1 where  locktopic!=2 and rootID="+rootID+" and boardID="+forumID;
		ResultSet rs=dbc.executeQuery(sql);
		rs.next();
		int lastPostime=rs.getInt(1);
		rs.close();

		int todayNum;
		sql="select count(*) from bbs.bbs1 where announceid="+announceID+" and day(dateandtime)=day(getdate())";
		rs=dbc.executeQuery(sql);
		rs.next();
		todayNum=rs.getInt(1);
		rs.close();

		lastCount(forumID);
		forumNumSub(forumID,0,1,todayNum,dbc);

		allForumNumSub(todayNum,1,0,dbc);

		int wealthDel=Integer.parseInt(ForumPropertiesManager.getString("wealthDel"));

		int epDel=Integer.parseInt(ForumPropertiesManager.getString("epDel"));

		int cpDel=Integer.parseInt(ForumPropertiesManager.getString("cpDel"));

		sql="update bbs.bbs1 set times="+lastPostime+" where rootID="+rootID+" and boardID="+forumID;
		dbc.executeUpdate(sql);
		sql="update bbs.bbs1 set child=child-1 where announceid="+rootID+" and boardID="+forumID;
		dbc.executeUpdate(sql);

		sql="update bbs.myuser set article=article-1,userWealth=userWealth-"+wealthDel+",userEP=userEP-"+epDel+",userCP=userCP-"+cpDel+"  where username=?";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());

		dbc.executeUpdate();
		url="showannounce.jsp?forumID="+forumID+"&rootID="+rootID+"&announceID="+announceID;
		sql="insert into bbs.log (l_username,l_content,l_url) values (?,?,'"+url+"')";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String("删除帖子".getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
		ForumPropertiesManager.resetManager();
	}

	public void delTopic() throws Exception{
		DBConnect dbc=new DBConnect();
		int todayNum,postNum;
		sql="select count(*) from bbs.bbs1 where rootID="+rootID;
		ResultSet  rs=dbc.executeQuery(sql);
		rs.next();
		postNum=rs.getInt(1);
		sql="select count(*) from bbs.bbs1 where rootID="+rootID+" and     day(dateandtime)=day(getdate())";
		rs=dbc.executeQuery(sql);
		rs.next();
		todayNum=rs.getInt(1);
		rs.close();
		int wealthDel=Integer.parseInt(ForumPropertiesManager.getString("wealthDel"));

		int epDel=Integer.parseInt(ForumPropertiesManager.getString("epDel"));

		int cpDel=Integer.parseInt(ForumPropertiesManager.getString("cpDel"));
		sql="select username from bbs.bbs1 where rootID="+rootID;

		rs=dbc.executeQuery(sql);



		while(rs.next()){
			String tempName=rs.getString(1);
			if(tempName!=null&&!"".equals(tempName)){
			sql="update bbs.myuser set article=article-1,userWealth=userWealth-"+wealthDel+",userEP=userEP-"+epDel+" where username=?";
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(tempName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.executeUpdate();
			}
		}

		rs.close();
		sql="update bbs.bbs1 set locktopic=2 where rootID="+rootID;
		dbc.executeUpdate(sql);

		lastCount(forumID);
		forumNumSub(forumID,1,postNum,todayNum,dbc);
		allForumNumSub(todayNum,postNum,1,dbc);

		url="dispbbs.jsp?forumID="+forumID+"&rootID="+rootID+"&announceID="+rootID;
		sql="insert into bbs.log (l_username,l_content,l_url) values (?,?,'"+url+"')";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String("删除主题".getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
		ForumPropertiesManager.resetManager();
	}





	public void lastCount(int forumID) throws Exception{
		DBConnect dbc=new DBConnect();
		ResultSet rs=dbc.executeQuery("select topic,body,rootID,dateandtime,username from bbs.bbs1 where locktopic!=2 and boardID="+forumID+" order by announceid desc");
		String lastTopic,body,lastPost,lastPostUser;
		int lastRootID;
		if (rs.next()) {
			lastTopic=rs.getString(1);
			body=rs.getString(2);
			if(lastTopic==null||"".equals(lastTopic)){
				if(body.length()>14)
					lastTopic=body.substring(0,14);
				else lastTopic=body;
			}

			lastRootID=rs.getInt(3);
			lastPost=rs.getString(4);
			lastPostUser=rs.getString(5);
		}
		else{
			lastTopic="无";
			lastRootID=0;
			lastPost=Format.getDateTime();
			lastPostUser="无";
		}
		rs.close();

		sql="update bbs.board set lastTopic=?,lastRootID='"+lastRootID+"',lastPosttime='"+lastPost+"',lastPostuser=? where boardID="+forumID;
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(lastTopic.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String(lastPostUser.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}


	public void  forumNumAdd(int forumID,int topicNum,int postNum,int todayNum,DBConnect dbc) throws Exception {
		sql="update bbs.board set lastbbsnum=lastbbsnum+"+postNum+",lastTopicNum=lastTopicNum+"+topicNum+",todayNum=todayNum+"+todayNum+" where boardID="+forumID;
		dbc.executeUpdate(sql);
	}

	//'版面发帖数减少
	public  void forumNumSub(int forumID,int topicNum,int postNum,int todayNum,DBConnect dbc) throws Exception {
		sql="update bbs.board set lastbbsnum=lastbbsnum-"+postNum+",lastTopicNum=lastTopicNum-"+topicNum+",todayNum=todayNum-"+todayNum+" where boardID="+forumID;
		//'response.write sql
		//'response.end
		dbc.executeUpdate(sql);
	}


	//'所有论坛发帖数增加
	public void  allForumNumAdd(int todayNum,int postNum,int topicNum,DBConnect dbc) throws Exception {
		sql="update bbs.config set TodayNum=todayNum+"+todayNum+",BbsNum=bbsNum+"+postNum+",TopicNum=topicNum+"+topicNum;
		dbc.executeUpdate(sql);
	}

	//'所有论坛发帖数减少
	public void allForumNumSub(int todayNum,int postNum,int topicNum,DBConnect dbc) throws Exception{
		sql="update bbs.config set TodayNum=todayNum-"+todayNum+",BbsNum=bbsNum-"+postNum+",TopicNum=topicNum-"+topicNum;
		dbc.executeUpdate(sql);
	}


}
