<%
'***************************************************************************************************************************
'stream.asp
'used to play wmv files
'Modified by Jason Werwie
'3-18-2010
'***************************************************************************************************************************
%>
<!-- #include file="newer/global.asp" -->
<% 
    SQL = "Select * From AVNewsRelease Where ID = " & Request.QueryString("AVID")
    Set DB = Server.CreateObject( "ADODB.Connection" )
    DB.Open intranet_path
    set rsAVRelease = DB.execute(SQL)
    strFileName = "multimedia/" & rsAVRelease("FileName")
    strFileName2 = rsAVRelease("FileName")
    strHeadline = rsAVRelease("Headline")
    strCaption = rsAVRelease("Caption")
    intDisplayCode = rsAVRelease("displayCode")
    set rsAVRelease = nothing
    DB.close()

%>
<html>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="800" align="center">
	<tr>
		<td background="/newer/optimized/New-Top-Border-x.jpg" valign="top" align="left" width="1%" height="1%"><img border="0" src="/newer/optimized/New-Top-Left-x.jpg" width="36" height="32"></td>
		<td background="/newer/optimized/New-Top-Border-x.jpg" height="1%"><img src="/newer/images/layout/cthrupixel.gif" width="1" height="1"></td>
		<td rowspan="2" valign="top" align="left" height="1%" width="1%" background="/newer/optimized/New-Right-Border-x.jpg"><img border="0" src="newer/optimized/New-Top-Right-x.jpg" width="36" height="32"></td>
	</tr>
	<tr>
		<td background="/newer/optimized/New-Left-Border-x.jpg" width="1%"><img src="/newer/images/layout/cthrupixel.gif" width="1" height="1"></td>
		<td width="98%" align="center" valign="top"><font face="verdana,arial,helvetica,sans serif" size="3" color="#000000"></font><BR>
            <table border=0 cellpadding=0 cellspacing=5 align="center">
                <tr><td align="center" style="font-family:Arial; font-size:16pt"><b><u><%response.Write(strHeadline & "<br/><br/>")%></u></b></td></tr>
                <tr><td align="center">
                    <object id="MediaPlayer" width=400 Height=300
                        classid="clsid:22d6f312-b0f6-11d0-94ab-0080c74c7e95F"
                        codebase="http://www.microsoft.com/windows/windowsmedia/default.aspx"
                        standby="Loading Media Player"
                        Type="application/x-mplayer2">
                        <param name="Filename" value='<%=strFileName %>'>
                        <embed type="application/x-mplayer2" src='<%=strFileName %>' name="MediaPlayer" width=500 height=400></embed>
                    </object>
                </td></tr>
                <tr><td align="center" style="font-size:10pt; font-family:Arial"><br />
                    <%
                        if strCaption <> "" then
                            response.Write(strCaption & "<br/><br/>")
                        end if
                    %>
                </td></tr>
            </table>
	    </td>
	</tr>
	<tr>
		<td background="/newer/optimized/New-Bottom-Border-x.jpg" width="1%" height="1%" align="left" valign="top"><img border="0" src="/newer/optimized/New-Bottom-Left-x.jpg" width="36" height="32"></td>
		<td background="/newer/optimized/New-Bottom-Border-x.jpg" height="1%"><img src="/newer/images/layout/cthrupixel.gif" width="1" height="1"></td>
		<td width="1%" height="1%"><img border="0" src="/newer/optimized/New-Bottom-Right-x.jpg" width="36" height="32"></td>
	</tr>
</table>
</body>
</html>