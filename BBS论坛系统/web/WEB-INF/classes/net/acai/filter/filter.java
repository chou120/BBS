package net.acai.filter;


/**
 * Title:        ÇåÇåÍøÂç
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */

public class filter implements UBBFilter {
  String s="";
  String outString="";
  public filter(String s) {
    this.s=s;
  }
  public filter(){
  }
  public void setInputString(String s) {
    this.s=s;
  }
  public String getInputString() {
    return s;
  }
  public String getFilterString() {
    return convertString();
  }
  public String convertString(){
    return  "";
  }
}