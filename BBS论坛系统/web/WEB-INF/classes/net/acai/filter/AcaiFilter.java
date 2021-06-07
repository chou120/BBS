package net.acai.filter;

/**
 * Title:        清清网络
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:     http://xqingqing.yeah.net
 * @author 	qingqing
 * @version 1.0
 */
import net.acai.codeviewer.*;
import net.acai.util.*;
import java.io.*;

public class AcaiFilter{
   boolean newWindowEnabled=true;
   private static final String NEW_LINE = System.getProperty("line.separator");

    private String commentStart;
    private String commentEnd;
    private String stringStart;
    private String stringEnd;
    private String reservedWordStart;
    private String reservedWordEnd;
    
    
    private CodeViewer viewer;
    
    
   public AcaiFilter(){
   	viewer = new CodeViewer();
        commentStart = viewer.getCommentStart();
        commentEnd = viewer.getCommentEnd();
        stringStart = viewer.getStringStart();
        stringEnd = viewer.getStringEnd();
        reservedWordStart = viewer.getReservedWordStart();
        reservedWordEnd = viewer.getReservedWordEnd();
	}
   public  String convertURL(String input) {
        // 检查字符串是否为空,如果为空,则返回
        // 送进一些什么?
        if (input == null || input.length() == 0) {
            return input;
        }
        else {
            StringBuffer buf = new StringBuffer(input.length() + 25);
            char[] chars = input.toCharArray();

            int i = 0, j = 0, oldend = 0;
            int len = input.length();
            char cur;

            // 搜索字符串中含有的http://
            while ( ( i=input.indexOf("http://", oldend) ) >= 0 ) {
                j=i+7;
                cur = chars[j];
                while (j < len) {
                    // 空格
                    if (cur == ' ') break;
                    // html
                    if (cur == '<') break;
                    // 换行
                    if (cur == '\n') break;
                    // Unix的换行
                    if (cur == '\r' && j<len-1 && chars[j+1] == '\n') break;

                    j++;
                    if (j<len) {
                        cur = chars[j];
                    }
                }
                // 检查终结字符'.'或者 ','
                // 移出.
                if (chars[j-1] == '.' || chars[j-1] == ',' || chars[j-1] == ')')
                {
                    j--;
                }
                buf.append(chars, oldend, i-oldend);
                buf.append("<a href=\"");
                buf.append(chars, i, j-i);
                buf.append("\"");
                if (newWindowEnabled) {
                    buf.append(" target=\"_blank\">");
                }
                else {
                    buf.append(">");
                }
                buf.append(chars, i, j-i);
                buf.append("</a>");
                oldend = j;
            }
            buf.append(chars, j, len-j);
            return buf.toString();
        }
    }
    public String highlightCode(String input) {
        if (input == null || input.length() == 0) {
            return input;
        }
        else {
            StringBuffer buf = new StringBuffer(input.length()+50);
            int i = 0, j = 0, oldend = 0;
	    while ((i=input.indexOf("[code]", oldend)) >= 0) {
                //
                if ((j=input.indexOf("[/code]", i+6)) < 0)  {
                    //
                    j = input.length()-7;
                }
				
                // 
                
     
		
                buf.append(StringUtils.escapeHTMLTags(input.substring(oldend,i)));
                buf.append("<table width=\"550\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" bordercolorlight = \"black\" bordercolordark = \"#FFFFFF\" align=\"center\">");
	    	buf.append("<tr>");
    	    	buf.append("<td bgcolor=\"#e6e6e6\" class=\"code\">");
            
                //buf.append("<pre>");
                //

                StringBuffer codeBuf = new StringBuffer(input.length()/2);

                //
                // i
                if (i+6+1 < input.length() && (input.charAt(i+6+1) == '\n')) {
                    i++;
                    if (i+6+1 < input.length() && (input.charAt(i+6+1) == '\r')) {
                        i++;
                    }
                }
		buf.append(StringUtils.escapeHTMLTags(input.substring(i+6, j)));
               /* BufferedReader reader = new BufferedReader(new StringReader(input.substring(i+6, j)));
                String line;
                try {
                    while ((line = reader.readLine()) != null) {
                        // u
                        line = StringUtils.replace(line, "&lt;", "<");
                        line = StringUtils.replace(line, "&gt;", ">");
                        codeBuf.append(viewer.syntaxHighlight(line));
                        codeBuf.append(NEW_LINE);
                    }
                }
                catch (IOException ioe) {
                    ioe.printStackTrace();
                }
                String code = codeBuf.toString();
                // 
                code = StringUtils.replace(code, "[", "&#91;");
                code = StringUtils.replace(code, "]", "&#93;");
		*/
                //buf.append(code);
                //buf.append("</pre>");
                buf.append("</td>");
  		buf.append("</tr>");
		buf.append("</table>");
                // 
                oldend = j+7;
            }
            buf.append(StringUtils.escapeHTMLTags(input.substring(oldend,input.length())));
            
            return StringUtils.convertNewlines(buf.toString());
        }
    }
    public static void main(String args[]){
		
	}

}	