package net.acai.util;
/**
 * Title:        ????????
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */
import net.acai.util.*;
import java.text.SimpleDateFormat;
import java.text.*;
import java.util.Date;

/**
 * Title:        ????????
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      211.68.39.120??webcpu.51.net
 * @author SuperSpace
 * @version 1.0
 */

public class Format {

    public static String getDateTime()
    {
    	SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	java.util.Date Now=new java.util.Date();
    	String NDate=formatter.format(Now);
    	return NDate;
    }
    public static String getStrDate(String DateString){
    	return DateString.substring(0,10);
    }

    	
    public static String getStrDateTime(){
    	return StringUtils.replace(StringUtils.replace(StringUtils.replace(getDateTime(),":",""),"-","")," ","");
    	}
    public static boolean compareTo(String  last,String now){
    	try{
    	   	DateFormat formatter=DateFormat.getDateInstance();
    		Date temp1=formatter.parse(last);
    		Date temp2=formatter.parse(now);
    		if(temp1.after(temp2))
    			return false;
    		else if(temp1.before(temp2))
    			return true;
    	}
    	catch(ParseException e)
    	{
    		e.printStackTrace();
    	}
    	return false;
    }

    /**
     * ?ַ????滻???? source ?е? oldString ȫ?????? newString
     *
     * @param source Դ?ַ???
     * @param oldString ?ϵ??ַ???
     * @param newString ?µ??ַ???
     * @return ?滻?????ַ???
     */
    public static String Replace(String source, String oldString, String newString) {
        StringBuffer output = new StringBuffer();

        int lengthOfSource = source.length();   // Դ?ַ???????
        int lengthOfOld = oldString.length();   // ???ַ???????

        int posStart = 0;   // ??ʼ????λ??
        int pos;            // ?????????ַ?????λ??

        while ((pos = source.indexOf(oldString, posStart)) >= 0) {
            output.append(source.substring(posStart, pos));

            output.append(newString);
            posStart = pos + lengthOfOld;
        }

        if (posStart < lengthOfSource) {
            output.append(source.substring(posStart));
        }

        return output.toString();
    }

    /*
    public static String ReplaceIgnoreCase(String source, String oldString, String newString) {
    }
    */

    /**
     * ???ַ?????ʽ???? HTML ????????
     * ֻת???????ַ????ʺ??? HTML ?еı???????
     *
     * @param str Ҫ??ʽ?????ַ???
     * @return ??ʽ???????ַ???
     */
    public static String toHtmlInput(String str) {
        if (str == null)    return null;

        String html = new String(str);

        html = Replace(html, "&", "&amp;");
        html = Replace(html, "<", "&lt;");
        html = Replace(html, ">", "&gt;");

        return html;
    }

    /**
     * ???ַ?????ʽ???? HTML ????????
     * ????ͨ?????ַ??⣬???Կո????Ʊ????ͻ??н???ת????
     * ?Խ????ݸ?ʽ????????
     * ?ʺ??? HTML ?е???ʾ????
     *
     * @param str Ҫ??ʽ?????ַ???
     * @return ??ʽ???????ַ???
     */
    public static String toHtml(String str) {
        if (str == null)    return null;

        String html = new String(str);

        html = toHtmlInput(html);
        html = Replace(html, "\r\n", "\n");
        html = Replace(html, "\n", "<br>\n");
        html = Replace(html, "\t", "    ");
        html = Replace(html, "  ", " &nbsp;");

        return html;
    }

    /**
     * ????ͨ?ַ?????ʽ???????ݿ??Ͽɵ??ַ?????ʽ
     *
     * @param str Ҫ??ʽ?????ַ???
     * @return ?Ϸ??????ݿ??ַ???
     */
    public static String toSql(String str) {
        String sql = new String(str);
        return Replace(sql, "'", "''");
    }

    /*
    public static void main(String[] args) {
        String s = "<html>    ddd";
        Format f = new Format();
                    }
    */
}