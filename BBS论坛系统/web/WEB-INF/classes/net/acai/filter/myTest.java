package net.acai.filter;
import java.util.regex.*;

public class myTest {
    public static void main(String[] args) throws Exception {
        String s = "url test of ubbtag like [url]nic.biti.edu.cn[/url]"+
            " and [URL]http://mail.biti.edu.cn[/URL] and so on use regex";
        Pattern p = Pattern.compile(
            "(\\[(URL)\\])(((http://)|(https://))?)([^\\[]*)(\\[(\\/URL)\\])",
            Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(s);
        StringBuffer sb = new StringBuffer();
        boolean result = m.find();
        while(result) {
			for(int i=0;i<m.groupCount();i++)
				System.out.println(i+" "+m.group(i));
            m.appendReplacement(sb,"<a href=\"");
            if("".equals(m.group(4)))
                sb.append("http://"+m.group(8)+"\">"+m.group(8)+"</a>");
            else
                sb.append(m.group(4)+m.group(8)+"\">"+m.group(4)+m.group(8)+"</a>");
            result = m.find();
        }
        m.appendTail(sb);
        System.out.println(sb.toString());
    }
}