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

public class ColorFilter extends filter {

  public ColorFilter(String s) {
    super(s);
  }
  public ColorFilter() {

  }
  public String convertString(){
    return colorConverter();
  }
  public String colorConverter(){
		Pattern p;
		Matcher m;
		StringBuffer sb;
		boolean result;
		String reg="(\\[color=(.[^\\[]*)\\])(.[^\\[]*)(\\[\\/color\\])";
        p = Pattern.compile(
            reg,
            Pattern.CASE_INSENSITIVE);
        m = p.matcher(s);
        sb = new StringBuffer();
        result = m.find();
        while(result) {
            m.appendReplacement(sb,"<font color="+m.group(2)+">"+m.group(3)+"</font>");
            result = m.find();
        }
        m.appendTail(sb);
		return sb.toString();
	}
}