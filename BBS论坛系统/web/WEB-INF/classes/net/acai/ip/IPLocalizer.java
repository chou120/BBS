

package net.acai.ip;
/**
 * Title:        ÇåÇåÍøÂç
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package net.xdevelop.ip:
//            AddressTable0, AddressTable1, IPTable3, IPTable0, 
//            IPTable1, IPTable2

public class IPLocalizer
{

    private IPLocalizer()
    {
    }

    public static String[] search(String ip)
    {
        String address[] = {
            "", ""
        };
        if(!validateIP(ip))
            return address;
        int pos = inRegion(ip);
        if(pos != -1)
        {
            if(pos >= 0 && pos < 500)
            {
                address[0] = AddressTable0.ADDRESS_TABLE0_CH[pos][0];
                address[1] = AddressTable0.ADDRESS_TABLE0_CH[pos][1];
            }
            if(pos >= 500 && pos < 1000)
            {
                address[0] = AddressTable0.ADDRESS_TABLE1_CH[pos - 500][0];
                address[1] = AddressTable0.ADDRESS_TABLE1_CH[pos - 500][1];
            }
            if(pos >= 1000 && pos < 1500)
            {
                address[0] = AddressTable0.ADDRESS_TABLE2_CH[pos - 1000][0];
                address[1] = AddressTable0.ADDRESS_TABLE2_CH[pos - 1000][1];
            }
            if(pos >= 1500 && pos < 2000)
            {
                address[0] = AddressTable0.ADDRESS_TABLE3_CH[pos - 1500][0];
                address[1] = AddressTable0.ADDRESS_TABLE3_CH[pos - 1500][1];
            }
            if(pos >= 2000 && pos < 2500)
            {
                address[0] = AddressTable1.ADDRESS_TABLE4_CH[pos - 2000][0];
                address[1] = AddressTable1.ADDRESS_TABLE4_CH[pos - 2000][1];
            }
            if(pos >= 2500 && pos < 3000)
            {
                address[0] = AddressTable1.ADDRESS_TABLE5_CH[pos - 2500][0];
                address[1] = AddressTable1.ADDRESS_TABLE5_CH[pos - 2500][1];
            }
            if(pos >= 3000 && pos < 3500)
            {
                address[0] = AddressTable1.ADDRESS_TABLE6_CH[pos - 3000][0];
                address[1] = AddressTable1.ADDRESS_TABLE6_CH[pos - 3000][1];
            }
            if(pos >= 3500 && pos < 4000)
            {
                address[0] = AddressTable1.ADDRESS_TABLE7_CH[pos - 3500][0];
                address[1] = AddressTable1.ADDRESS_TABLE7_CH[pos - 3500][1];
            }
        }
        return address;
    }

    public static String[] search(HttpServletRequest request)
    {
        String ip = request.getRemoteAddr();
        String address[] = {
            "", ""
        };
        int pos = inRegion(ip);
        if(pos != -1)
        {
            if(pos >= 0 && pos < 500)
            {
                address[0] = AddressTable0.ADDRESS_TABLE0_CH[pos][0];
                address[1] = AddressTable0.ADDRESS_TABLE0_CH[pos][1];
            }
            if(pos >= 500 && pos < 1000)
            {
                address[0] = AddressTable0.ADDRESS_TABLE1_CH[pos - 500][0];
                address[1] = AddressTable0.ADDRESS_TABLE1_CH[pos - 500][1];
            }
            if(pos >= 1000 && pos < 1500)
            {
                address[0] = AddressTable0.ADDRESS_TABLE2_CH[pos - 1000][0];
                address[1] = AddressTable0.ADDRESS_TABLE2_CH[pos - 1000][1];
            }
            if(pos >= 1500 && pos < 2000)
            {
                address[0] = AddressTable0.ADDRESS_TABLE3_CH[pos - 1500][0];
                address[1] = AddressTable0.ADDRESS_TABLE3_CH[pos - 1500][1];
            }
            if(pos >= 2000 && pos < 2500)
            {
                address[0] = AddressTable1.ADDRESS_TABLE4_CH[pos - 2000][0];
                address[1] = AddressTable1.ADDRESS_TABLE4_CH[pos - 2000][1];
            }
            if(pos >= 2500 && pos < 3000)
            {
                address[0] = AddressTable1.ADDRESS_TABLE5_CH[pos - 2500][0];
                address[1] = AddressTable1.ADDRESS_TABLE5_CH[pos - 2500][1];
            }
            if(pos >= 3000 && pos < 3500)
            {
                address[0] = AddressTable1.ADDRESS_TABLE6_CH[pos - 3000][0];
                address[1] = AddressTable1.ADDRESS_TABLE6_CH[pos - 3000][1];
            }
            if(pos >= 3500 && pos < 4000)
            {
                address[0] = AddressTable1.ADDRESS_TABLE7_CH[pos - 3500][0];
                address[1] = AddressTable1.ADDRESS_TABLE7_CH[pos - 3500][1];
            }
        }
        return address;
    }

    private static boolean validateIP(String ip)
    {
        boolean flag;
        try
        {
            int from = 0;
            int end = ip.indexOf(".", from);
            if(end == -1)
            {
                boolean flag1 = false;
                return flag1;
            }
            int ip3 = Integer.parseInt(ip.substring(from, end));
            from = end + 1;
            end = ip.indexOf(".", from);
            if(end == -1)
            {
                boolean flag2 = false;
                return flag2;
            }
            int ip2 = Integer.parseInt(ip.substring(from, end));
            from = end + 1;
            end = ip.indexOf(".", from);
            if(end == -1)
            {
                boolean flag3 = false;
                return flag3;
            }
            int ip1 = Integer.parseInt(ip.substring(from, end));
            int ip0 = Integer.parseInt(ip.substring(end + 1));
            if(ip3 > 255 || ip2 > 255 || ip1 > 255 || ip0 > 255 || ip3 < 0 || ip2 < 0 || ip1 < 0 || ip0 < 0)
            {
                boolean flag4 = false;
                return flag4;
            } else
            {
                boolean flag5 = true;
                return flag5;
            }
        }
        catch(Exception e)
        {
            flag = false;
        }
        return flag;
    }

    private static int inRegion(String ip)
    {
        int pos = -1;
        int from = 0;
        int end = ip.indexOf(".", from);
        int ip3 = Integer.parseInt(ip.substring(from, end));
        from = end + 1;
        end = ip.indexOf(".", from);
        int ip2 = Integer.parseInt(ip.substring(from, end));
        from = end + 1;
        end = ip.indexOf(".", from);
        int ip1 = Integer.parseInt(ip.substring(from, end));
        int ip0 = Integer.parseInt(ip.substring(end + 1));
        long ipVisitor = (long)ip3 * (long)0x1000000 + (long)(ip2 * 0x10000) + (long)(ip1 * 256) + (long)ip0;
        for(int i = 0; i < IP_TABLE.length; i++)
        {
            ip3 = Integer.parseInt(IP_TABLE[i][0].substring(0, 3));
            ip2 = Integer.parseInt(IP_TABLE[i][0].substring(4, 7));
            ip1 = Integer.parseInt(IP_TABLE[i][0].substring(8, 11));
            ip0 = Integer.parseInt(IP_TABLE[i][0].substring(12, 15));
            long ipBegin = (long)ip3 * (long)0x1000000 + (long)(ip2 * 0x10000) + (long)(ip1 * 256) + (long)ip0;
            ip3 = Integer.parseInt(IP_TABLE[i][1].substring(0, 3));
            ip2 = Integer.parseInt(IP_TABLE[i][1].substring(4, 7));
            ip1 = Integer.parseInt(IP_TABLE[i][1].substring(8, 11));
            ip0 = Integer.parseInt(IP_TABLE[i][1].substring(12, 15));
            long ipEnd = (long)ip3 * (long)0x1000000 + (long)(ip2 * 0x10000) + (long)(ip1 * 256) + (long)ip0;
            if(ipVisitor >= ipBegin && ipVisitor <= ipEnd)
                pos = i;
        }

        return pos;
    }

    public static String IP_TABLE[][];

    static 
    {
        IP_TABLE = new String[3000 + IPTable3.IP_TABLE.length][2];
        for(int i = 0; i < IPTable0.IP_TABLE.length; i++)
        {
            IP_TABLE[i][0] = IPTable0.IP_TABLE[i][0];
            IP_TABLE[i][1] = IPTable0.IP_TABLE[i][1];
            IP_TABLE[1000 + i][0] = IPTable1.IP_TABLE[i][0];
            IP_TABLE[1000 + i][1] = IPTable1.IP_TABLE[i][1];
            IP_TABLE[2000 + i][0] = IPTable2.IP_TABLE[i][0];
            IP_TABLE[2000 + i][1] = IPTable2.IP_TABLE[i][1];
        }

        for(int i = 0; i < IPTable3.IP_TABLE.length; i++)
        {
            IP_TABLE[3000 + i][0] = IPTable3.IP_TABLE[i][0];
            IP_TABLE[3000 + i][1] = IPTable3.IP_TABLE[i][1];
        }

    }
}