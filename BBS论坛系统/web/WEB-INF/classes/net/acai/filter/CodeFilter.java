package net.acai.filter;
import java.util.regex.*;

/**
 * Title:        清清网络
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.qingqing.com
 * @author:       qingqing
 * @version 1.0
 */

public class CodeFilter extends filter {

  public CodeFilter(String s) {
    super(s);
  }
  public CodeFilter() {

  }
  public String convertString(){
    return codeConverter();
  }
  public String codeConverter(){
		Pattern p;
		Matcher m;
		String codeBgcolor="red";
		StringBuffer sb;
		boolean result;
		String reg="(\\[code\\])(.[^\\[]*)(\\[\\/code\\])";
        p = Pattern.compile(
            reg,
            Pattern.CASE_INSENSITIVE);
        m = p.matcher(s);
        sb = new StringBuffer();
        result = m.find();
        while(result) {
            m.appendReplacement(sb,"<table width='100%' border='0' cellspacing='0' cellpadding='6' bgcolor='"+codeBgcolor+"'><td><b>以下内容为程序代码:</b><br>"+m.group(2)+"</td></table>");
            result = m.find();
        }
        m.appendTail(sb);
		return sb.toString();
	}
}