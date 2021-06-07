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

public class URLFilter extends filter {

  public URLFilter(String s) {
    super(s);
  }
  public URLFilter() {

  }
  public String convertString(){
    return this.URLConverter();
  }
  public String URLConverter(){

 	Pattern p = Pattern.compile("(\\[(URL)((=(((http://)|(ftp://))?)([^\\[]*))?)\\])((((http://)|(ftp://))?)([^\\[]*))(\\[(\\/URL)\\])",
            Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(s);
        StringBuffer sb = new StringBuffer();
        boolean result = m.find();
        while(result) {
  			 m.appendReplacement(sb,"<a href=\"");
            if(!"".equals(m.group(3))){
				if("".equals(m.group(5)))
					if(m.group(10)==null)
						sb.append("http://"+m.group(9)+"\">"+m.group(9)+"</a>");
					else
						sb.append("http://"+m.group(9)+"\">"+m.group(10)+"</a>");
				else
					if(m.group(10)==null)
						sb.append(m.group(5)+m.group(9)+"\">"+m.group(5)+m.group(9)+"</a>");
					else
						sb.append(m.group(5)+m.group(9)+"\">"+m.group(10)+"</a>");
			}
			else{
				if("".equals(m.group(11)))
						sb.append("http://"+m.group(10)+"\">"+m.group(10)+"</a>");
				else
						sb.append(m.group(10)+"\">"+m.group(10)+"</a>");
			}
			 result = m.find();
        }
        m.appendTail(sb);

        return sb.toString();


  }
}
