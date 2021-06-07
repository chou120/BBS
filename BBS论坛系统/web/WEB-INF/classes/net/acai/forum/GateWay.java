package net.acai.forum;
/**
 * Title:        ÇåÇåÍøÂç
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */
//import net.acai.database.*;

public class GateWay{
	
	int gateWayID;
	String gateWayName;
	public GateWay(int gateWayID,String gateWayName){
		this.gateWayID=gateWayID;
		this.gateWayName=gateWayName;
	}
	public void setGateWayID(int gateWayID){
		this.gateWayID=gateWayID;
	}
	public int getGateWayID(){
		return this.gateWayID;
	}
	public String getGateWayName(){
		return this.gateWayName;
	}
}

	