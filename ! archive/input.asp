<!--#include file="intranet/computer_errors/includes/config.asp" -->
<% Dim bCritical, rsComputerProblem, rsIntranetPermissions, strUserEmail, intID, strName, aryName
Dim strSubject, strMailMsg, strTechEmail, strReplyEmail, objMessage

If (Request.ServerVariables("Request_Method") <> "POST") AND (Trim(Request.Form("Problem")) = "") Then
	If Request.Form("Critical") = 1 Then
		bCritical = 1
	Else
		bCritical = 0
	End If

	Set conADODB = Server.CreateObject("ADODB.Connection")
	conADODB.Open strDBConn

	SQL = "Insert into Comp_Problem (Name,Problem,Submitted,Login,Critical) values ('" & Replace(Request.Form("Name"), "'", "''") & "','" & Replace(Request.Form("Problem"), "'", "''") & "','" & FormatDateTime(Now) & "','" & Replace(strLogin, "'", "''") & "'," & bCritical & ")"
	conADODB.Execute(SQL)

	SQL = "Select Max(ID) As Totals from Comp_Problem"
	Set rsComputerProblem = Server.CreateObject("ADODB.Recordset")
	rsComputerProblem.Open SQL, conADODB,3,3
	intID = rsComputerProblem("Totals")
	rsComputerProblem.Close()
	Set rsComputerProblem = Nothing

	SQL = "Select EmailAddress From IntranetPermissions Where UserName = '" & strLogin & "'"
	Set rsIntranetPermissions = Server.CreateObject("ADODB.Recordset")
	rsIntranetPermissions.Open SQL, conADODB,3,3
	If Not rsIntranetPermissions.EOF Then
		strUserEmail = rsIntranetPermissions("EmailAddress")
	End If
	rsIntranetPermissions.Close()

	While Len(intID) < 6
		intID = "0" & intID
	WEnd
	
	strName = Request.Form("Name")
	If InStr(strName, ",") Then
		aryName = Split(strName,",")
		strName = aryName(1) & " " & aryName(0)
	End If

	If bCritical = 1 Then
		strSubject = "Critical Error in Computer Error Log"
		strMailMsg = "<font style=""color:#ff0000; font-weight:bold;"">" & strName & "</font> has reported a <a href=""https://www.jccap.org/Intranet/computer_errors/issuesOpen.asp#trouble" & intID & """ style=""color:#FF0000;"">CRITICAL ERROR</a> in the computer error log please review ASAP! The following is the text of the error:<hr>" & Replace(Request.Form("Problem"), vbCrLf, "<br>")
	Else
		strSubject = "Error in Computer Error Log"
		strMailMsg = "<font style=""color:#0000ff; font-weight:bold;"">" & strName & "</font> has reported an <a href=""https://www.jccap.org/Intranet/computer_errors/issuesOpen.asp#trouble"&intID&""">error</a> in the computer error log. The following is the text of the error:<hr>" & Replace(Request.Form("Problem"), vbCrLf, "<br>")
	End If


	strTechEmail = ""
	SQL = "Select EmailAddress from IntranetPermissions Where ComputerError = 'checked'"
	rsIntranetPermissions.Open SQL, conADODB, 3,3
	Do While Not rsIntranetPermissions.EOF
		strTechEmail = strTechEmail & rsIntranetPermissions("EmailAddress") & "; "
		rsIntranetPermissions.MoveNext
	Loop
	rsIntranetPermissions.Close()
	Set rsIntranetPermissions = Nothing

	strTechEmail = Trim(strTechEmail)
	If Right(strTechEmail,1) = ";" Then
		strTechEmail = Left(strTechEmail, Len(strTechEmail)-1)
	End If

	If InStr(strTechEmail, strUserEmail) > 0 Then
		strReplyEmail = strTechEmail
	Else
		strReplyEmail = strUserEmail & "; " & strTechEmail
	End If

	Set objMessage = CreateObject("CDO.Message")
	objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "EXCHANGE"
	objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
	objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
	objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
	objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
	objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "SMTPAdmin"
    objMessage.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "8raMAswU"
	objMessage.Configuration.Fields.Update
	objMessage.From = "tkowalski@jccap.org"
	objMessage.To = "tkowalski@jccap.org"
	objMessage.ReplyTo = "tkowalski@jccap.org"
	objMessage.Subject = "test"
	objMessage.HTMLBody = "<font style=""font-family:Arial"">" & "test" & "</font>"
	objMessage.Fields.Update
	objMessage.Send
	Set objMessage = Nothing

    Response.End
	Response.Redirect(Request.ServerVariables("Path_Info") & "?Sent=true")
Else
	Set conADODB = Server.CreateObject("ADODB.Connection")
	conADODB.Open strDBConn

	SQL = "Select Tech, FirstName, LastName, EmailAddress from IntranetPermissions Where UserName = '" & strLogin & "'"
	Set rsIntranetPermissions = Server.CreateObject("ADODB.Recordset")
	rsIntranetPermissions.Open SQL, conADODB,3,3
	If Not rsIntranetPermissions.EOF Then
		intTech = rsIntranetPermissions("Tech")
		strFirstName = rsIntranetPermissions("FirstName")
		strLastName = rsIntranetPermissions("LastName")
		strEmailAddress = rsIntranetPermissions("EmailAddress")
	End If
	rsIntranetPermissions.Close()
	Set rsIntranetPermissions = Nothing
	
	conADODB.Close()
	Set conADODB = Nothing %>
	<html>
		<head>
			<title><%=strClientName %></title>
			
			<link href="includes/font.css" rel="stylesheet" type="text/css">
		</head>
		<body>
		<table cellpadding="0" cellspacing="0" border="0" width="100%" background="images/headerbggrad.jpg" height="148" ID="Table1">
			<tr valign="top" height="100">
				<td><a href="./"><img src="images/celheader.jpg" width="238" height="100" alt="<%=strClientName %>" border="0"></a></td>
			</tr>
			<tr valign="top" height="48">
				<td><img src="images/blank.gif" height="10" width="1" alt=""><br>
				<% Call MainNavigation(1) %>
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" border="0" width="95%" align="center" ID="Table2">
			<tr>
				<td>
				<% If Trim(Request.QueryString("Sent")) = "" Then
					Response.Write("<font style=""font-family:Arial;"">There was an error with your submission.</font>")
				Else
					Response.Write("<h1>Your problem has been recorded, thank you.</h1>" & vbNewLine)
					Response.Write("<a href=""./"">Click  here</a> to go back to the Computer Error Logs")
				End If %>
				</td>
			</tr>
		</table>
		</body>
	</html>
<% End If %>