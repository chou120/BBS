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

public class FontFilter extends filter {

  public FontFilter() {
  }
  public FontFilter(String s) {
    super(s);
  }
  public String convertString(){
    return this.getTextFilter();
  }
  public String getTextFilter(){
    String tempString=s;
    for(int i=0;i<4;i++){
      tempString=fontConverter(tempString);
     // System.out.println(tempString);
    }
    return tempString;
  }
  public String fontConverter(String s){
		Pattern p;
		Matcher m;
		StringBuffer sb;
		boolean result;
		String reg="\\[size=([1-4])\\](.[^\\[]*)(\\[\\/size\\])"+
                  "|\\[face=(.[^\\[]*)\\](.[^\\[]*)(\\[\\/face\\])"+
                  "|\\[align=(.[^\\[]*)\\](.[^\\[]*)(\\[\\/align\\])"+
                  "|\\[em([0-9]*)\\]";
        p = Pattern.compile(
            reg,
            Pattern.CASE_INSENSITIVE);
        m = p.matcher(s);
        sb = new StringBuffer();
        result = m.find();
        while(result&&m.group(0)!=null) {

          if(m.group(1)!=null)
            m.appendReplacement(sb,"<font size="+m.group(1)+">"+m.group(2)+"</font>");
          else if(m.group(4)!=null)
            m.appendReplacement(sb,"<font face="+m.group(4)+">"+m.group(5)+"</font>");
          else if(m.group(7)!=null)
            m.appendReplacement(sb,"<div align="+m.group(7)+">"+m.group(8)+"</div>");
          else if(m.group(10)!=null)
            m.appendReplacement(sb,"<img src=pic/em"+m.group(10)+".gif>");
            result = m.find();
        }
        m.appendTail(sb);
	return sb.toString();
  }
}