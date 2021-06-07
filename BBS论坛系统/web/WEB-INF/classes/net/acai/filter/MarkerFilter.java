package net.acai.filter;


import java.util.*;

public class MarkerFilter {

    private boolean 	filteringSubject;
    private boolean 	filteringBody;
	private HashMap		colors;
	private String[]	colorList;
	private String		defaultColor;

   /**
    * Creates a new filter not associated with a message. This is
    * generally only useful for defining a template filter that other
    * filters will be cloned from.
    */
    public MarkerFilter() {
        filteringSubject = false;
        filteringBody = true;

        colors = new HashMap(12);
        colors.put("yellow", "#ffffaa");
        colors.put("orange", "#ffaa88");
        colors.put("purple", "#ffaaff");
        colors.put("cyan", "#aaffff");
        colors.put("red", "#ff8888");
        colors.put("green", "#88ffaa");
        colors.put("blue", "#88aaff");
        colors.put("gray", "#cccccc");

		colorList = (String[])colors.values().toArray(new String[colors.size()]);
        defaultColor = "#ffffaa";
    }

    /**
     * This method takes a string which may contain [img path] or [img=path] tags
     * and replaces them with working image links. It does this
     * by adding the html tag &lt;img src="path"&gt;.
     * <p>
     * It also replaces a list of predefined strings with image links.
     * These can for instance show smiley's instead of the :), :-( ascii.
     *
     * @param input the text to be converted.
     * @return the input string with the URLs replaced with links.
     */
    public String hiliteText(String input) {
        // Check if the string is null or zero length
        //  -- if so, return what was sent in.
        if (input == null || input.length() == 0 ) {
            return input;
        }

		// Build the response in a buffer
        StringBuffer buf = new StringBuffer(input.length() + 100);
        char[] chars = input.toCharArray();
        String color = null;
        
        int index = -1, i = 0;
        int n, m;
        int patStart, patEnd;
        int colStart;
        int oldend = 0;
        int len = input.length();
        char cur;

		// handle the [img] pattern and the predefined strings replacements
        while (++index < len) {
        	cur = chars[i = index];

        	if (index + 6 < len &&
        		cur == '[' && chars[++i] == 'm' && chars[++i] == 'a' && chars[++i] == 'r' &&chars[++i] == 'k') {

				// strip spaces
				while (++i < len && (chars[i] == ' ' || chars[i] == '='))
					;
				if (i < len) {
					// find the end of the tag
					colStart = i--;
					while (++i < len && chars[i] != ']')
						;

					if (colStart < i) {
						String arg = new String(chars, colStart, i-colStart);
						color = (String)colors.get(arg);

						if (color == null && "random".equals(arg)) {
							color = colorList[(int)(Math.random() * colorList.length)];
						}
					}
					if (color == null)
						color = defaultColor;

					if (++i < len) {
						patStart = patEnd = i;

				        while (++patEnd < len) {
				        	if (patEnd + 6 < len &&
				        		chars[i = patEnd] == '[' && chars[++i] == '/' && chars[++i] == 'm' && chars[++i] == 'a' &&
				        		chars[++i] == 'r' && chars[++i] == 'k' && chars[++i] == ']') {
				        		break;
				        	}
				        }
						
				        buf.append(chars, oldend, index-oldend);
				        buf.append("<B style=\"background-color:").append(color).append("\">");
				        buf.append(chars, patStart, patEnd-patStart);
				        buf.append("</B>");

						oldend = (patEnd > i) ? patEnd : i + 1;
					}
				}
		        index = i;
        	}
        }
        if (oldend < len) {
	        buf.append(chars, oldend, len-oldend);
        }
        return buf.toString();
    }
		public static void main(String args[]){
		try{
		MarkerFilter filter=new MarkerFilter();
		String test="[mark red]asdf[/mark]";
		
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}
