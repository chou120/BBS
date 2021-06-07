package net.acai.forum;
/**
 * Title:        清清网络
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */
import java.sql.ResultSet;
import java.util.Vector;
import net.acai.database.*;
import net.acai.forum.ForumLinkNotFoundException;



public class ForumLinkFactory{

	public static Vector getForumLinks() throws ForumLinkNotFoundException{
		try{
			DBConnect dbc=new DBConnect("select * from bbs.bbslink order by id");
			ResultSet rs=dbc.executeQuery();
			Vector forumLinkVector=new Vector();
			while(rs.next()){
				ForumLink tempLink=new ForumLink();
				tempLink.setLinkID(rs.getInt(1));
				tempLink.setForumName(rs.getString(2));
				tempLink.setReadMe(rs.getString(3));
				tempLink.setForumURL(rs.getString(4));
				forumLinkVector.add(tempLink);
			}
			dbc.close();
			return forumLinkVector;
		}
		catch(Exception e){
			e.printStackTrace();
			throw new ForumLinkNotFoundException();
		}
	}
	public static ForumLink getForumLink(int forumLinkID) throws Exception{
		DBConnect dbc=new DBConnect("select * from bbs.bbslink  where id="+forumLinkID);
		ResultSet rs=dbc.executeQuery();
		if(!rs.next())
			throw new Exception("对不起，没有发现此联盟论坛！");
		//rs.next();
		ForumLink tempLink=new ForumLink();
		tempLink.setLinkID(rs.getInt(1));
		tempLink.setForumName(rs.getString(2));
		tempLink.setReadMe(rs.getString(3));
		tempLink.setForumURL(rs.getString(4));
		dbc.close();
		return tempLink;


	}
}

			
		