<%
connStr = "Provider=SQLOLEDB.1;Password=jcceoa;Persist Security Info=True;User ID=admin;Initial Catalog=intranet;Data Source=web"
Set conADODB = Server.CreateObject("ADODB.Connection")
conADODB.Open connStr

SQL = "Select * from EmploymentApplication Where EmploymentApplicationID = " & Replace(Request.QueryString("EmploymentApplicationID"), "'", "''")
Set rsEmploymentApplication = Server.CreateObject("ADODB.Recordset")
rsEmploymentApplication.Open SQL, conADODB,3,3
If Not rsEmploymentApplication.EOF Then
	strPositionDesired = rsEmploymentApplication("PositionDesired")
	strPartTime = rsEmploymentApplication("PartTime")
	strFullTime = rsEmploymentApplication("FullTime")
	strApplicationDate = rsEmploymentApplication("ApplicationDate")
	strFirstName = rsEmploymentApplication("FirstName")
	strLastName = rsEmploymentApplication("LastName")
	strMiddleName = rsEmploymentApplication("MiddleName")
End If
rsEmploymentApplication.Close()
Set rsEmploymentApplication = Nothing

conADODB.Close()
Set conADODB = Nothing %>
<html>
	<head>
		<title>Thank You <%=strFirstName %>&nbsp;<%=strLastName %></title>
		
		<style type="text/css">
		body {font-size:12px; font-family:Arial;}
		h1 {font-size:16px;}
		p {font-size:12px;}
		</style>
	</head>
	<body>
	<h1><%=strFirstName %>,</h1>
	
	Thank you for applying for the position of <%=strPositionDesired %>.&nbsp;&nbsp;We will review your application and proceed further if your 
	qualifications match our requirements.</p>
	</body>
</html>