package net.acai.forum;
/**
 * Title:        ????????
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */

public class OLUser{

	int userID;
	String userName,userClass,stats,userIP,startTime,lastTimeBK;
	String lastTime,browser,actForIP,comeFrom,actCome;
	public void setUserID(int usreID){
		this.userID=userID;
	}
	public int getUserID(){
		return this.userID;
	}
	public void setUserName(String userName){
		this.userName=userName;
	}
	public String getUserName(){
		return this.userName;
	}
	public void setUserClass(String userClass){
		this.userClass=userClass;
	}
	public String getUserClass(){
		return this.userClass;
	}
	public void setStats(String stats) throws Exception{
		this.stats=stats;
	}
	public String getStats(){
		return this.stats;
	}
	public void setUserIP(String userIP){
		this.userIP=userIP;
	}
	public String getUserIP(){
		return this.userIP;
	}
	public void setStartTime(String startTime){
		this.startTime=startTime;
	}
	public String getStartTime(){
		return this.startTime;
	}
	public void setLastTimeBK(String lastTimeBK){
		this.lastTimeBK=lastTimeBK;
	}
	public String getLastTimeBK(){
		return this.lastTimeBK;
	}
	public void setLastTime(String lastTime){
		this.lastTime=lastTime;
	}
	public String getLastTime(){
		return this.lastTime;
	}
	public void setBrowser(String browser){
		this.browser=browser;
	}
	public String getBrowser(){
		return this.browser;
	}
	public void setActForIP(String actForIP){
		this.actForIP=actForIP;
	}
	public String getActForIP(){
		return this.actForIP;
	}
	public void setComeFrom(String comeFrom){
		this.comeFrom=comeFrom;
	}
	public String getComeFrom(){
		return this.comeFrom;
	}
	public void setActCome(String actCome){
		this.actCome=actCome;
	}
	public String getActCome(){
		return this.actCome;
	}
	public String getUserSystem(){
		return getUserSystem(this.browser);
	}
	public String getUserBrowser(){
		return getUserBrowser(this.browser);

	}
	public static String getUserSystem(String browser){
		String system="";
		if (browser.indexOf("NT 5.1")>=0)
			system=system+"????ϵͳ??Windows XP";
		else if (browser.indexOf("Tel")>=0)
			system=system+"????ϵͳ??Telport";
		else if (browser.indexOf("webzip")>=0)
			system=system+"????ϵͳ??webzip";
		else if (browser.indexOf("flashget")>=0)
			system=system+"????ϵͳ??flashget";
		else if (browser.indexOf("offline")>=0)
			system=system+"????ϵͳ??offline";
		else if (browser.indexOf("NT 5")>=0)
			system=system+"????ϵͳ??Windows 2000";
		else if (browser.indexOf("NT 4")>=0)
			system=system+"????ϵͳ??Windows NT4";
		else if (browser.indexOf("98")>=0)
			system=system+"????ϵͳ??Windows 98";
		else if (browser.indexOf("95")>=0)
			system=system+"????ϵͳ??Windows 95";
		else
			system=system+"????ϵͳ??δ֪";
	   return system;
	}
	public static String getUserBrowser(String browser){
		String userBrowser;
		if (browser.indexOf("NetCaptor 6.5.0")>=0)
			userBrowser="?? ?? ????NetCaptor 6.5.0";
		else if (browser.indexOf("MyIe 3.1")>=0)
			userBrowser="?? ?? ????MyIe 3.1";
		else if (browser.indexOf("NetCaptor 6.5.0RC1")>=0)
			userBrowser="?? ?? ????NetCaptor 6.5.0RC1";
		else if (browser.indexOf("NetCaptor 6.5.PB1")>=0)
			userBrowser="?? ?? ????NetCaptor 6.5.PB1";
		else if (browser.indexOf("MSIE 5.5")>=0)
			userBrowser="?? ?? ????Internet Explorer 5.5";
		else if (browser.indexOf("MSIE 6.0")>=0)
			userBrowser="?? ?? ????Internet Explorer 6.0";
		else if (browser.indexOf("MSIE 6.0b")>=0)
			userBrowser="?? ?? ????Internet Explorer 6.0b";
		else if (browser.indexOf("MSIE 5.01")>=0)
			userBrowser="?? ?? ????Internet Explorer 5.01";
		else if (browser.indexOf("MSIE 5.0")>=0)
			userBrowser="?? ?? ????Internet Explorer 5.00";
		else if (browser.indexOf("MSIE 4.0")>=0)
			userBrowser="?? ?? ????Internet Explorer 4.01";
		else
			userBrowser="?? ?? ????δ֪";
		return userBrowser;

	}
}

