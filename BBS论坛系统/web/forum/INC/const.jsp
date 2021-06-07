<%@ page  import="net.acai.forum.*,
		 java.util.Date,
		 net.acai.util.*,
		net.acai.filter.*,
		net.acai.database.*"%>
<%
	long startTime=(new Date()).getTime();
	String forumName,forumURL,companyName,hostURL,SMTPServer,systemEmail,timeAdjust;
	String scriptTimeOut,forumLogo,picURL,faceURL,uploadPic,ipFlag,fromFlag,titleFlag;
	String uploadFlag,guestUser,guestLogin,openMSG,badWords,maxAnnouncePerPage,maxTitleList;
	String announceMaxBytes,tableBackColor,aTableBackColor,tableTitleColor,aTableTitleColor;
	String tableBodyColor,aTableBodyColor,tableFontColor,tableContentColor,alertFontColor;
	String contentTitle,ads1,ads2,copyRight,version;
	String wealthAnnounce,wealthReAnnounce,wealthDel,wealthLogin;
	String epAnnounce,epReAnnounce,epDel,epLogin;
	int wealthReg,cpReg,epReg,emailFlag;
	String cpAnnounce,cpReAnnounce,cpDel,cpLogin,cookiePath;
	String maxOnline,maxOnlineDate,titleName;
	String topicNum,bbsNum,todayNum,userNum,lastNum,lastUser;
	int tableWidth=700;	
   try{
	forumName=ForumPropertiesManager.getString("ForumName");
	forumURL=ForumPropertiesManager.getString("ForumURL");
	companyName=ForumPropertiesManager.getString("CompanyName");
	hostURL=ForumPropertiesManager.getString("HostUrl");
	SMTPServer=ForumPropertiesManager.getString("SMTPServer");
	systemEmail=ForumPropertiesManager.getString("SystemEmail");
	timeAdjust=ForumPropertiesManager.getString("TimeAdjust");
	scriptTimeOut=ForumPropertiesManager.getString("ScriptTimeOut");
	forumLogo=ForumPropertiesManager.getString("Logo");
	picURL=ForumPropertiesManager.getString("Picurl");
	faceURL=ForumPropertiesManager.getString("Faceurl");
	emailFlag=Integer.parseInt(ForumPropertiesManager.getString("EmailFlag"));
	uploadPic=ForumPropertiesManager.getString("Uploadpic");
	ipFlag=ForumPropertiesManager.getString("IpFlag");
	fromFlag=ForumPropertiesManager.getString("FromFlag");
	guestUser=ForumPropertiesManager.getString("guestuser");
	guestLogin=ForumPropertiesManager.getString("guestlogin");
	openMSG=ForumPropertiesManager.getString("openmsg");
	badWords=ForumPropertiesManager.getString("badwords");
	announceMaxBytes=ForumPropertiesManager.getString("AnnounceMaxBytes");
	maxAnnouncePerPage=ForumPropertiesManager.getString("MaxAnnouncePerPage");
	maxTitleList=ForumPropertiesManager.getString("Maxtitlelist");
	tableBackColor=ForumPropertiesManager.getString("Tablebackcolor");
	aTableBackColor=ForumPropertiesManager.getString("aTablebackcolor");
	tableTitleColor=ForumPropertiesManager.getString("Tabletitlecolor");
	aTableTitleColor=ForumPropertiesManager.getString("aTabletitlecolor");
	tableBodyColor=ForumPropertiesManager.getString("Tablebodycolor");
	aTableBodyColor=ForumPropertiesManager.getString("aTablebodycolor");
	tableFontColor=ForumPropertiesManager.getString("TableFontcolor");
	tableContentColor=ForumPropertiesManager.getString("TableContentcolor");
	alertFontColor=ForumPropertiesManager.getString("AlertFontColor");
	contentTitle=ForumPropertiesManager.getString("ContentTitle");
	ads1=ForumPropertiesManager.getString("ads1");
	ads2=ForumPropertiesManager.getString("ads2");
	copyRight=ForumPropertiesManager.getString("Copyright");
	version=ForumPropertiesManager.getString("Version");
	titleFlag=ForumPropertiesManager.getString("TitleFlag");
	uploadFlag=ForumPropertiesManager.getString("uploadFlag");
	
	wealthReg=Integer.parseInt(ForumPropertiesManager.getString("wealthReg"));
	wealthAnnounce=ForumPropertiesManager.getString("wealthAnnounce");
	wealthReAnnounce=ForumPropertiesManager.getString("wealthReannounce");
	wealthDel=ForumPropertiesManager.getString("wealthDel");
	wealthLogin=ForumPropertiesManager.getString("wealthLogin");
	
	epReg=Integer.parseInt(ForumPropertiesManager.getString("epReg"));
	epAnnounce=ForumPropertiesManager.getString("epAnnounce");
	epReAnnounce=ForumPropertiesManager.getString("epReannounce");
	epDel=ForumPropertiesManager.getString("epDel");
	epLogin=ForumPropertiesManager.getString("epLogin");
	
	cpReg=Integer.parseInt(ForumPropertiesManager.getString("cpReg"));
	cpAnnounce=ForumPropertiesManager.getString("cpAnnounce");
	cpReAnnounce=ForumPropertiesManager.getString("cpReannounce");
	cpDel=ForumPropertiesManager.getString("cpDel");
	cpLogin=ForumPropertiesManager.getString("cpLogin");
	
	topicNum=ForumPropertiesManager.getString("TopicNum");
	bbsNum=ForumPropertiesManager.getString("BbsNum");
	todayNum=ForumPropertiesManager.getString("TodayNum");
	userNum=ForumPropertiesManager.getString("UserNum");
	lastUser=ForumPropertiesManager.getString("lastUser");
	
	cookiePath=ForumPropertiesManager.getString("cookiepath");

	maxOnline=ForumPropertiesManager.getString("Maxonline");
	maxOnlineDate=ForumPropertiesManager.getString("MaxonlineDate");
	}
	catch(Exception e){
		//System.out.println(e.getMessage());
		throw new ServletException(e.getMessage());
	}

%>
<%


	String bodyFontColor="#000000";
	
	int bmFlag_1=1;
	int bmFlag_2=1;
	int bmFlag_3=1;
	int bmFlag_4=1;
	int bmFlag_5=1;
	
%>

<%	
  	String   NDate = Format.getDateTime();
	int	 forumID=ParamUtil.getInt(request,"forumID",0);
	boolean	 forumMaster=false,master=false;
	String userName="";
	String userPassword="";
	String stats="";
	boolean guibin=false;
	int i=0;
	boolean foundUser=false;
	String lastLogin;
	String picOM="ao1.gif",picOB="ao.gif",picOV="gb(1).gif",picOH="messages1.gif",picOU="messages2.gif";
%>