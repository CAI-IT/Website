<%
'Authroize the system to run the report
noLoginMsg = True
skipLogin = True
%>
<!-- #include file="Intranet/tasks/db-NoCSS.asp" -->
<html>
	<head>
		<title>Daily Email Reminder Sending Tool</title>
	</head>
	<body>
	<%
	strEmailLog = ""
	strMailMsg = ""
	strAdminEmail = "rcardamone@jccap.org, jelkin@jccap.org, rrhodes@jccap.org, sfusco@jccap.org, ecerto@jccap.org, tkowalski@jccap.org"

	If datepart("w",Date) < 2 OR datepart("w",Date) > 6 Then
		Response.End()
	End If

	If Not Request.QueryString("p!uhaX9kas") = "PreRa2p9yw" Then
		If Now() > cDate(Date() & " 8:45 AM") OR Now() < cDate(Date() & " 8:00 AM") Then
			strEmailLog = strEmailLog & "Reports of tasks may only be run between 8:00am and 8:45am. Somebody triggered the reports page. You may want to review changing the security password on emailCAIATL.asp located in the root directory of the server."
			'Call sendEmailb(strAdminEmail,"","","rcardamone@jccap.org; jelkin@jccap.org; jlightcap@jccap.org","CAI ATL Email Reminder Send Log",strEmailLog)
			Response.Write("Reports may not be run at this time. Please see your administrator for assistance.")
			'Response.End
		End If
	End If

	
	strLastDate = sqlStr((Date()+29)&" 23:59:59")
	Set rsIntranetPersonnel = Server.CreateObject("ADODB.Recordset")
	Set rsPersonnelInfo = Server.CreateObject("ADODB.Recordset")
	SQL = "Select PerID from Personnel Where Active = 1 AND ((PerID IN (Select Reviewer from tskMain Where (Status <> 2) AND (Status <> 5) AND Due <> '1/1/1900' AND Due < " & strLastDate & ")) OR (PerID IN (Select Owner from tskMain Where (Status <> 2) AND (Status <> 5) AND Due <> '1/1/1900' AND Due < " & strLastDate & ")) OR (PerID IN (Select Responsible from tskMain Where (Status <> 2) AND (Status <> 5) AND Due <> '1/1/1900' AND Due < " & strLastDate & ")) OR (PerID IN (Select noteOwnerPer from tskNotes Where (tskID IN (Select tskID from tskMain Where (Status <> 2) AND (Status <> 5) AND Due <> '1/1/1900' AND Due < " & strLastDate & ")) Group By NoteOwnerPer))) Group By PerID"
	Set rsPersonnel = Server.CreateObject("ADODB.Recordset")
	rsPersonnel.Open SQL, connTasks,3,3
	Do While Not rsPersonnel.EOF
		If rsPersonnel("PerID") = "0" Then
			strEmailLog = strEmailLog & "Skipping Unknown Personnel.<br>"
		Else
			'Place where Josh requested space above Text
			SQL = "Select FirstName, LastName from Personnel Where PerID = " & rsPersonnel("PerID")
			rsPersonnelInfo.Open SQL, conn,3,3
			If Not rsPersonnelInfo.EOF Then
				SQL = "Select EmailAddress from IntranetPermissions Where PerID=" & rsPersonnel("PerID")
				rsIntranetPersonnel.Open SQL, connIntranet,3,3
				If Not rsIntranetPersonnel.EOF Then
					strEmailLog = strEmailLog & ("<font size=4><b><br>Sending an email to: " & rsIntranetPersonnel("EmailAddress") & " " & rsPersonnelInfo("LastName") & ", " & rsPersonnelInfo("FirstName") & " (" & rsPersonnel("PerID") & ")</b></font><br><br>")
				End If
				rsIntranetPersonnel.Close()
			End If
			rsPersonnelInfo.Close()
		End If
	rsPersonnel.MoveNext
	Loop
	rsPersonnel.Close()
	Set rsPersonnel = Nothing
	
	'*****
	test = 0
	'*****
	
	strLastDate = sqlStr((Date()+29) & " 23:59:59")
	SQL = "Select PerID FROM Personnel Where Active = 1 AND ((PerID IN (Select Reviewer FROM tskMain Where (Status <> 2) AND (Status <> 5) AND Due <> '1/1/1900' AND Due < " & strLastDate & ")) OR (PerID IN (Select Owner from tskMain Where (Status <> 2) AND (Status <> 5) AND Due <> '1/1/1900' AND Due < " & strLastDate & ")) OR (PerID IN (Select Responsible from tskMain Where (Status <> 2) AND (Status <> 5) AND Due <> '1/1/1900' AND Due < " & strLastDate & ")) OR (PerID IN (Select NoteOwnerPer from tskNotes Where (tskID IN (Select TskID from tskMain Where (Status <> 2) AND (Status <> 5) AND Due <> '1/1/1900' AND Due < " & strLastDate & ")) Group By NoteOwnerPer))) Group By PerID"
	Set rsPersonnel = Server.CreateObject("ADODB.Recordset")
	Set rsTskMain = Server.CreateObject("ADODB.Recordset")
	rsPersonnel.Open SQL, connTasks,3,3
	Do While Not rsPersonnel.EOF
		strEmail = ""
		strMailMsg = ""
		If rsPersonnel("perID") = "0" Then
			strEmailLog = strEmailLog & ("Skipping Unknown Personnel.<br />")
			rsPersonnel("perID") = rsPersonnel("perID")
		Else
			SQL = "Select FirstName, LastName from Personnel Where PerID = " & rsPersonnel("PerID")
			rsPersonnelInfo.Open SQL, conn,3,3
			If Not rsPersonnelInfo.EOF Then
				strMember = rsPersonnelInfo("FirstName") & " " & rsPersonnelInfo("LastName")
				SQL = "Select EmailAddress from IntranetPermissions Where PerID=" & rsPersonnel("PerID")
				rsIntranetPersonnel.Open SQL, connIntranet,3,3
				If Not rsIntranetPersonnel.EOF Then
					strEmail = rsIntranetPersonnel("EmailAddress")
					strEmailLog = strEmailLog & ("<font style=""font-size:13px; font-weight:bold;""><br>Sending an email to: " & rsIntranetPersonnel("EmailAddress") & " " & rsPersonnelInfo("LastName") & ", " & rsPersonnelInfo("FirstName") & " (" & rsPersonnel("PerID") & ")</font><br><br>")
				End If
				rsIntranetPersonnel.Close()
			End If
			rsPersonnelInfo.Close()
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			strMailMsg = strMailMsg & "<body><table width=""100%"" cellpadding=""3"" valign=""top""><tr><th>CAI Task Log Reminder Email</th></tr>"
			strMailMsg = strMailMsg & "<tr><td>Below are the tasks which you are related to in some way.</td></tr>"

			strMailMsg = strMailMsg & ("<tr><th>Overdue Tasks</th></tr>")
			SQL = "Select tskID from tskMain Where (due <= " & sqlStr(Date()-1) & ") AND (due <> '1/1/1900') AND (status <> 2) AND (status <> 5) AND (Responsible = " & rsPersonnel("PerID") & " OR Reviewer = " & rsPersonnel("PerID") & " OR Owner = " & rsPersonnel("PerID") & ") Order By Due"
			rsTskMain.Open SQL, connTasks,3,3
			If Not rsTskMain.EOF Then
				Do While Not rsTskMain.EOF
					strMailMsg = strMailMsg & "<tr><td>" & dispTskStr(rsTskMain("tskID"),"","","","","") & "</td></tr>"
				rsTskMain.MoveNext
				Loop
			Else
				strMailMsg = strMailMsg & "<tr><td>No tasks to report.</td></tr>"
			End If
			rsTskMain.Close()

			strMailMsg = strMailMsg & ("<tr><th>Due in less than 48 hours</th></tr>")
			SQL = "Select tskID FROM tskMain WHERE (due >= " & sqlStr(date()) & ") AND (due < " & sqlStr((date()+1) & " 23:59:59") & ") AND (status <> 2) AND (status <> 5) AND (Responsible = " & rsPersonnel("PerID") & " OR Reviewer = " & rsPersonnel("PerID") & " OR Owner = " & rsPersonnel("PerID") & ") Order By Due"
			rsTskMain.Open SQL, connTasks,3,3
			If Not rsTskMain.EOF Then
				Do While Not rsTskMain.EOF
					strMailMsg = strMailMsg & "<tr><td>" & dispTskStr(rsTskMain("tskID"),"","","","","") & "</td></tr>"
					intTskCount = intTskCount + 1
				rsTskMain.MoveNext
				Loop
			Else
				strMailMsg = strMailMsg & "<tr><td>No tasks to report.</td></tr>"
			End If
			rsTskMain.Close()

			strMailMsg = strMailMsg & ("<tr><th>Due in less than 7 days</th></tr>")
			SQL = "Select tskID from tskMain Where (due >= " & sqlStr(date()+2) & ") AND (due < " & sqlStr((date()+6) & " 23:59:59") & ") AND (status <> 2) AND (status <> 5) AND (Responsible = " & rsPersonnel("PerID") & " or reviewer = " & rsPersonnel("PerID") & " or owner = " & rsPersonnel("PerID") & ") Order By due"
			rsTskMain.Open SQL, connTasks,3,3
			If Not rsTskMain.EOF Then
				Do While Not rsTskMain.EOF
					strMailMsg = strMailMsg & "<tr><td>" & dispTskStr(rsTskMain("tskID"),"","","","","") & "</td></tr>"
					intTskCount = intTskCount + 1
				rsTskMain.MoveNext
				Loop
			Else
				strMailMsg = strMailMsg & "<tr><td>No tasks to report.</td></tr>"
			End If
			rsTskMain.Close()

			strMailMsg = strMailMsg & ("<tr><th>Due in less than 14 days</th></tr>")
			SQL = "Select tskID from tskMain Where (due >= " & sqlStr(date()+7) & ") AND (due < " & sqlStr((date()+13) & " 23:59:59") & ") AND (status <> 2) AND (status <> 5) AND (responsible = " & rsPersonnel("PerID") & " or reviewer = " & rsPersonnel("PerID") & " or owner = " & rsPersonnel("PerID") & ") Order By due"
			rsTskMain.Open SQL, connTasks,3,3
			If Not rsTskMain.EOF Then
				Do While Not rsTskMain.EOF
					strMailMsg = strMailMsg & "<tr><td>" & dispTskStr(rsTskMain("tskID"),"","","","","") & "</td></tr>"
					intTskCount = intTskCount + 1
				rsTskMain.MoveNext
				Loop
			Else
				strMailMsg = strMailMsg & "<tr><td>No tasks to report.</td></tr>"
			End If
			rsTskMain.Close()

			strMailMsg = strMailMsg & ("<tr><th>Due < 30 days</th></tr>")
			SQL = "Select tskID FROM tskMain Where (due >= " & sqlStr(date()+14) & ") AND (due < " & sqlStr((date()+29) & " 23:59:59") & ") AND (status <> 2) AND (status <> 5) AND (responsible = " & rsPersonnel("PerID") & " or reviewer = " & rsPersonnel("PerID") & " or owner = " & rsPersonnel("PerID") & ") Order By due"
			rsTskMain.Open SQL, connTasks, 3,3
			If Not rsTskMain.EOF Then
				Do While Not rsTskMain.EOF
					strMailMsg = strMailMsg & "<tr><td>" & dispTskStr(rsTskMain("tskID"),"","","","","") & "</td></tr>"
					intTskCount = intTskCount + 1
				rsTskMain.MoveNext
				Loop
			Else
				strMailMsg = strMailMsg & "<tr><td>No tasks to report.</td></tr>"
			End If
			rsTskMain.Close()

			strMailMsg = strMailMsg & ("<tr><th>Incomplete Tasks I'm not related to, but have made notes on.</th></tr>")
			SQL = "Select tskID from tskMain Where (tskID IN (SELECT tskID FROM tskNotes WHERE (noteOwnerPer = " & rsPersonnel("PerID") & ") AND (tskID IN (SELECT tskID FROM tskMain WHERE (status <> 2) AND (status <> 5) AND (owner <> " & rsPersonnel("PerID") & " AND reviewer <> " & rsPersonnel("PerID") & " AND responsible <> " & rsPersonnel("PerID") & "))) GROUP BY tskID))"
			
			'Return constrained list of tasks. Return list of tasks from notes w/ me as the enterer whose tasks are incomplete. Return list of tasks that are incomplete.
			rsTskMain.Open SQL, connTasks,3,3
			If Not rsTskMain.EOF Then
				Do While Not rsTskMain.EOF
					strMailMsg = strMailMsg & "<tr><td>" & dispTskStr(rsTskMain("tskID"),"","","","","") & "</td></tr>"
					intTskCount = intTskCount + 1
				rsTskMain.MoveNext
				Loop
			Else
				strMailMsg = strMailMsg & "<tr><td>No tasks to report.</td></tr>"
			End If
			rsTskMain.Close()

			If datepart("w",date) = 2 Then
				length = 3
			Else
				length = 1
			End If

			strMailMsg = strMailMsg & "</table>"
			
			strMailMsg = replace(strMailMsg,"src=""/","src=""https://www.jccap.org/")
			strMailMsg = replace(strMailMsg,"href=""/","href=""https://www.jccap.org/")
			
			If Len(strEmail) > 0 Then
				Set objMessage = CreateObject("CDO.Message")
				objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "EXCHANGE"
				objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
				objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
				objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
				objMessage.Configuration.Fields.Update
				objMessage.From = "no-reply@jccap.org"
				'objMessage.To = strEmail
				objMessage.To = "tkowalski@jccap.org"
				objMessage.Subject = "CAI Task Reminder Email"
				objMessage.HTMLBody = strMailMsg
				objMessage.Fields.Update
				if test = 0 then
				    objMessage.Send
				end if
				test = 1
				Set objMessage = Nothing
			End If
		End If
	rsPersonnel.MoveNext
	Loop
	rsPersonnel.Close()
	Set rsPersonnel = Nothing
	
	
	strLastDate = sqlStr((Date()+29) & " 23:59:59")
	strMailMsg=""
	Set rsTskMain = Server.CreateObject("ADODB.Recordset")
	
	strMailMsg = strMailMsg & "<table width=""100%"" cellpadding=""3"" valign=""top""><tr><th>CAI Task Log Reminder Email</th></tr>"
	strMailMsg = strMailMsg & "<tr><td>Below are the tasks for Community Action, Inc.</td></tr>"

	strMailMsg = strMailMsg & ("<tr><th>Overdue Tasks</th></tr>")
	SQL = "Select tskID from tskMain Where (due < " & sqlStr(Date()-1) & ") AND (due <> '1/1/1900') AND (status <> 2) AND (status <> 5) Order By Due"
	rsTskMain.Open SQL, connTasks,3,3
	If Not rsTskMain.EOF Then
		Do While Not rsTskMain.EOF
			strMailMsg = strMailMsg & "<tr><td>" & dispTskStr(rsTskMain("tskID"),"","","","","") & "</td></tr>"
		rsTskMain.MoveNext
		Loop
	Else
		strMailMsg = strMailMsg & "<tr><td>No tasks to report.</td></tr>"
	End If
	rsTskMain.Close()

	strMailMsg = strMailMsg & ("<tr><th>Due in less than 48 hours</th></tr>")
	SQL = "Select tskID FROM tskMain WHERE (due >= " & sqlStr(date()) & ") AND (due < " & sqlStr((date()+1) & " 23:59:59") & ") AND (status <> 2) AND (status <> 5) Order By Due"
	rsTskMain.Open SQL, connTasks,3,3
	If Not rsTskMain.EOF Then
		Do While Not rsTskMain.EOF
			strMailMsg = strMailMsg & "<tr><td>" & dispTskStr(rsTskMain("tskID"),"","","","","") & "</td></tr>"
			intTskCount = intTskCount + 1
		rsTskMain.MoveNext
		Loop
	Else
		strMailMsg = strMailMsg & "<tr><td>No tasks to report.</td></tr>"
	End If
	rsTskMain.Close()

	strMailMsg = strMailMsg & ("<tr><th>Due in less than 7 days</th></tr>")
	SQL = "Select tskID from tskMain Where (due >= " & sqlStr(date()+2) & ") AND (due < " & sqlStr((date()+6) & " 23:59:59") & ") AND (status <> 2) AND (status <> 5) Order By due"
	rsTskMain.Open SQL, connTasks,3,3
	If Not rsTskMain.EOF Then
		Do While Not rsTskMain.EOF
			strMailMsg = strMailMsg & "<tr><td>" & dispTskStr(rsTskMain("tskID"),"","","","","") & "</td></tr>"
			intTskCount = intTskCount + 1
		rsTskMain.MoveNext
		Loop
	Else
		strMailMsg = strMailMsg & "<tr><td>No tasks to report.</td></tr>"
	End If
	rsTskMain.Close()

	strMailMsg = strMailMsg & ("<tr><th>Due in less than 14 days</th></tr>")
	SQL = "Select tskID from tskMain Where (due >= " & sqlStr(date()+7) & ") AND (due < " & sqlStr((date()+13) & " 23:59:59") & ") AND (status <> 2) AND (status <> 5) Order By due"
	rsTskMain.Open SQL, connTasks,3,3
	If Not rsTskMain.EOF Then
		Do While Not rsTskMain.EOF
			strMailMsg = strMailMsg & "<tr><td>" & dispTskStr(rsTskMain("tskID"),"","","","","") & "</td></tr>"
			intTskCount = intTskCount + 1
		rsTskMain.MoveNext
		Loop
	Else
		strMailMsg = strMailMsg & "<tr><td>No tasks to report.</td></tr>"
	End If
	rsTskMain.Close()

	strMailMsg = strMailMsg & ("<tr><th>Due in less than 30 days</th></tr>")
	SQL = "Select tskID FROM tskMain Where (due >= " & sqlStr(date()+14) & ") AND (due < " & sqlStr((date()+29) & " 23:59:59") & ") AND (status <> 2) AND (status <> 5) Order By due"
	rsTskMain.Open SQL, connTasks, 3,3
	If Not rsTskMain.EOF Then
		Do While Not rsTskMain.EOF
			strMailMsg = strMailMsg & "<tr><td>" & dispTskStr(rsTskMain("tskID"),"","","","","") & "</td></tr>"
			intTskCount = intTskCount + 1
		rsTskMain.MoveNext
		Loop
	Else
		strMailMsg = strMailMsg & "<tr><td>No tasks to report.</td></tr>"
	End If
	rsTskMain.Close()

	If datepart("w",date) = 2 Then
		length = 3
	Else
		length = 1
	End If


	strMailMsg = strMailMsg & "</table>"
	strMailMsg = replace(strMailMsg,"src=""/","src=""https://www.jccap.org/")
	strMailMsg = replace(strMailMsg,"href=""/","href=""https://www.jccap.org/")
	
	Set rsPersonnelInfo = Nothing
	Set rsIntranetPersonnel = Nothing
	
	strMailMsg = strMailMsg & "</table>"
	strMailMsg = replace(strMailMsg,"src=""/","src=""https://www.jccap.org/")
	strMailMsg = replace(strMailMsg,"href=""/","href=""https://www.jccap.org/")

	Set objMessage = CreateObject("CDO.Message")
	objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "EXCHANGE"
	objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
	objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
	objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
	objMessage.Configuration.Fields.Update
	objMessage.From = "no-reply@jccap.org"
	'objMessage.To = strAdminEmail
	objMessage.To = "tkowalski@jccap.org"
	objMessage.Subject = "CAI Tasks"
	objMessage.HTMLBody = strMailMsg
	objMessage.Fields.Update
	objMessage.Send
	Set objMessage = Nothing
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	%>
	</body>
</html>