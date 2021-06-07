
<%
	try{
		Vector gateWayVector=GateWayFactory.getGateWays();
		for( i=0;i<gateWayVector.size();i++)
		{
    			GateWay gateWay=(GateWay)gateWayVector.get(i);
    			int gateWayID=gateWay.getGateWayID();
    			String gateWayName=gateWay.getGateWayName();
				out.println("<option style=BACKGROUND-COLOR:#99ccff>©ï "+gateWayName+"</option>");
				try{
					Vector forumVector=ForumFactory.getForums(gateWayID);
					for(int j=0;j<forumVector.size();j++){
						Forum theListForum=(Forum)forumVector.get(j);
						
						out.println("<option");
						if(forumID==theListForum.getForumID())
							out.println("selected");
							out.println("value=\""+theListForum.getForumID()+"\">¡¡©À"+theListForum.getForumType()+"</option>");
					}
				}
				catch(Exception e){
					e.printStackTrace();
				}
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	%>
