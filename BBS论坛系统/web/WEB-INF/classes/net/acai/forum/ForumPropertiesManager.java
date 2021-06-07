package net.acai.forum;
/**
 * Title:        清清网络
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */

/**
 * Title:        清清网络
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      211.68.39.120、webcpu.51.net
 * @author:       SuperSpace
 * @version 1.0
 */
import net.acai.database.*;
import net.acai.util.*;
import java.sql.*;
import java.util.Hashtable;
import javax.servlet.http.*;
public class ForumPropertiesManager{
	private static ForumPropertiesManager manager=null;
	private static Object managerLock=new Object();
	public static void resetManager(){
		manager=null;
	}

	public static String getString(String name) throws Exception{
		if(manager==null){
			synchronized(managerLock){
				if(manager==null){
					manager=new ForumPropertiesManager();
				}
			}
		}
		return manager.getStr(name);
	}
	public static void setString(String name){
		if(manager==null){
			synchronized(managerLock){
				if(manager==null){
					manager=new ForumPropertiesManager();
				}
			}
		}
		manager.setStr(name);
	}

	private static Hashtable forumHash=new Hashtable();
	public ForumPropertiesManager() {
		try{
			DBConnect dbc=new DBConnect("select * from bbs.config");
			ResultSet rs=dbc.executeQuery();
			ResultSetMetaData rsmd=rs.getMetaData();
			rs.next();
			for(int i=1;i<=rsmd.getColumnCount();i++){
				forumHash.put(rsmd.getColumnName(i),rs.getString(i));
			}
			dbc.close();
		}
		catch(SQLException e)
		{
			System.out.println("ResultSetMetaData出现问题!");
		}
		catch(Exception e)
		{
			System.out.println("DBConnect 出现问题！");
		}




	}
	public String getStr(String name) throws Exception{
		if(forumHash.isEmpty())
			throw new Exception("好像数据库连接有问题，请您确定您安装了数据库了吗？\n<br>如果您没有安装数据库，请您运行install.jsp，安装数据库！");
		return (String)forumHash.get(name);
	}
	public void setStr(String name)
	{
	}
	public Hashtable getHashtable(){
		return forumHash;
	}
	public static void saveGrade(HttpServletRequest request) throws Exception{
		int wealthReg,wealthLogin,wealthAnnounce,wealthReAnnounce,wealthDel;
		int epReg,epLogin,epAnnounce,epReAnnounce,epDel;
		int cpReg,cpLogin,cpAnnounce,cpReAnnounce,cpDel;
		try{
			wealthReg=ParamUtil.getInt(request,"wealthReg");
			wealthLogin=ParamUtil.getInt(request,"wealthLogin");
			wealthAnnounce=ParamUtil.getInt(request,"wealthAnnounce");
			wealthReAnnounce=ParamUtil.getInt(request,"wealthReAnnounce");
			wealthDel=ParamUtil.getInt(request,"wealthDel");

			epReg=ParamUtil.getInt(request,"epReg");
			epLogin=ParamUtil.getInt(request,"epLogin");
			epAnnounce=ParamUtil.getInt(request,"epAnnounce");
			epReAnnounce=ParamUtil.getInt(request,"epReAnnounce");
			epDel=ParamUtil.getInt(request,"epDel");

			cpReg=ParamUtil.getInt(request,"cpReg");
			cpLogin=ParamUtil.getInt(request,"cpLogin");
			cpAnnounce=ParamUtil.getInt(request,"cpAnnounce");
			cpReAnnounce=ParamUtil.getInt(request,"cpReAnnounce");
			cpDel=ParamUtil.getInt(request,"cpDel");
		}
		catch(Exception e){
			e.printStackTrace();
			throw new Exception("请您输入的为数字！");
		}
		String sql="update bbs.config set "+
			"wealthReg="+wealthReg+",wealthLogin="+wealthLogin+",wealthAnnounce="+wealthAnnounce+",wealthDel="+wealthDel+",wealthReAnnounce="+wealthReAnnounce+
			",epReg="+epReg+",epLogin="+epLogin+",epAnnounce="+epAnnounce+",epDel="+epDel+",epReAnnounce="+epReAnnounce+
			",cpReg="+cpReg+",cpLogin="+cpLogin+",cpAnnounce="+cpAnnounce+",cpDel="+cpDel+",cpReAnnounce="+cpReAnnounce;
		DBConnect dbc=new DBConnect(sql);
		dbc.executeUpdate();
		dbc.close();
		ForumPropertiesManager.resetManager();
	}
	public static void saveConst(HttpServletRequest request) throws Exception{

	String forumName=ParamUtil.getString(request,"forumName");
	if(forumName==null||"".equals(forumName.trim()))
		throw new Exception("请您输入论坛的名称！");
	String forumURL=ParamUtil.getString(request,"forumURL");
	if(forumURL==null||"".equals(forumURL.trim()))
		throw new Exception("请您输入论坛的连接地址！");
	String companyName=ParamUtil.getString(request,"companyName");
	if(companyName==null||"".equals(companyName.trim()))
		throw new Exception("请您输入主页的名称！");
	String hostURL=ParamUtil.getString(request,"hostURL");
	if(hostURL==null||"".equals(hostURL.trim()))
		throw new Exception("请您输入主页的地址！～");
	String SMTPServer=ParamUtil.getString(request,"SMTPServer");
	if(SMTPServer==null||"".equals(SMTPServer.trim()))
		throw new Exception("请您输入邮件服务器的地址！");
	String systemEmail=ParamUtil.getString(request,"systemEmail");
	if(systemEmail==null||"".equals(systemEmail.trim()))
		throw new Exception("请您填写邮件的发送人地址");
	int timeAdjust=ParamUtil.getInt(request,"timeAdjust",0);
	int scriptTimeOut=ParamUtil.getInt(request,"scriptTimeOut",300);
	String logo=ParamUtil.getString(request,"forumLogo");
	if(logo==null||"".equals(logo.trim()))
		throw new Exception("请您填写论坛的logo地址！");
	String picURL=ParamUtil.getString(request,"picURL");
	if(picURL==null||"".equals(picURL.trim()))
		throw new Exception("请您填写论坛图片的目录！");
	String faceURL=ParamUtil.getString(request,"faceURL");
	if(faceURL==null||"".equals(faceURL.trim()))
		throw new Exception("请您填写论坛的表情目录！");

	int emailFlag=ParamUtil.getInt(request,"emailFlag",0);
	int uploadPic=ParamUtil.getInt(request,"uploadPic",0);
	int ipFlag=ParamUtil.getInt(request,"ipFlag",0);
	int fromFlag=ParamUtil.getInt(request,"fromFlag",0);
	int titleFlag=ParamUtil.getInt(request,"titleFlag",0);
	int uploadFlag=ParamUtil.getInt(request,"uploadFlag",0);
	int guestUser=ParamUtil.getInt(request,"guestUser",0);
	String  openMSG=ParamUtil.getString(request,"openMSG","");
	String  announceMaxBytes=ParamUtil.getString(request,"announceMaxBytes","");
	String maxAnnouncePerPage=ParamUtil.getString(request,"maxAnnouncePerPage","");
	String maxTitleList=ParamUtil.getString(request,"maxTitleList","");
	String tableBackColor=ParamUtil.getString(request,"tableBackColor");
	String aTableBackColor=ParamUtil.getString(request,"aTableBackColor");
	String tableTitleColor=ParamUtil.getString(request,"tableTitleColor");
	String aTableTitleColor=ParamUtil.getString(request,"aTableTitleColor");
	String tableFontColor=ParamUtil.getString(request,"tableFontColor");
	String tableContentColor=ParamUtil.getString(request,"tableContentColor");
	String alertFontColor=ParamUtil.getString(request,"alertFontColor");
	String contentTitle=ParamUtil.getString(request,"contentTitle");
	String tableBodyColor=ParamUtil.getString(request,"tableBodyColor");
	String aTableBodyColor=ParamUtil.getString(request,"aTableBodyColor");
	String ads1=ParamUtil.getString(request,"ads1","");
	String ads2=ParamUtil.getString(request,"ads2","");
	String copyRight=ParamUtil.getString(request,"copyRight","");
	String version=ParamUtil.getString(request,"version","");
	//////////////////////////插入数据库中！//////////////////////////////////
	DBConnect dbc=new DBConnect();
	String sql="update bbs.config set forumName=?,forumURL=?,companyName=?,hostURL=?,SMTPServer=?\n"+
	",systemEmail=?,timeAdjust="+timeAdjust+",scriptTimeOut="+scriptTimeOut+",logo=?\n"+
	",picURL=?,faceURL=?,emailFlag="+emailFlag+",uploadPic="+uploadPic+",ipFlag="+ipFlag+"\n"+
	",fromFlag="+fromFlag+",uploadFlag="+uploadFlag+",guestUser="+guestUser+"\n"+
	",openMSG='"+openMSG+"',maxAnnouncePerPage='"+maxAnnouncePerPage+"'\n"+
	",announceMaxBytes='"+announceMaxBytes+"'\n"+
	",maxTitleList='"+maxTitleList+"',tableBackColor='"+tableBackColor+"'\n"+
	",aTableBackColor='"+aTableBackColor+"',tableTitleColor='"+tableTitleColor+"'\n"+
	",aTableTitleColor='"+aTableTitleColor+"',tableFontColor='"+tableFontColor+"'\n"+
	",tableContentColor='"+tableContentColor+"',alertFontColor='"+alertFontColor+"'\n"+
	",contentTitle='"+contentTitle+"',tableBodyColor='"+tableBodyColor+"'\n"+
	",aTableBodyColor='"+aTableBodyColor+"',ads1=?\n"+
	",ads2=?,copyRight=?\n"+
	",version=?";
	dbc.prepareStatement(sql);
	dbc.setBytes(1,(new String(forumName.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.setBytes(2,(new String(forumURL.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.setBytes(3,(new String(companyName.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.setBytes(4,(new String(hostURL.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.setBytes(5,(new String(SMTPServer.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.setBytes(6,(new String(systemEmail.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.setBytes(7,(new String(logo.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.setBytes(8,(new String(picURL.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.setBytes(9,(new String(faceURL.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.setBytes(10,(new String(ads1.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.setBytes(11,(new String(ads2.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.setBytes(12,(new String(copyRight.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.setBytes(13,(new String(version.getBytes("ISO-8859-1"),"GBK")).getBytes());
	dbc.executeUpdate();
	dbc.close();
	resetManager();


	}
}



