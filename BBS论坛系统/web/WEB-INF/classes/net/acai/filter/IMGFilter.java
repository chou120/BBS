package net.acai.filter;


import java.util.regex.*;

/**
 * Title:        清清网络
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */

public class IMGFilter extends filter  {
  public IMGFilter(String s) {
    super(s);
  }
  public IMGFilter(){}

  public String  convertString(){

    return this.IMGConverter();
  }
  public String IMGConverter(){
        Pattern p = Pattern.compile(
            "(\\[IMG\\])(.[^\\[]*)(\\[\\/IMG\\])",
            Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(s);
        StringBuffer sb = new StringBuffer();
        //boolean result = m.find();
        while((m.find())) {
            m.appendReplacement(sb,"<IMG SRC=\""+m.group(2)+"\" border=0 alt=按此在新窗口浏览图片 onload=\"javascript:if(this.width>screen.width-333)this.width=screen.width-333;\">");
        }
        m.appendTail(sb);
        return sb.toString();
    }
}