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
import net.acai.database.*;
import javax.servlet.http.*;
import java.sql.*;
import net.acai.util.*;
import java.util.Vector;
public class SMSManager{
	String userName,sql;
	User theUser;
	public SMSManager(HttpServletRequest request,HttpServletResponse response) throws Exception{
		userName=GCookie.getCookieValue(request,"UJBBUName","");
		theUser=SkinUtil.checkUser(request,response,4);
	}
	public SMSMSG getSMSMSG(HttpServletRequest request) throws Exception {
		return this.getSMSMSG(request,"inbox");
	}
	public static boolean checkSMS(HttpServletRequest request){
		String userName=GCookie.getCookieValue(request,"UJBBUName","");
		boolean smsSign=false;

		try{
			DBConnect dbc=new DBConnect();
			String sql="Select Count(id) From bbs.Message Where flag=0 and issend=1 and delR=0 And incept=?";
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			ResultSet rs=dbc.executeQuery();
			if(rs.next())
				smsSign=true;
			dbc.close();
		}
		catch(Exception e){

			e.printStackTrace();
		}
		return smsSign;

	}
	public static SMSMSG getNewSMS(HttpServletRequest request){
		String userName=GCookie.getCookieValue(request,"UJBBUName","");


		try{
			DBConnect dbc=new DBConnect();
			String sql="Select  id,sender From bbs.Message Where flag=0 and issend=1 and delR=0 And incept=?";
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			ResultSet rs=dbc.executeQuery();
			if(!rs.next()){
				dbc.close();
				return null;
			}
			SMSMSG sms=new SMSMSG();
			sms.setID(rs.getInt(1));
			sms.setSender(rs.getString(2));
			dbc.close();
			return sms;
		}
		catch(Exception e){

			e.printStackTrace();
			return null;
		}

	}
	public SMSMSG getSMSMSG(HttpServletRequest request,String sign) throws Exception {
		DBConnect dbc=new DBConnect();
		int ID=0;
		try{
			ID=ParamUtil.getInt(request,"id");
		}
		catch(Exception e){
			throw new Exception("??ָ?????ز?????");
		}
		if(sign.equals("fw")){
			sql="select * from bbs.message where (incept=? or sender=?) and id="+ID;
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(2,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		}
		else if(sign.equals("edit")){
			sql="select * from bbs.message where sender=? and issend=0 and id="+ID;
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		}
		else if(sign.equals("read")){
			sql="update bbs.message set flag=1 where ID="+ID;
			dbc.executeUpdate(sql);
			sql="select * from bbs.message where (incept=? or sender=?) and id="+ID;
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(2,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		}
		else {
			sql="select * from bbs.message where incept=? and id="+ID;
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());

		}
		ResultSet rs=dbc.executeQuery();
		rs.next();
		SMSMSG sms=new SMSMSG();
		sms.setID(rs.getInt(1));
		sms.setSender(rs.getString(2));
		sms.setIncept(rs.getString(3));
		sms.setTitle(rs.getString(4));
		sms.setContent(rs.getString(5));
		sms.setFlag(rs.getInt(6));
		sms.setSendtime(rs.getString(7));
		sms.setDelR(rs.getInt(8));
		sms.setDelS(rs.getInt(9));
		sms.setIsSend(rs.getInt(10));
		dbc.close();
		return sms;
	}
	public Vector getInBox() throws Exception{
		Vector smsVector=new Vector();
		DBConnect dbc=new DBConnect();
		sql="select * from bbs.message where incept=? and issend=1 and delR=0 order by flag,sendtime desc";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		ResultSet rs=dbc.executeQuery();
		while(rs.next()){
			SMSMSG sms=new SMSMSG();
			sms.setID(rs.getInt(1));
			sms.setSender(rs.getString(2));
			sms.setIncept(rs.getString(3));
			sms.setTitle(rs.getString(4));
			sms.setContent(rs.getString(5));
			sms.setFlag(rs.getInt(6));
			sms.setSendtime(rs.getString(7));
			sms.setDelR(rs.getInt(8));
			sms.setDelS(rs.getInt(9));
			sms.setIsSend(rs.getInt(10));
			smsVector.add(sms);
		}
		dbc.close();
		return smsVector;

	}
	public Vector getOutBox() throws Exception{
		Vector smsVector=new Vector();
		DBConnect dbc=new DBConnect();
		sql="select * from bbs.message where sender=? and issend=0 and delS=0 order by sendtime desc";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		ResultSet rs=dbc.executeQuery();
		while(rs.next()){
			SMSMSG sms=new SMSMSG();
			sms.setID(rs.getInt(1));
			sms.setSender(rs.getString(2));
			sms.setIncept(rs.getString(3));
			sms.setTitle(rs.getString(4));
			sms.setContent(rs.getString(5));
			sms.setFlag(rs.getInt(6));
			sms.setSendtime(rs.getString(7));
			sms.setDelR(rs.getInt(8));
			sms.setDelS(rs.getInt(9));
			sms.setIsSend(rs.getInt(10));
			smsVector.add(sms);
		}
		dbc.close();
		return smsVector;

	}
	public Vector getRecycle() throws Exception{
		Vector smsVector=new Vector();
		DBConnect dbc=new DBConnect();
		sql="select * from bbs.message where ((sender=? and delS=1) or (incept=? and delR=1)) and delS!=2 order by sendtime desc";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		ResultSet rs=dbc.executeQuery();
		while(rs.next()){
			SMSMSG sms=new SMSMSG();
			sms.setID(rs.getInt(1));
			sms.setSender(rs.getString(2));
			sms.setIncept(rs.getString(3));
			sms.setTitle(rs.getString(4));
			sms.setContent(rs.getString(5));
			sms.setFlag(rs.getInt(6));
			sms.setSendtime(rs.getString(7));
			sms.setDelR(rs.getInt(8));
			sms.setDelS(rs.getInt(9));
			sms.setIsSend(rs.getInt(10));
			smsVector.add(sms);
		}
		dbc.close();
		return smsVector;

	}
	public Vector getIsSend() throws Exception{
		Vector smsVector=new Vector();
		DBConnect dbc=new DBConnect();
		sql="select * from bbs.message where sender=? and issend=1 and delS=0 order by sendtime desc";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		ResultSet rs=dbc.executeQuery();
		while(rs.next()){
			SMSMSG sms=new SMSMSG();
			sms.setID(rs.getInt(1));
			sms.setSender(rs.getString(2));
			sms.setIncept(rs.getString(3));
			sms.setTitle(rs.getString(4));
			sms.setContent(rs.getString(5));
			sms.setFlag(rs.getInt(6));
			sms.setSendtime(rs.getString(7));
			sms.setDelR(rs.getInt(8));
			sms.setDelS(rs.getInt(9));
			sms.setIsSend(rs.getInt(10));
			smsVector.add(sms);
		}
		dbc.close();
		return smsVector;

	}
	public void  delInBox(HttpServletRequest request) throws Exception{
		int ID=0;
        String[] ids = request.getParameterValues("id");
		if(ids.length==0)
			throw new Exception("??ָ?????ز?????");
        for(int i=0;i<ids.length;i++)
        {
            ID = Integer.parseInt(ids[i]);
            DBConnect dbc = new DBConnect();
            sql = "update bbs.message set delR=1 where incept=? and id =" + ID;
            dbc.prepareStatement(sql);
            dbc.setBytes(1, (new String(userName.getBytes("ISO-8859-1"), "GBK")).getBytes());
            dbc.executeUpdate();
            dbc.close();
        }
	}

	public void  allDelInBox() throws Exception{
		sql="update bbs.message set delR=1 where incept=? and delR=0";
		DBConnect dbc=new DBConnect();
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}
	public void  delOutBox(HttpServletRequest request) throws Exception{
		int ID=0;
        String[] ids = request.getParameterValues("id");
        if(ids.length==0)
            throw new Exception("??ָ?????ز?????");
        for(int i=0;i<ids.length;i++)
        {
            ID = Integer.parseInt(ids[i]);

            DBConnect dbc = new DBConnect();
            sql = "update bbs.message set delS=1 where sender=? and issend=0 and id =" + ID;
            dbc.prepareStatement(sql);
            dbc.setBytes(1, (new String(userName.getBytes("ISO-8859-1"), "GBK")).getBytes());
            dbc.executeUpdate();
            dbc.close();
        }
	}

	public void  allDelOutBox() throws Exception{
		sql="update bbs.message set delS=1 where sender=? and delS=0 and issend=0";
		DBConnect dbc=new DBConnect();
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}
	public void  delIsSend(HttpServletRequest request) throws Exception{
		int ID=0;
        String[] ids = request.getParameterValues("id");
        if(ids.length==0)
            throw new Exception("??ָ?????ز?????");
        for(int i=0;i<ids.length;i++)
        {
            ID = Integer.parseInt(ids[i]);

            DBConnect dbc = new DBConnect();
            sql = "update bbs.message set delS=1 where sender=? and issend=1 and id =" + ID;
            dbc.prepareStatement(sql);
            dbc.setBytes(1, (new String(userName.getBytes("ISO-8859-1"), "GBK")).getBytes());
            dbc.executeUpdate();
            dbc.close();
        }
	}
	public void  allDelIsSend() throws Exception{
		sql="update bbs.message set delS=1 where sender=? and delS=0 and issend=1";
		DBConnect dbc=new DBConnect();
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}
	public void  delRecycle(HttpServletRequest request) throws Exception{
		int ID=0;
        String[] ids = request.getParameterValues("id");
        if(ids.length==0)
            throw new Exception("??ָ?????ز?????");
        for(int i=0;i<ids.length;i++)
        {
            ID = Integer.parseInt(ids[i]);

            DBConnect dbc = new DBConnect();
            sql = "delete from bbs.message where incept=? and delR=1 and id=" + ID;
            dbc.prepareStatement(sql);
            dbc.setBytes(1, (new String(userName.getBytes("ISO-8859-1"), "GBK")).getBytes());
            dbc.executeUpdate();
            sql = "update bbs.message set delS=2 where sender=? and delS=1 and id =" + ID;
            dbc.prepareStatement(sql);
            dbc.setBytes(1, (new String(userName.getBytes("ISO-8859-1"), "GBK")).getBytes());
            dbc.executeUpdate();
            dbc.close();
        }
	}
	public void  allDelRecycle() throws Exception{
		DBConnect dbc=new DBConnect();
		sql="delete from bbs.message where incept=? and delR=1";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		sql="update bbs.message set delS=2 where sender=? and delS=1";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}
	public void  delete(HttpServletRequest request) throws Exception{
		int ID=0;
        String[] ids = request.getParameterValues("id");
        if(ids.length==0)
            throw new Exception("??ָ?????ز?????");
        for(int i=0;i<ids.length;i++)
        {
            ID = Integer.parseInt(ids[i]);

            DBConnect dbc = new DBConnect();

            sql = "update bbs.message set delR=1 where incept=? and id=" + ID;
            dbc.prepareStatement(sql);
            dbc.setBytes(1, (new String(userName.getBytes("ISO-8859-1"), "GBK")).getBytes());
            dbc.executeUpdate();
            sql = "update bbs.message set delS=1 where sender=? and id=" + ID;
            dbc.prepareStatement(sql);
            dbc.setBytes(1, (new String(userName.getBytes("ISO-8859-1"), "GBK")).getBytes());
            dbc.executeUpdate();
            dbc.close();
        }
	}





	///////////////////////////////////////////////////////////
	public void  saveSMS(HttpServletRequest request) throws Exception{

		String touser=ParamUtil.getString(request,"touser");
		if(touser==null||touser.trim().equals(""))
			throw new Exception("????????д???Ͷ????˰ɡ?");

		String title=ParamUtil.getString(request,"title");
		if(title==null||title.trim().equals(""))
			throw new Exception("????û????д????ѽ??");
		String message=ParamUtil.getString(request,"message");
		if(message==null||message.trim().equals(""))
			throw new Exception("?????Ǳ???Ҫ??д???ޡ?");

		String [] users=touser.split(",");
		DBConnect dbc=new DBConnect();
		ResultSet rs;
		for(int i=0;i<users.length;i++){
			if (i>4){
				dbc.close();
				throw new Exception("????ֻ?ܷ??͸?5???û???????????5λ?Ժ????????·???");
			}

			sql="select username from bbs.myuser where username=?";
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(users[i].getBytes("ISO-8859-1"),"GBK")).getBytes());
			rs=dbc.executeQuery();
			if(!rs.next()){
				dbc.close();
				throw new Exception("??̳û???????û??????????ķ??Ͷ???д?????");
			}

			String submit=new String(ParamUtil.getString(request,"Submit","").getBytes("ISO-8859-1"),"GBK");;

			if(submit.equals("????")){
				sql="insert into bbs.message (incept,sender,title,content,sendtime,flag,issend) values (?,?,?,?,getdate(),0,1)";
			}
			else{
				sql="insert into bbs.message (incept,sender,title,content,sendtime,flag,issend) values (?,?,?,?,getdate(),0,0)";
			}
			dbc.prepareStatement(sql);
			dbc.setBytes(1,(new String(users[i].getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(2,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(3,(new String(title.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.setBytes(4,(new String(message.getBytes("ISO-8859-1"),"GBK")).getBytes());
			dbc.executeUpdate();

		}
		dbc.close();

	}


	public void saveEdit(HttpServletRequest request) throws Exception{
		int ID=0;
		try{
			ID=ParamUtil.getInt(request,"id");
		}
		catch(Exception e){
			throw new Exception("??ָ?????ز?????");
		}
		String touser=ParamUtil.getString(request,"touser");
		if(touser==null||touser.trim().equals(""))
			throw new Exception("????????д???Ͷ????˰ɡ?");

		String title=ParamUtil.getString(request,"title");
		if(title==null||title.trim().equals(""))
			throw new Exception("????û????д????ѽ??");
		String message=ParamUtil.getString(request,"message");
		if(message==null||message.trim().equals(""))
			throw new Exception("?????Ǳ???Ҫ??д???ޡ?");

		String incept=touser;

		DBConnect dbc=new DBConnect();
		sql="select username from bbs.myuser where username=?";
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(incept.getBytes("ISO-8859-1"),"GBK")).getBytes());

		ResultSet rs=dbc.executeQuery();
		if(!rs.next()){
				dbc.close();
				throw new Exception("??̳û???????û??????????ķ??Ͷ???д?????");
		}
		rs.close();
		String submit=new String(ParamUtil.getString(request,"Submit","").getBytes("ISO-8859-1"),"GBK");

		if(submit.equals("????")){
			sql="update bbs.message set incept=?,sender=?,title=?,content=?,sendtime=getdate(),flag=0,issend=1 where id="+ID;
		}
		else{
			sql="update bbs.message set incept=?,sender=?,title=?,content=?,sendtime=getdate(),flag=0,issend=0 where id="+ID;
		}
		dbc.prepareStatement(sql);
		dbc.setBytes(1,(new String(incept.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(2,(new String(userName.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(3,(new String(title.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.setBytes(4,(new String(message.getBytes("ISO-8859-1"),"GBK")).getBytes());
		dbc.executeUpdate();
		dbc.close();
	}
}
