<!-- #include file="global.asp" -->
<html>
	<head>
	<!-- #include file="Style.asp" -->
	</head>
	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td colspan="2" align="left" valign="top" height="113" background="<%=hostroot%>images/topbgmain.jpg">
			<!-- #include file="top.asp" --></td>
		</tr>
		<tr>
			<td align="left" valign="top" width="147" height="100%" background="<%=hostroot%>images/barbg.jpg">
			<!-- #include file="left.asp" --></td>
			<td bgcolor="#FFFFFF" width="100%" align="left" valign="top">
			<% 'intranetdatabase
			intCount = 0
			Set objConn = Server.CreateObject("ADODB.Connection")
			objConn.Open intranet_path

			Set rsRL=Server.CreateObject("ADODB.Recordset")
			SQL = "Select * From JobPostings Where PostToWeb = 'Y'	Order by PostingDate DESC"
			rsRL.Open SQL, objConn
			'RID = rsRL("AnnouncementNumber") %>
			<table width="750" colspan= "3" border="0">
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="Center" colspan="3"><font color="#cc0033" size="4">&nbsp;<b>PLEASE CAREFULLY READ AND FOLLOW ALL INSTRUCTIONS.<br><br></font>
					<hr><font face="verdana,arial,helvetica,sans serif" size="2" color="#000000"></td>
				</tr>
				<tr>
					<td width="750" rowspan="5" align="left" valign="top">
					<table border="0" cellpadding="0" cellspacing="0" width="750">
						<tr>
							<td background="optimized/New-Top-Border-x.jpg" valign="top" align="left" width="1%" height="1%"><img border="0" src="optimized/New-Top-Left-x.jpg" width="36" height="32"></td>
							<td background="optimized/New-Top-Border-x.jpg" height="1%" colspan="2" width="98%"><img src="/images/layout/cthrupixel.gif" width="1" height="1"></td>
							<td rowspan="2" valign="top" align="left" height="1%" width="1%" background="optimized/New-Right-Border-x.jpg"><img border="0" src="optimized/New-Top-Right-x.jpg" width="36" height="32"></td>
						</tr>
						<tr>
							<td background="optimized/New-Left-Border-x.jpg" width="1%"><img src="/images/layout/cthrupixel.gif" width="1" height="1"></td>
							<td width="98%" align="left" valign="top"><font face="verdana,arial,helvetica,sans serif" size="3" color="#000000"><b>Application Instructions</b>
								<hr><font face="verdana,arial,helvetica,sans serif" size="2" color="#000000">
								Everyone who applies for a position with Community Action, Inc. <b>must</b> submit a complete Hiring Packet which includes the following:<br><br>
								1. A Cover Letter indicating the posted position for which you are applying<br>
								2. A Resume<br>
								3. An Application for Employment<br>
								4. A signed Hiring Packet Information Acknowledgement Form<br><br>
								If all of the above documents are not received, your application will be considered <font color="#cc0033"><b>INCOMPLETE</b></font>.<br><br>
								<b>*Note: We do <u>NOT</u> notify you if you submit an incomplete Hiring Packet.</b><br><br>
								<font color="cc0033"><b>Unsolicited Hiring Packets/resumes will not be accepted by Community Action, Inc.</b></font><br><br>
								<a href="Employment%20Application/Application%20for%20Employment.pdf"><b>Click here</b></a> to download the Application for Employment and Hiring Packet Information Acknowledgement.
								You may also obtain these documents at our main office or call (814) 938-3302 to have them mailed to you.<br><br>
								<b>*Note: Adobe Acrobat Reader is needed to view and print the Application and Hiring Packet Information Acknowledgement. </b><br>
								<center><a href="http://www.adobe.com/products/acrobat/readstep.html" target="_blank"><img src="<% = "//www.jccap.org/Newer/optimized/AcrobatReader.gif" %>" border="0" width="87" height="30"></a></center><BR>
								Mail or hand deliver your <u>Cover Letter</u>, <u>Resume</u>, <u>Application for Employment</u> and <u>Hiring Packet Information Acknowledgement</u> by the deadline date to:<br><br>
								Community Action, Inc.<br>
								ATTN: Robert A. Cardamone, Executive Director<br>
								105 Grace Way<br>
								Punxsutawney, PA 15767<br>
								(814) 938-3302<br><br>
								<font color="#cc0033"><b><U>REMEMBER:</b></U></font> Your Hiring Packet will only be considered if it is complete.
							</td>
						</tr>
						<tr>
							<td background="optimized/New-Bottom-Border-x.jpg" width="1%" height="1%" align="left" valign="top"><img border="0" src="optimized/New-Bottom-Left-x.jpg" width="36" height="32"></td>
							<td background="optimized/New-Bottom-Border-x.jpg" height="1%" colspan="2"><img src="/images/layout/cthrupixel.gif" width="1" height="1"></td>
							<td width="1%" height="1%"><img border="0" src="optimized/New-Bottom-Right-x.jpg" width="36" height="32"></td>
						</tr>
						<tr>
							<td background="optimized/New-Top-Border-x.jpg" valign="top" align="left" width="1%" height="1%"><img border="0" src="optimized/New-Top-Left-x.jpg" width="36" height="32"></td>
							<td background="optimized/New-Top-Border-x.jpg" height="1%" colspan="2" width="98%"><img src="/images/layout/cthrupixel.gif" width="1" height="1"></td>
							<td rowspan="2" valign="top" align="left" height="1%" width="1%" background="optimized/New-Right-Border-x.jpg"><img border="0" src="optimized/New-Top-Right-x.jpg" width="36" height="32"></td>
						</tr>
						<tr>
							<td background="optimized/New-Left-Border-x.jpg" width="1%"><img src="/images/layout/cthrupixel.gif" width="1" height="1"></td>
							<td width="98%" align="left" valign="top"><font face="verdana,arial,helvetica,sans serif" size="3" color="#000000"><b>Job Announcements</b>
								<hr><font face="verdana,arial,helvetica,sans serif" size="2" color="#000000">
							<% counter = 1
							While counter <= 10 AND NOT rsRL.EOF
								If IsDate(rsRL("DeadLine")) Then
									If (DateDiff("d",Date,rsRL("DeadLine"))) >=0 Then
										RID = rsRL("AnnouncementNumber")
										If counter > 1 AND counter < 10 Then
											Response.Write("<hr>")
										End If %>
										<a href="https://www.jccap.org/newer/Job_Postings/<%=rsRL("FileName") %>" target="_blank"><b><%=rsRL("TitleOfPosition") %></b></a>
										
										<%
										Set JobDescription = server.CreateObject("Adodb.recordset")
										'1st condition is for new id's 2nd is for the old ones
										If rsRL("JD_ID") <> 0 Then
											SQL = "Select * from JobDescriptions where JD_ID = '" & rsRL("JD_ID") & "' and expired='N' and approvaldate <> ''"
										Else
											SQL = "Select * from JobDescriptions where JobPositionID = '" & rsRL("JobPositionID") & "' and expired='N' and approvaldate <> ''"
										End If
										JobDescription.Open SQL, objConn
										revDay = Day(JobDescription("RevisionDate"))
										If revDay < 10 Then
											revDay = "0" & revDay
										End If
										revMonth = Month(JobDescription("RevisionDate"))
										If revMonth < 10 Then
											revMonth = "0" & revMonth
										End If
										revYear = Year(JobDescription("RevisionDate"))
										sFileName = JobDescription("TitleOfPosition") & " (" & JobDescription("JD_ID") & ")" & " - " & revYear & revMonth & revDay & ".doc"
										jobDescriptionLink = "http://www.jccap.org/newer/Job_Descriptions/" & sFileName
										JobDescription.Close
										Set JobDescription = Nothing
										intCount = intCount+1 %>
										<BR>
										<a href="<%=jobDescriptionLink %>" target="_blank">View Related Job Description</a>
										&nbsp;- Application deadline: <%=rsRL("Deadline")%>
										<small>
									<% End If
								Else
									RID = rsRL("AnnouncementNumber")
									If counter > 1 AND counter < 10 Then
										Response.Write("<hr>")
									End If %>
									<a href="https://www.jccap.org/newer/Job_Postings/<%=rsRL("FileName") %>" target="_blank"><b><%=rsRL("TitleOfPosition") %></b></a>
									
									<% Set JobDescription = server.CreateObject("Adodb.recordset")
									'1st condition is for new id's 2nd is for the old ones
									If rsRL("JD_ID") <> 0 Then
										SQL = "Select * from JobDescriptions where JD_ID = '" & rsRL("JD_ID") & "' and expired='N' and approvaldate <> ''"
									Else
										SQL = "Select * from JobDescriptions where JobPositionID = '" & rsRL("JobPositionID") & "' and expired='N' and approvaldate <> ''"
									End If
									JobDescription.Open SQL, objConn
									If Not JobDescription.EOF Then
										revDay = Day(JobDescription("RevisionDate"))
										If revDay < 10 Then
											revDay = "0" & revDay
										End If
										
										revMonth = Month(JobDescription("RevisionDate"))
										If revMonth < 10 Then
											revMonth = "0" & revMonth
										End If
										revYear = Year(JobDescription("RevisionDate"))
										sFileName = JobDescription("TitleOfPosition") & " (" & JobDescription("JD_ID") & ")" & " - " & revYear & revMonth & revDay & ".doc"
										jobDescriptionLink = "http://www.jccap.org/newer/Job_Descriptions/" & sFileName
									End If
									JobDescription.Close
									Set JobDescription = Nothing
									intCount = intCount+1 %>
									<BR>
									<a href="<%=jobDescriptionLink %>" target="_blank">View Related Job Description</a>
									&nbsp;- Application deadline: <%=rsRL("Deadline")%>
									<small>
								<% End If
							rsRL.MoveNext %>
							</small>
							<% counter = counter + 1
							WEnd %>
							<br></a>
							<% If intCount = 0 Then %>
								<font face="verdana,arial,helvetica,sans serif" size="2" color="#000000"><b>There are no job announcements at this time.</b></font><br><br>
								<font color="cc0033"><b>Unsolicited Hiring Packets/resumes will not be accepted by Community Action, Inc.</b></font><br><br>
							<% End If %>
							<br></font><BR></td>
						</tr>
						<tr>
							<td background="optimized/New-Bottom-Border-x.jpg" width="1%" height="1%" align="left" valign="top"><img border="0" src="optimized/New-Bottom-Left-x.jpg" width="36" height="32"></td>
							<td background="optimized/New-Bottom-Border-x.jpg" height="1%" colspan="2"><img src="/images/layout/cthrupixel.gif" width="1" height="1"></td>
							<td width="1%" height="1%"><img border="0" src="optimized/New-Bottom-Right-x.jpg" width="36" height="32"></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</body>
</html>
<% objConn.close
Conn.close
Set Conn=Nothing
%>