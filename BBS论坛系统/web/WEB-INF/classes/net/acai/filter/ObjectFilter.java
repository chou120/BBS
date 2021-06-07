package net.acai.filter;
import java.util.regex.*;

/**
 * Title:        ÇåÇåÍøÂç
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */

public class ObjectFilter extends filter {

  public ObjectFilter(String s) {
    super(s);
  }
  public ObjectFilter() {

  }
  public String convertString(){
    return this.RMConverter(this.DIRConverter(this.MPConverter(this.QTConverter(s))));
  }
  private String RMConverter(String s){
		Pattern p;
		Matcher m;
		StringBuffer sb;
		boolean result;
		String reg="\\[RM=([0-9]*),([0-9]*)\\]([^\\[]*)\\[\\/RM]";
        p = Pattern.compile(
            reg,
            Pattern.CASE_INSENSITIVE);
        m = p.matcher(s);
        sb = new StringBuffer();
        result = m.find();
        while(result) {
            m.appendReplacement(sb,"<OBJECT classid=clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA class=OBJECT id=RAOCX width="+m.group(1)+" height="+m.group(2)+"><PARAM NAME=SRC VALUE="+m.group(3)+"><PARAM NAME=CONSOLE VALUE=Clip1><PARAM NAME=CONTROLS VALUE=imagewindow><PARAM NAME=AUTOSTART VALUE=true></OBJECT><br><OBJECT classid=CLSID:CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA height=32 id=video2 width="+m.group(1)+"><PARAM NAME=SRC VALUE="+m.group(3)+"><PARAM NAME=AUTOSTART VALUE=-1><PARAM NAME=CONTROLS VALUE=controlpanel><PARAM NAME=CONSOLE VALUE=Clip1></OBJECT>");
            result = m.find();
        }
        m.appendTail(sb);
		return sb.toString();
	}
	private String MPConverter(String s){
		Pattern p;
		Matcher m;
		StringBuffer sb;
		boolean result;
		String reg="\\[MP=*([0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/MP]";
        p = Pattern.compile(
            reg,
            Pattern.CASE_INSENSITIVE);
        m = p.matcher(s);
        sb = new StringBuffer();
        result = m.find();
        while(result) {
           m.appendReplacement(sb,"<object align=middle classid=CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95 class=OBJECT id=MediaPlayer width="+m.group(1)+" height="+m.group(2)+" ><param name=ShowStatusBar value=-1><param name=Filename value="+m.group(3)+"><embed type=application/x-oleobject codebase=http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701 flename=mp src="+m.group(3)+"  width="+m.group(1)+" height="+m.group(2)+"></embed></object>");
            result = m.find();
        }
        m.appendTail(sb);
		return sb.toString();
	}
	private String QTConverter(String s){
		Pattern p;
		Matcher m;
		StringBuffer sb;
		boolean result;
		String reg="\\[QT=*([0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/QT]";
        p = Pattern.compile(
            reg,
            Pattern.CASE_INSENSITIVE);
        m = p.matcher(s);
        sb = new StringBuffer();
        result = m.find();
        while(result) {
            m.appendReplacement(sb,"<embed src="+m.group(3)+" width="+m.group(1)+" height="+m.group(2)+" autoplay=true loop=false controller=true playeveryframe=false cache=false scale=TOFIT bgcolor=#000000 kioskmode=false targetcache=false pluginspage=http://www.apple.com/quicktime/>");
            result = m.find();
        }
        m.appendTail(sb);
		return sb.toString();
	}
	private String DIRConverter(String s){
		Pattern p;
		Matcher m;
		StringBuffer sb;
		boolean result;
		String reg="\\[DIR=*([0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/DIR]";
        p = Pattern.compile(
            reg,
            Pattern.CASE_INSENSITIVE);
        m = p.matcher(s);
        sb = new StringBuffer();
        result = m.find();
        while(result) {
            m.appendReplacement(sb,"<object classid=clsid:166B1BCA-3F9C-11CF-8075-444553540000 codebase=http://download.macromedia.com/pub/shockwave/cabs/director/sw.cab#version=7,0,2,0 width="+m.group(1)+" height="+m.group(2)+"><param name=src value="+m.group(3)+"><embed src="+m.group(3)+" pluginspage=http://www.macromedia.com/shockwave/download/ width="+m.group(1)+" height="+m.group(2)+"></embed></object>");
            result = m.find();
        }
        m.appendTail(sb);
		return sb.toString();
	}

}