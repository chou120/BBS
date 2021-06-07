package net.acai.forum;
/**
 * Title:        清清网络
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
import net.acai.forum.util.*;
import java.util.regex.*;

public class ForumSearch
{
	int searchTopicNum=0;
	String orderName="";
	public ForumSearch(){
	}
	public int getSearchTopicNum(){
		return searchTopicNum;
	}
	public String getOrderName(){
		return orderName;
	}

	public Vector getResult(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Vector searchResult =new Vector();



		try{
			int forumID=ParamUtil.getInt(request,"forumID",0);
			int sType=ParamUtil.getInt(request,"sType");

			int pSearch=ParamUtil.getInt(request,"pSearch",0);
			int nSearch=ParamUtil.getInt(request,"nSearch",0);
			String keyword=ParamUtil.getString(request,"keyword","");
			String searchForum="";
			if(sType<1||sType>3)
				throw new Exception("<li>对不起,请您选择搜索的类型");
			String searchDate="";
			if(sType<3){
				if(keyword==null||"".equals(keyword))
					throw new Exception("<li>对不起，请您输入搜索得关键字");

				if(forumID!=0)
				searchForum=" b.boardid="+forumID+" and ";
				searchDate=ParamUtil.getString(request,"SearchDate");
				if(searchDate==null||"".equals(searchDate))
					throw new Exception("<li>请您选择搜索的日期");
			}

			int searchDateLimit=30;
			String searchDay;
			if ("ALL".equals(searchDate)){
				searchDay=" date_add(dateandtime,interval "+searchDateLimit+" DAY) > getdate()  and ";
			}
			else{
				searchDay="  date_add(dateandtime,interval "+ParamUtil.getInt(request,"SearchDate",0)+" DAY) > getdate()  and ";
			}

			String guestlist="";
			String sql="";
			//DBConnect dbc=new DBConnect(2,0);
			DBConnect dbc=new DBConnect();

			switch (sType){
			case 1:
				switch (nSearch){
				//搜索主题帖子作者
				case 1:
				sql="select b.locktopic,b.boardid,b.rootid,b.announceid,b.body,b.Expression,b.topic,b.username,b.child,b.hits,b.dateandtime,board.lockboard from bbs.bbs1 b inner join bbs.board on b.boardid=bbs.board.boardid where b.username=? and  "+searchForum+" "+searchDay+" b.parentid=0 ORDER BY b.announceID desc";
				orderName="搜索主题作者帖子";

				dbc.prepareStatement(sql);
				dbc.setBytes(1,(new String(keyword.getBytes("ISO-8859-1"),"GBK")).getBytes());
				break;
				//'搜索回复帖子作者
				case 2:
				sql="select b.locktopic,b.boardid,b.rootid,b.announceid,b.body,b.Expression,b.topic,b.username,b.child,b.hits,b.dateandtime,board.lockboard from bbs.bbs1 b inner join bbs.board on b.boardid=bbs.board.boardid where b.username=? and "+guestlist+" "+searchForum+" "+searchDay+" b.parentid>0 ORDER BY b.announceID desc";
				orderName="搜索回复作者帖子";
				dbc.prepareStatement(sql);
				dbc.setBytes(1,(new String(keyword.getBytes("ISO-8859-1"),"GBK")).getBytes());

				break;
				//'两者都搜索
				case 3:
				sql="select b.locktopic,b.boardid,b.rootid,b.announceid,b.body,b.Expression,b.topic,b.username,b.child,b.hits,b.dateandtime,board.lockboard from bbs.bbs1 b inner join bbs.board on b.boardid=bbs.board.boardid where "+guestlist+" "+searchForum+" "+searchDay+" b.username=? ORDER BY b.announceID desc";
				orderName="搜索主题和回复作者帖子";
				dbc.prepareStatement(sql);
				dbc.setBytes(1,(new String(keyword.getBytes("ISO-8859-1"),"GBK")).getBytes());

				break;
				}
				break;
			case 2:
				switch(pSearch){
				//'搜索主题关键字
				case 1:
				sql="select b.locktopic,b.boardid,b.rootid,b.announceid,b.body,b.Expression,b.topic,b.username,b.child,b.hits,b.dateandtime,board.lockboard from bbs.bbs1 b inner join bbs.board on b.boardid=bbs.board.boardid where  "+guestlist+" "+searchForum+" "+searchDay+" ( topic like ? ) ORDER BY b.announceID desc";
				//'搜索内容关键字
				orderName="搜索主题";
				dbc.prepareStatement(sql);
				dbc.setBytes(1,(new String(("%"+keyword+"%").getBytes("ISO-8859-1"),"GBK")).getBytes());

				break;
				case 2:
				sql="select b.locktopic,b.boardid,b.rootid,b.announceid,b.body,b.Expression,b.topic,b.username,b.child,b.hits,b.dateandtime,board.lockboard from bbs.bbs1 b inner join bbs.board on b.boardid=bbs.board.boardid where  "+guestlist+" "+searchForum+" "+searchDay+" (" + StringUtils.getTranslateStr(keyword,"body") + ") ORDER BY b.announceID desc";
				//'两者都搜索
				orderName="搜索内容";
				dbc.prepareStatement(sql);
				//dbc.setBytes(1,keyword.getBytes("GBK"));

				break;
				case 3:
				sql="select b.locktopic,b.boardid,b.rootid,b.announceid,b.body,b.Expression,b.topic,b.username,b.child,b.hits,b.dateandtime,board.lockboard from bbs.bbs1 b inner join bbs.board on b.boardid=bbs.board.boardid where  "+guestlist+" "+searchForum+" "+searchDay+" (" + StringUtils.getTranslateStr(keyword,"topic") + " or " + StringUtils.getTranslateStr(keyword,"body") + ") ORDER BY b.announceID desc";
				orderName="搜索主题和内容";
				dbc.prepareStatement(sql);
				//dbc.setBytes(1,keyword.getBytes("GBK"));

				break;
				}
				break;
			case 3:
				sql="select   b.locktopic,b.boardid,b.rootid,b.announceid,b.body,b.Expression,b.topic,b.username,b.child,b.hits,b.dateandtime,board.lockboard from bbs.bbs1 b,bbs.board where "+guestlist+" b.boardid=bbs.board.boardid ORDER BY b.announceID desc";
				orderName="最新50帖";
				dbc.prepareStatement(sql);
				//dbc.setBytes(1,keyword.getBytes("GBK"));

				break;
			}

			if(sql.equals(""))
				throw new Exception("<li>对不起，sql语句出错！");


			int perPage=ParamUtil.getInt(request,"perPage",10);
			int Page=ParamUtil.getInt(request,"Page",1);
			int startPage=((Page-1)/10)*10+1;
			int start=(Page-1)*perPage+1;



			ResultSet rs=dbc.executeQuery(sql);


			/*
			if(rs.last())
			searchTopicNum=rs.getRow();
			if(start>searchTopicNum)
				return searchResult;
			rs.absolute(start);
			*/
			
			
			//rs=dbc.executeQuery(sql);
			searchTopicNum = 0 ;
			while(rs.next())
			{
				searchTopicNum  ++ ;
			}
			if(start>searchTopicNum)
				return searchResult;

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





			int i=0;


			
			while(rs.next())
				{



					ForumTopic theTopic=new ForumTopic();

					theTopic.setLockTopic(rs.getInt(1));
					theTopic.setForumID(rs.getInt(2));
					theTopic.setRootID(rs.getInt(3));
					theTopic.setAnnounceID(rs.getInt(4));
					theTopic.setBody(rs.getString(5));
					theTopic.setExpression(rs.getString(6));
					theTopic.setTopic(rs.getString(7));
					theTopic.setUserName(rs.getString(8));
					theTopic.setChildNum(rs.getInt(9));
					theTopic.setHits(rs.getInt(10));
					theTopic.setDateAndTime(rs.getString(11));


					/*theTopic.setParentID(rs.getInt(2));



					theTopic.setUserEmail(rs.getString(6));




					theTopic.setLength(rs.getInt(11));

					theTopic.setLayer(rs.getInt(13));
					theTopic.setOrders(rs.getInt(14));
					theTopic.setIsBest(rs.getInt(15));
					theTopic.setUserIP(rs.getString(16));

					theTopic.setTimes(rs.getInt(18));

					theTopic.setSignFlag(rs.getInt(20));
					theTopic.setEmailFlag(rs.getInt(21));
					theTopic.setIsTop(rs.getInt(22));
					theTopic.setIsVote(rs.getInt(23));*/
					searchResult.add(theTopic);
					i++;
					if(i==perPage)
					break;

					if(sType==3&&i==50)break;
				}
			dbc.close();



		}
		catch(SQLException se)
		{
			se.printStackTrace();
		}
		catch(Exception e){
			throw e;
		}

	 return searchResult;
	}

}