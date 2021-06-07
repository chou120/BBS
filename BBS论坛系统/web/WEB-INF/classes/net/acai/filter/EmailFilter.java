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

public class EmailFilter extends filter {

  public EmailFilter() {
  }
  public EmailFilter(String s) {
    super(s);
  }
  public String convertString(){
    return emailConverter();
  }
  public String emailConverter(){
		Pattern p;
		Matcher m;
		StringBuffer sb;
		boolean result;
		String reg="\\[email=(.[^\\[]*)\\](.[^\\[]*)(\\[\\/email\\])"+
                  "|\\[email\\](.[^\\[]*)(\\[\\/email\\])";
        p = Pattern.compile(
            reg,
            Pattern.CASE_INSENSITIVE);
        m = p.matcher(s);
        sb = new StringBuffer();
        result = m.find();
        while(result&&m.group(0)!=null) {
          if(m.group(1)!=null)
            m.appendReplacement(sb,"<a href=\"mailto:"+m.group(1)+"\">"+m.group(2)+"</font>");
          else if(m.group(4)!=null)
            m.appendReplacement(sb,"<a href=\"mailto:"+m.group(4)+"\">"+m.group(4)+"</font>");

            result = m.find();
        }
        m.appendTail(sb);
		return sb.toString();
	}

}