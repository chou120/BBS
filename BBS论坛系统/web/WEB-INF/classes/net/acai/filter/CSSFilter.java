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

public class CSSFilter extends filter {

  public CSSFilter(String s) {
    super(s);
  }
  public CSSFilter() {

  }
  public String convertString(){
    return this.getTextFilter();
  }
  public String getTextFilter(){
    String tempString=s;
    for(int i=0;i<4;i++)
      tempString=CSSConverter(tempString);
    return tempString;
  }
  public String CSSConverter(String s){
            Pattern p;
            Matcher m;
            StringBuffer sb;
            boolean result;
            String reg="(\\[QUOTE\\])(.*)(\\[\\/QUOTE\\])|"+
              "(\\[move\\])(.*)(\\[\\/move\\])|"+
              "\\[(GLOW)=*([0-9]*),*(#*[a-z0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/GLOW]|"+
              "\\[(SHADOW)=*([0-9]*),*(#*[a-z0-9]*),*([0-9]*)\\](.[^\\[]*)\\[\\/SHADOW]";
    p = Pattern.compile(reg,
        Pattern.CASE_INSENSITIVE);
    m = p.matcher(s);
    sb = new StringBuffer();
    result = m.find();
    while(result&&m.group(0)!=null) {
      if(m.group(1)!=null)
              m.appendReplacement(sb,"<table cellpadding=0 cellspacing=0 border=0 WIDTH=94% bgcolor=#000000 align=center><tr><td><table width=100% cellpadding=5 cellspacing=1 border=0><TR><TD BGCOLOR='#cccccc'>"+m.group(2)+"</table></table><br>");
      else if(m.group(4)!=null)
              m.appendReplacement(sb,"<MARQUEE scrollamount=3>"+m.group(5)+"</marquee>");
      else if(m.group(7)!=null)
              m.appendReplacement(sb,"<table width="+m.group(8)+" style=\"filter:glow(color="+m.group(9)+", strength="+m.group(10)+")\">"+m.group(11)+"</table>");
      else if(m.group(12)!=null)
              m.appendReplacement(sb,"<table width="+m.group(13)+" style=\"filter:shadow(color="+m.group(14)+", strength="+m.group(15)+")\">"+m.group(16)+"</table>");
      result = m.find();
    }
    m.appendTail(sb);
    return sb.toString();
  }
}