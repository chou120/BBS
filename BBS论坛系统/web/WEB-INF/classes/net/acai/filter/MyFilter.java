package net.acai.filter;
import net.acai.filter.*;

/**
 * Title:        清清网络
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */

public class MyFilter {
  String s="";
  String outString="";
  public MyFilter(String s) {
    this.s=s;
    outString=s;
  }
  public String getFilterString(){
    return convertString();
  }
  public String convertString(){
    String [] filterClass={"IMGFilter","URLFilter","EmailFilter","FlashFilter","ObjectFilter",
            "CodeFilter","ColorFilter","CSSFilter","TextStyleFilter","FontFilter","AutoFilter"};
    UBBFilter m;
    for(int i=0;i<filterClass.length;i++){
        try{
            m=(UBBFilter)Class.forName("net.acai.filter."+filterClass[i]).newInstance();
            m.setInputString(outString);
            outString=m.getFilterString();
        }
        catch(Exception e){
          e.printStackTrace();
          }

    }
    return outString;
  }
  public static void main(String args[]){
    String s="[color=1234][align=right]asdfasdf[/align][/color][align=right]<font color=#000066>[此贴子已经被asdf于2002-05-30 17:43:01编辑过]</font>[/align]";
    MyFilter myFilter=new MyFilter(s);
    System.out.println(myFilter.getFilterString());
  }
}