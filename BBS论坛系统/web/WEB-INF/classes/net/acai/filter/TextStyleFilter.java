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

public class TextStyleFilter extends filter {

  public TextStyleFilter(String s) {
    super(s);
  }
  public TextStyleFilter() {
  }
  public String convertString(){
    return this.getTextFilter();
  }
  public String getTextFilter(){
    String tempString=s;
    for(int i=0;i<5;i++){
      tempString=textStyleConverter(tempString);
      //System.out.println(tempString);
    }
    return tempString;
  }
  public String textStyleConverter(String s){
		Pattern p;
		Matcher m;
		StringBuffer sb;
		boolean result;
        p = Pattern.compile(
            "\\[(b)\\](.[^\\[]*)\\[\\/(b)\\]|"+
            "\\[(i)\\](.[^\\[]*)\\[\\/(i)\\]|"+
            "\\[(u)\\](.[^\\[]*)\\[\\/(u)\\]|"+
            "\\[(fly)\\](.[^\\[]*)\\[\\/(fly)\\]|"+
            "\\[(center)\\](.[^\\[]*)\\[\\/(center)\\]",
            Pattern.CASE_INSENSITIVE);
        m = p.matcher(s);
        sb = new StringBuffer();
        result = m.find();
        while(result&&m.group(0)!=null) {
          if(m.group(1)!=null)
		  m.appendReplacement(sb,"<b>"+m.group(2)+"</b>");
          else if(m.group(4)!=null)
            m.appendReplacement(sb,"<i>"+m.group(5)+"</i>");
          else if(m.group(7)!=null)
            m.appendReplacement(sb,"<u>"+m.group(8)+"</u>");
          else if(m.group(10)!=null)
            m.appendReplacement(sb,"<center>"+m.group(11)+"</center>");
          result = m.find();
        }
        m.appendTail(sb);
		return sb.toString();
	}
}