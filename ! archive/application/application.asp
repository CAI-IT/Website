<%
If Trim(Request.QueryString("EmploymentApplicationID")) <> "" Then
	connStr = "Provider=SQLOLEDB.1;Password=jcceoa;Persist Security Info=True;User ID=admin;Initial Catalog=intranet;Data Source=web"
	Set conADODB = Server.CreateObject("ADODB.Connection")
	conADODB.Open connStr

	SQL = "Select * from EmploymentApplication Where EmploymentApplicationID = " & Replace(Request.QueryString("EmploymentApplicationID"), "'", "''") & " AND SessionID = '" & Replace(Request.QueryString("Key"), "'", "''") & "'"
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
		strPresentAddress = rsEmploymentApplication("PresentAddress")
		strPresentCity = rsEmploymentApplication("PresentCity")
		strPresentState = rsEmploymentApplication("PresentState")
		intPresentTimeThereYears = rsEmploymentApplication("PresentTimeThereYears")
		intPresentTimeThereMonths = rsEmploymentApplication("PresentTimeThereMonths")
		strPreviousAddress = rsEmploymentApplication("PreviousAddress")
		strPreviousCity = rsEmploymentApplication("PreviousCity")
		strPreviousState = rsEmploymentApplication("PreviousState")
		intPreviousTimeThereYears = rsEmploymentApplication("PreviousTimeThereYears")
		intPreviousTimeThereMonths = rsEmploymentApplication("PreviousTimeThereMonths")
		strPhone = rsEmploymentApplication("Phone")
		strSSN = rsEmploymentApplication("SSN")
		strWorkedHereBefore = rsEmploymentApplication("WorkedHereBefore")
		strWorkedHereBeforeDescription = rsEmploymentApplication("WorkedHereBeforeDescription")
		strMisdemeanorOrFelony = rsEmploymentApplication("MisdemeanorOrFelony")
		strMisdemeanorOrFelonyDescription = rsEmploymentApplication("MisdemeanorOrFelonyDescription")
		strTerminated = rsEmploymentApplication("Terminated")
		strTerminatedCircumstances = rsEmploymentApplication("TerminatedCircumstances")
		strEmploymentGaps = rsEmploymentApplication("EmploymentGaps")
		strContactPastEmployer = rsEmploymentApplication("ContactPastEmployer")
		strContactPastEmployerDescription = rsEmploymentApplication("ContactPastEmployerDescription")
		strQualificationExperience = rsEmploymentApplication("QualificationExperience")
		strAnotherName = rsEmploymentApplication("AnotherName")
		strAnotherNameDescription = rsEmploymentApplication("AnotherNameDescription")
		strOver18Proof = rsEmploymentApplication("Over18Proof")
		strPerformJobDuties = rsEmploymentApplication("PerformJobDuties")
		strAdequateTransportation = rsEmploymentApplication("AdequateTransportation")
		strDaysMissedYear0 = rsEmploymentApplication("DaysMissedYear0")
		strDaysMissedNumberOfDays0 = rsEmploymentApplication("DaysMissedNumberOfDays0")
		strDaysMissedYear1 = rsEmploymentApplication("DaysMissedYear1")
		strDaysMissedNumberOfDays1 = rsEmploymentApplication("DaysMissedNumberOfDays1")
		strDaysMissedYear2 = rsEmploymentApplication("DaysMissedYear2")
		strDaysMissedNumberOfDays2 = rsEmploymentApplication("DaysMissedNumberOfDays2")
		strResume = rsEmploymentApplication("Resume")
	End If
	rsEmploymentApplication.Close()
	Set rsEmploymentApplication = Nothing
	
	intCount=0
	Set rsEmploymentPast = Server.CreateObject("ADODB.Recordset")
	SQL = "Select * from EmploymentPast Where EmploymentApplicationID = " & Replace(Request.QueryString("EmploymentApplicationID"), "'", "''")
	rsEmploymentPast.Open SQL, conADODB,3,3
	intEmploymentPastTotal = rsEmploymentPast.RecordCount
	While intCount < intEmploymentPastTotal AND NOT rsEmploymentPast.EOF
		strEmploymentNumber = strEmploymentNumber & rsEmploymentPast("EmployeerNumber") & "|"
		strEmploymentEmployer = strEmploymentEmployer & rsEmploymentPast("Employer") & "|"
		strEmploymentAddress = strEmploymentAddress & rsEmploymentPast("Address") & "|"
		strEmploymentCity = strEmploymentCity & rsEmploymentPast("City") & "|"
		strEmploymentState = strEmploymentState & rsEmploymentPast("State") & "|"
		strEmploymentZipCode = strEmploymentZipCode & rsEmploymentPast("ZipCode") & "|"
		strEmploymentEmployedFrom = strEmploymentEmployedFrom & rsEmploymentPast("EmployedFrom") & "|"
		strEmploymentEmployedTo = strEmploymentEmployedTo & rsEmploymentPast("EmployedTo") & "|"
		strEmploymentPayStart = strEmploymentPayStart & rsEmploymentPast("PayStart") & "|"
		strEmploymentPayFinal = strEmploymentPayFinal & rsEmploymentPast("PayFinal") & "|"
		strEmploymentYourPosition = strEmploymentYourPosition & rsEmploymentPast("YourPosition") & "|"
		strEmploymentLastSupervisor = strEmploymentLastSupervisor & rsEmploymentPast("LastSupervisor") & "|"
		strEmploymentReasonForLeaving = strEmploymentReasonForLeaving & rsEmploymentPast("ReasonForLeaving") & "|"
		intCount=intCount+1
		rsEmploymentPast.MoveNext
	WEnd
	rsEmploymentPast.Close()
	Set rsEmploymentPast = Nothing
	
	Set rsEmploymentSchool = Server.CreateObject("ADODB.Recordset")
	SQL = "Select * from EmploymentSchool Where EmploymentApplicationID = " & Replace(Request.QueryString("EmploymentApplicationID"), "'", "''") & " AND SchoolNumber=0"
	rsEmploymentSchool.Open SQL, conADODB,3,3
	If Not rsEmploymentSchool.EOF Then
		strSchoolName0 = rsEmploymentSchool("SchoolName")
		strYearsCompleted0 = rsEmploymentSchool("YearsCompleted")
		strDegreeReceived0 = rsEmploymentSchool("DegreeReceived")
		strMajor0 = rsEmploymentSchool("Major")
		strSpecializedTraining0 = rsEmploymentSchool("SpecializedTraining")
	End If
	rsEmploymentSchool.Close()
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = "Select * from EmploymentSchool Where EmploymentApplicationID = " & Replace(Request.QueryString("EmploymentApplicationID"), "'", "''") & " AND SchoolNumber=1"
	rsEmploymentSchool.Open SQL, conADODB,3,3
	If Not rsEmploymentSchool.EOF Then
		strSchoolName1 = rsEmploymentSchool("SchoolName")
		strYearsCompleted1 = rsEmploymentSchool("YearsCompleted")
		strDegreeReceived1 = rsEmploymentSchool("DegreeReceived")
		strMajor1 = rsEmploymentSchool("Major")
		strSpecializedTraining1 = rsEmploymentSchool("SpecializedTraining")
	End If
	rsEmploymentSchool.Close()
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = "Select * from EmploymentSchool Where EmploymentApplicationID = " & Replace(Request.QueryString("EmploymentApplicationID"), "'", "''") & " AND SchoolNumber=2"
	rsEmploymentSchool.Open SQL, conADODB,3,3
	If Not rsEmploymentSchool.EOF Then
		strSchoolName2 = rsEmploymentSchool("SchoolName")
		strYearsCompleted2 = rsEmploymentSchool("YearsCompleted")
		strDegreeReceived2 = rsEmploymentSchool("DegreeReceived")
		strMajor2 = rsEmploymentSchool("Major")
		strSpecializedTraining2 = rsEmploymentSchool("SpecializedTraining")
	End If
	rsEmploymentSchool.Close()
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = "Select * from EmploymentSchool Where EmploymentApplicationID = " & Replace(Request.QueryString("EmploymentApplicationID"), "'", "''") & " AND SchoolNumber=3"
	rsEmploymentSchool.Open SQL, conADODB,3,3
	If Not rsEmploymentSchool.EOF Then
		strSchoolName3 = rsEmploymentSchool("SchoolName")
		strYearsCompleted3 = rsEmploymentSchool("YearsCompleted")
		strDegreeReceived3 = rsEmploymentSchool("DegreeReceived")
		strMajor3 = rsEmploymentSchool("Major")
		strSpecializedTraining3 = rsEmploymentSchool("SpecializedTraining")
	End If
	rsEmploymentSchool.Close()
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = "Select * from EmploymentSchool Where EmploymentApplicationID = " & Replace(Request.QueryString("EmploymentApplicationID"), "'", "''") & " AND SchoolNumber=4"
	rsEmploymentSchool.Open SQL, conADODB,3,3
	If Not rsEmploymentSchool.EOF Then
		strSchoolName4 = rsEmploymentSchool("SchoolName")
		strYearsCompleted4 = rsEmploymentSchool("YearsCompleted")
		strDegreeReceived4 = rsEmploymentSchool("DegreeReceived")
		strMajor4 = rsEmploymentSchool("Major")
		strSpecializedTraining4 = rsEmploymentSchool("SpecializedTraining")
	End If
	rsEmploymentSchool.Close()
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = "Select * from EmploymentSchool Where EmploymentApplicationID = " & Replace(Request.QueryString("EmploymentApplicationID"), "'", "''") & " AND SchoolNumber=5"
	rsEmploymentSchool.Open SQL, conADODB,3,3
	If Not rsEmploymentSchool.EOF Then
		strSchoolName5 = rsEmploymentSchool("SchoolName")
		strYearsCompleted5 = rsEmploymentSchool("YearsCompleted")
		strDegreeReceived5 = rsEmploymentSchool("DegreeReceived")
		strMajor5 = rsEmploymentSchool("Major")
		strSpecializedTraining5 = rsEmploymentSchool("SpecializedTraining")
	End If
	rsEmploymentSchool.Close()
	Set rsEmploymentSchool = Nothing
	
	Set rsEmploymentReference = Server.CreateObject("ADODB.Recordset")
	SQL = "Select * from EmploymentReferences Where EmploymentApplicationID = " & Replace(Request.QueryString("EmploymentApplicationID"), "'", "''") & " AND EmployeeReferenceNumber=0"
	rsEmploymentReference.Open SQL,conADODB,3,3
	If Not rsEmploymentReference.EOF Then
		strName0 = rsEmploymentReference("Name")
		strOccupation0 = rsEmploymentReference("Occupation")
		strAddress0 = rsEmploymentReference("Address")
		strCity0 = rsEmploymentReference("City")
		strState0 = rsEmploymentReference("State")
		strPhone0 = rsEmploymentReference("Phone")
		strYearsKnown0 = rsEmploymentReference("YearsKnown")
	End If
	rsEmploymentReference.Close()
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = "Select * from EmploymentReferences Where EmploymentApplicationID = " & Replace(Request.QueryString("EmploymentApplicationID"), "'", "''") & " AND EmployeeReferenceNumber=1"
	rsEmploymentReference.Open SQL,conADODB,3,3
	If Not rsEmploymentReference.EOF Then
		strName1 = rsEmploymentReference("Name")
		strOccupation1 = rsEmploymentReference("Occupation")
		strAddress1 = rsEmploymentReference("Address")
		strCity1 = rsEmploymentReference("City")
		strState1 = rsEmploymentReference("State")
		strPhone1 = rsEmploymentReference("Phone")
		strYearsKnown1 = rsEmploymentReference("YearsKnown")
	End If
	rsEmploymentReference.Close()
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = "Select * from EmploymentReferences Where EmploymentApplicationID = " & Replace(Request.QueryString("EmploymentApplicationID"), "'", "''") & " AND EmployeeReferenceNumber=2"
	rsEmploymentReference.Open SQL,conADODB,3,3
	If Not rsEmploymentReference.EOF Then
		strName2 = rsEmploymentReference("Name")
		strOccupation2 = rsEmploymentReference("Occupation")
		strAddress2 = rsEmploymentReference("Address")
		strCity2 = rsEmploymentReference("City")
		strState2 = rsEmploymentReference("State")
		strPhone2 = rsEmploymentReference("Phone")
		strYearsKnown2 = rsEmploymentReference("YearsKnown")
	End If
	rsEmploymentReference.Close()
	Set rsEmploymentReference = Nothing

	conADODB.Close()
	Set conADODB = Nothing
Else
	strApplicationDate = FormatDateTime(Now,2)
	strCertifyDate = FormatDateTime(Now,2)
	intPresentTimeThereYears = "0"
	intPresentTimeThereMonths = "0"
	intPreviousTimeThereYears = "0"
	intPreviousTimeThereMonths = "0"
	

End If

For i = 0 To 4-intEmploymentPastTotal
	strEmploymentEmployeerNumber = strEmploymentEmployeerNumber & "|"
	strEmploymentEmployer = strEmploymentEmployer & "|"
	strEmploymentAddress = strEmploymentAddress & "|"
	strEmploymentCity = strEmploymentCity & "|"
	strEmploymentState = strEmploymentState & "|"
	strEmploymentZipCode = strEmploymentZipCode & "|"
	strEmploymentEmployedFrom = strEmploymentEmployedFrom & "|"
	strEmploymentEmployedTo = strEmploymentEmployedTo & "|"
	strEmploymentPayStart = strEmploymentPayStart & "|"
	strEmploymentPayFinal = strEmploymentPayFinal & "|"
	strEmploymentYourPosition = strEmploymentYourPosition & "|"
	strEmploymentLastSupervisor = strEmploymentLastSupervisor & "|"
	strEmploymentReasonForLeaving = strEmploymentReasonForLeaving & "|"
Next

aryEmploymentNumber = Split(strEmploymentEmployeerNumber, "|")
aryEmploymentEmployer = Split(strEmploymentEmployer, "|")
aryEmploymentAddress = Split(strEmploymentAddress, "|")
aryEmploymentCity = Split(strEmploymentCity, "|")
aryEmploymentState = Split(strEmploymentState, "|")
aryEmploymentZipCode = Split(strEmploymentZipCode, "|")
aryEmploymentEmployedFrom = Split(strEmploymentEmployedFrom, "|")
aryEmploymentEmployedTo = Split(strEmploymentEmployedTo, "|")
aryEmploymentPayStart = Split(strEmploymentPayStart, "|")
aryEmploymentPayFinal = Split(strEmploymentPayFinal, "|")
aryEmploymentYourPosition = Split(strEmploymentYourPosition, "|")
aryEmploymentLastSupervisor = Split(strEmploymentLastSupervisor, "|")
aryEmploymentReasonForLeaving = Split(strEmploymentReasonForLeaving, "|")
 %>
<html>
	<head>
		<title>Application For Employment</title>
		
		<script language="javascript">
		function IsNumeric(strFieldName,strMessage) {
			var checkOK = "0123456789";
			var checkStr = document.application.elements[strFieldName].value;
			var allValid = true;
			for (i = 0;  i < checkStr.length;  i++) {
				ch = checkStr.charAt(i);
				for (j = 0;  j < checkOK.length;  j++)
				if (ch == checkOK.charAt(j))
				break;
				if (j == checkOK.length) {
					allValid = false;
					break;
				}
			}
			
			if (!allValid) {
				alert("Please enter only NUMERIC characters in the "+strMessage+" field.");
				document.application.elements[strFieldName].focus;
				return(false);
			}
		}
		
		function CheckForm() {
			var alertsay = "";
			if (document.application.PositionDesired.value == "") {
				alert("Please enter the position you wish to apply for.\n"
				+"If you are unsure of the position you wish to apply for type \'ANY\'.");
				document.application.PositionDesired.focus();
				return (false);
			}
			var alertsay = "";
			if (document.application.LastName.value == "") {
				alert("Please enter your Last Name.");
				document.application.LastName.focus();
				return (false);
			}
			var alertsay = "";
			if (document.application.FirstName.value == "") {
				alert("Please enter your First Name.");
				document.application.FirstName.focus();
				return (false);
			}
			////////////////////////////////////////////////////////////////////////
			var alertsay = "";
			if (document.application.Phone.value == "") {
				alert("Please enter your Phone Number.");
				document.application.Phone.focus();
				return (false);
			}

			var checkOK = "0123456789-.() ";
			var checkStr = document.application.Phone.value;
			var allValid = true;
			for (i = 0;  i < checkStr.length;  i++) {
				ch = checkStr.charAt(i);
				for (j = 0;  j < checkOK.length;  j++)
				if (ch == checkOK.charAt(j))
				break;
				if (j == checkOK.length) {
					allValid = false;
					break;
				}
			}
			if (!allValid) {
				alert("Please enter only NUMERIC characters in the Phone field.");
				document.application.Phone.focus();
				return(false);
			}
			////////////////////////////////////////////////////////////////////////
			var alertsay = "";
			if (document.application.PresentTimeThereYears.value == "") {
				alert("Please enter the amount of years you\'ve lived at your present address.");
				document.application.PresentTimeThereYears.focus();
				return (false);
			}
			var checkOK = "0123456789";
			var checkStr = document.application.PresentTimeThereYears.value;
			var allValid = true;
			for (i = 0;  i < checkStr.length;  i++) {
				ch = checkStr.charAt(i);
				for (j = 0;  j < checkOK.length;  j++)
				if (ch == checkOK.charAt(j))
				break;
				if (j == checkOK.length) {
					allValid = false;
					break;
				}
			}
			
			if (!allValid) {
				alert("Please enter only NUMERIC characters for the amount of years you\'ve lived at your present address.");
				document.application.PresentTimeThereYears.focus();
				return(false);
			}
			///////////////////////////////////////////////////////////////////////////////////
			var alertsay = "";
			if (document.application.PresentTimeThereMonths.value == "") {
				alert("Please enter the amount of months you\'ve lived at your present address.");
				document.application.PresentTimeThereMonths.focus();
				return (false);
			}
			var checkOK = "0123456789";
			var checkStr = document.application.PresentTimeThereMonths.value;
			var allValid = true;
			for (i = 0;  i < checkStr.length;  i++) {
				ch = checkStr.charAt(i);
				for (j = 0;  j < checkOK.length;  j++)
				if (ch == checkOK.charAt(j))
				break;
				if (j == checkOK.length) {
					allValid = false;
					break;
				}
			}
			
			if (!allValid) {
				alert("Please enter only NUMERIC characters for the amount of months you\'ve lived at your present address.");
				document.application.PresentTimeThereMonths.focus();
				return(false);
			}
			////////////////////////////////////////////////////////////////////////////////////
			var alertsay = "";
			if (document.application.PreviousTimeThereYears.value == "") {
				alert("Please enter the amount of years you\'ve lived at your previous address.");
				document.application.PreviousTimeThereYears.focus();
				return (false);
			}
			var checkOK = "0123456789";
			var checkStr = document.application.PreviousTimeThereYears.value;
			var allValid = true;
			for (i = 0;  i < checkStr.length;  i++) {
				ch = checkStr.charAt(i);
				for (j = 0;  j < checkOK.length;  j++)
				if (ch == checkOK.charAt(j))
				break;
				if (j == checkOK.length) {
					allValid = false;
					break;
				}
			}
			
			if (!allValid) {
				alert("Please enter only NUMERIC characters for the amount of years you\'ve lived at your previous address.");
				document.application.PreviousTimeThereYears.focus();
				return(false);
			}
			///////////////////////////////////////////////////////////////////////////////////
			var alertsay = "";
			if (document.application.PreviousTimeThereMonths.value == "") {
				alert("Please enter the amount of months you\'ve lived at your previous address.");
				document.application.PreviousTimeThereMonths.focus();
				return (false);
			}
			var checkOK = "0123456789";
			var checkStr = document.application.PreviousTimeThereMonths.value;
			var allValid = true;
			for (i = 0;  i < checkStr.length;  i++) {
				ch = checkStr.charAt(i);
				for (j = 0;  j < checkOK.length;  j++)
				if (ch == checkOK.charAt(j))
				break;
				if (j == checkOK.length) {
					allValid = false;
					break;
				}
			}
			
			if (!allValid) {
				alert("Please enter only NUMERIC characters for the amount of months you\'ve lived at your previous address.");
				document.application.PreviousTimeThereMonths.focus();
				return(false);
			}
			
			var alertsay = "";
			if (document.application.SSN.value == "") {
				alert("Please enter your Social Security Number.");
				document.application.SSN.focus();
				return (false);
			}
			var checkOK = "0123456789- ";
			var checkStr = document.application.SSN.value;
			var allValid = true;
			for (i = 0;  i < checkStr.length;  i++) {
				ch = checkStr.charAt(i);
				for (j = 0;  j < checkOK.length;  j++)
				if (ch == checkOK.charAt(j))
				break;
				if (j == checkOK.length) {
					allValid = false;
					break;
				}
			}
			
			if (!allValid) {
				alert("Please enter only NUMERIC characters, spaces and hypens for the Social Security field.");
				document.application.SSN.focus();
				return(false);
			}
			////////////////////////////////////////////////////////////////////////////////////
			if (!document.application.Agree.checked) {
				alert("You must read our Agreement before submitting.");
				return(false);
			}
		}
		</script>

		<style type="text/css">
		body {margin:0px; font-family:Arial; font-size:12px; color:#000000;}
		p {font-family:Arial; font-size:12px; color:#000000; margin-top:0px; margin-bottom:0px;}
		table {font-family:Arial; font-size:12px; color:#000000;}
		td {font-family:Arial; font-size:12px; color:#000000;}
		a:link {color:#0000ff;}
		a:link:hover {color:#ff0000;}
		a:visited {color:#000000;}
		a:visited:hover {color:#ff0000;}
		h1 {font-family:Verdana, Helvetica, sans-serif; font-size:26px; color:#000000; margin-top:0px; margin-bottom:0px;}
		h2 {font-family:Verdana, Helvetica, sans-serif; font-size:16px; color:#000000; margin-top:0px; margin-bottom:0px;}
		h3 {font-family:Verdana, Helvetica, sans-serif; font-size:15px; color:#000000; margin-top:0px; margin-bottom:0px;}
		pre {font-family:Verdana, Helvetica, sans-serif; font-size:14px; margin-top:0px; margin-bottom:0px;}
		dt {font-family:Verdana, Helvetica, sans-serif; font-size:14px; margin-top:0px; margin-bottom:0px;}
		ul {font-family:Verdana, Helvetica, sans-serif; font-size:14px; color:#000000; margin-top:0px; margin-bottom:0px;}
		ol {font-family:Verdana, Helvetica, sans-serif; font-size:14px; color:#000000; margin-top:0px; margin-bottom:0px;}
		li {font-family:Verdana, Helvetica, sans-serif; font-size:14px; color:#000000; list-style-image:inherit;}
		.tiny {font-size:10px;}
		input {font-family:Verdana; font-size:11px;}
		</style>
	</head>
	<body onload="document.application.PositionDesired.focus();">
	<form method="post" name="application" action="application-process.asp" onSubmit="return CheckForm();" ENCTYPE="multipart/form-data">
	<input type="hidden" name="EmploymentApplicationID" value="<%=Replace(Request.QueryString("EmploymentApplicationID"), "'", "''")%>">
	<center><h1>Community Action, Inc.</h1></center>
	<center><h2><u>Application For Employment</u></h2></center>
	<br>
	<p align="center"><b>INCOMPLETE APPLICATIONS WILL NOT BE CONSIDERED.<br>
	Please leave no blank sections.&nbsp;&nbsp;Use N/A if not applicable.</b><br><br></p>
	<table cellpadding="0" cellspacing="0" border="0" width="665" align="center">
		<tr>
			<td>Position Desired:</td>
			<td><input type="text" name="PositionDesired" value="<%=strPositionDesired %>" size="40" maxlength="50"></td>
			<td><input type="checkbox" <%=strPartTime %> name="PartTime" value="checked" style="cursor:hand;" ID="PartTime"><label for="PartTime" style="cursor:hand;">Part Time</label></td>
			<td>&nbsp;</td>
			<td><input type="checkbox" <%=strFullTime %> name="FullTime" value="checked" style="cursor:hand;" ID="FullTime"><label for="FullTime" style="cursor:hand;">Full Time</label></td>
			<td>&nbsp;&nbsp;</td>
			<td>Date:&nbsp;</td>
			<td><input type="text" name="ApplicationDate" value="<%=strApplicationDate %>" size="15" maxlength="10"></td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" border="0" width="665" align="center">
		<tr>
			<td>Name:&nbsp;</td>
			<td><input type="text" name="LastName" value="<%=strLastName %>" size="20" maxlength="50"></td>
			<td>&nbsp;</td>
			<td><input type="text" name="FirstName" value="<%=strFirstName %>" size="30" maxlength="60"></td>
			<td>&nbsp;</td>
			<td><input type="text" name="MiddleName" value="<%=strMiddleName %>" size="20" maxlength="50"></td>
			<td width="100%"></td>
		</tr>
		<tr>
			<td></td>
			<td><p class="tiny">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Last</p></td>
			<td></td>
			<td><p class="tiny">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;First</p></td>
			<td></td>
			<td><p class="tiny">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Middle</p></td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" border="0" width="665" align="center">
		<tr>
			<td>Present Address:</td>
			<td><input type="text" name="PresentAddress" value="<%=strPresentAddress %>" size="50" maxlength="75"></td>
			<td>&nbsp;</td>
			<td>How long have<br>
			you lived there?</td>
			<td><input type="text" name="PresentTimeThereYears" value="<%=intPresentTimeThereYears %>" size="5" maxlength="2"></td>
			<td>&nbsp;</td>
			<td><input type="text" name="PresentTimeThereMonths" value="<%=intPresentTimeThereMonths %>" size="5" maxlength="2"></td>
		</tr>
		<tr>
			<td>City:</td>
			<td><input type="text" name="PresentCity" value="<%=strPresentCity %>" size="30" maxlength="50"></td>
			<td colspan="2"></td>
			<td valign="top"><p class="tiny">Years</p></td>
			<td></td>
			<td valign="top"><p class="tiny">Months</p></td>
		</tr>
		<tr>
			<td>State:</td>
			<td><input type="text" name="PresentState" value="<%=strPresentState %>" size="5" maxlength="2"></td>
		</tr>
		<tr>
			<td>Previous Address:&nbsp;</td>
			<td><input type="text" name="PreviousAddress" value="<%=strPreviousAddress %>" size="50" maxlength="75"></td>
			<td>&nbsp;</td>
			<td>How long did<br>
			you lived there?</td>
			<td><input type="text" name="PreviousTimeThereYears" value="<%=intPreviousTimeThereYears %>" size="5" maxlength="2"></td>
			<td>&nbsp;</td>
			<td><input type="text" name="PreviousTimeThereMonths" value="<%=intPreviousTimeThereMonths %>" size="5" maxlength="2"></td>
		</tr>
		<tr>
			<td>City:</td>
			<td><input type="text" name="PreviousCity" value="<%=strPreviousCity %>" size="30" maxlength="50"></td>
			<td colspan="2"></td>
			<td valign="top"><p class="tiny">Years</p></td>
			<td></td>
			<td valign="top"><p class="tiny">Months</p></td>
		</tr>
		<tr>
			<td>State:</td>
			<td><input type="text" name="PreviousState" value="<%=strPreviousState %>" size="5" maxlength="2"></td>
		</tr>
		<tr>
			<td nowrap>Telephone Number:&nbsp;</td>
			<td>
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td><input type="text" name="Phone" value="<%=strPhone %>" size="25" maxlength="15"></td>
					<td nowrap align="right">&nbsp;&nbsp;&nbsp;&nbsp;Social Security Number:&nbsp;</td>
				</tr>
			</table>
			</td>
			<td colspan="5"><input type="text" name="SSN" value="<%=strSSN %>" size="25" maxlength="15" ID="Text5"></td>
		</tr>
	</table>
	<br>
	<table cellpadding="0" cellspacing="0" border="0" width="665" align="center">
		<tr>
			<td colspan="2">Have you ever worked for this Company before?&nbsp;
			<% If strWorkedHereBefore = "Yes" Then %>
				<input type="radio" checked name="WorkedHereBefore" value="Yes" id="WorkedHereBeforeYes" style="cursor:hand;"><label for="WorkedHereBeforeYes" style="cursor:hand;">Yes</label>&nbsp;
				<input type="radio" name="WorkedHereBefore" value="No" id="WorkedHereBeforeNo" style="cursor:hand;"><label for="WorkedHereBeforeNo" style="cursor:hand;">No</label></td>
			<% Else %>
				<input type="radio" name="WorkedHereBefore" value="Yes" id="WorkedHereBeforeYes" style="cursor:hand;"><label for="WorkedHereBeforeYes" style="cursor:hand;">Yes</label>&nbsp;
				<input type="radio" checked name="WorkedHereBefore" value="No" id="WorkedHereBeforeNo" style="cursor:hand;"><label for="WorkedHereBeforeNo" style="cursor:hand;">No</label></td>
			<% End If %>
		</tr>
		<tr>
			<td colspan="2">If Yes, please give the date(s) and details:<br>
			<textarea name="WorkedHereBeforeDescription" cols="80" rows="3"><%=strWorkedHereBeforeDescription %></textarea></td>
		</tr>
		<tr>
			<td colspan="2">Have you ever pled guilty or "no contest" to, or been convicted of, a misdemeanor or felony?
			<% If strMisdemeanorOrFelony = "Yes" Then %>
				<input type="radio" checked name="MisdemeanorOrFelony" value="Yes" id="MisdemeanorOrFelonyYes" style="cursor:hand;"><label for="MisdemeanorOrFelonyYes" style="cursor:hand;">Yes</label>&nbsp;
				<input type="radio" name="MisdemeanorOrFelony" value="No" id="MisdemeanorOrFelonyNo" style="cursor:hand;"><label for="MisdemeanorOrFelonyNo" style="cursor:hand;">No</label></td>
			<% Else %>
				<input type="radio" name="MisdemeanorOrFelony" value="Yes" id="MisdemeanorOrFelonyYes" style="cursor:hand;"><label for="MisdemeanorOrFelonyYes" style="cursor:hand;">Yes</label>&nbsp;
				<input type="radio" checked name="MisdemeanorOrFelony" value="No" id="MisdemeanorOrFelonyNo" style="cursor:hand;"><label for="MisdemeanorOrFelonyNo" style="cursor:hand;">No</label></td>
			<% End If %>
		</tr>
		<tr>
			<td colspan="2">If Yes, please give the date(s) and details:<br>
			<textarea name="MisdemeanorOrFelonyDescription" cols="80" rows="3"><%=strMisdemeanorOrFelonyDescription %></textarea><br><br></td>
		</tr>
		<tr valign="top">
			<td>NOTE:&nbsp;&nbsp;</td>
			<td><p style="tiny">Answering "Yes" to these questions does not constitute an automatic bar to employment.&nbsp;&nbsp;
			Factors such as age and time of the offense, seriousness and nature of the violation, and rehabilitation will 
			be taken into account.&nbsp;&nbsp;(Do not include minor traffic citations and arrests or convictions which have been 
			sealed or expunged in answering this question.)</p><br><br></td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" border="0" width="665" align="center">
		<tr>
			<td><b>RECORD OF PREVIOUS EMPLOYMENT</b><br><br>
			Please list the names of your present or previous employers in chronological order with present or last employer listed first.&nbsp;&nbsp;Be sure to account for <u>all</u> periods of time including military service and any period of unemployment.&nbsp;&nbsp;If self-employed, give firm name and supply business references.<br><br></td>
		</tr>
	</table>
	<!-- ###################################################################################################### -->
	<table cellpadding="3" cellspacing="1" border="1" bordercolor="#000000" width="665" align="center">
	<% For i = 0 To 4 %>
		<tr valign="top">
			<td>
			<p class="tiny">Present or Last Employer<br>
			<input type="text" name="EmploymentPast<%=i %>" value="<%=aryEmploymentEmployer(i) %>" size="25" maxlength="60"><br>
			
			Address<br>
			<input type="text" name="EmploymentPastAddress<%=i %>" value="<%=aryEmploymentAddress(i) %>" size="25" maxlength="60"><br>
			
			City<br>
			<input type="text" name="EmploymentPastCity<%=i %>" value="<%=aryEmploymentCity(i) %>" size="20" maxlength="60"></p>
			
			<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td><p class="tiny">State<br>
					<input type="text" name="EmploymentPastState<%=i %>" value="<%=aryEmploymentState(i) %>" size="5" maxlength="2"></p></td>
					<td>&nbsp;</td>
					<td><p class="tiny">Zip Code<br>
					<input type="text" name="EmploymentPastZipCode<%=i %>" value="<%=aryEmploymentZipCode(i) %>" size="6" maxlength="15"></p></td>
				</tr>
			</table>
			</td>
			<td>
			<u>Employed</u><br>
			From (mo/yr)<br>
			<input type="text" name="EmploymentPastFrom<%=i %>" value="<%=aryEmploymentEmployedFrom(i) %>" size="5" maxlength="5"><br>
			To (mo/yr)<br>
			<input type="text" name="EmploymentPastTo<%=i %>" value="<%=aryEmploymentEmployedTo(i) %>" size="5" maxlength="5"><br>
			</td>
			<td>
			<u>Pay Start</u><br>
			<input type="text" name="EmploymentPastPayStart<%=i %>" value="$<%=aryEmploymentPayStart(i) %>" size="5" maxlength="10" value="$"><br>
			
			<u>Pay Final</u><br>
			<input type="text" name="EmploymentPastPayFinal<%=i %>" value="$<%=aryEmploymentPayFinal(i) %>" size="5" maxlength="10" value="$">
			</td>
			<td>
			<u>Your Title or Position</u><br>
			<input type="text" name="EmploymentPastPosition<%=i %>" value="<%=aryEmploymentYourPosition(i) %>" size="30" maxlength="60"><br>
			Name and Title of<br>
			<u>Last Supervisor</u><br>
			<input type="text" name="EmploymentPastSupervisor<%=i %>" value="<%=aryEmploymentLastSupervisor(i) %>" size="30" maxlength="60">
			</td>
			<td>
			<u>Exact Reason for Leaving</u><br>
			<textarea name="EmploymentPastReasonForLeaving<%=i %>" cols="20" rows="3"><%=aryEmploymentReasonForLeaving(i) %></textarea>
			</td>
		</tr><!--####################TABLE<%=i %>############################ -->
	<% Next %>
	</table>
	<table cellpadding="0" cellspacing="0" border="0" width="665" align="center">
		<tr>
			<td><br><br>Have you ever been terminated or asked to resign from any job?&nbsp;&nbsp;
			<% If strTerminated = "Yes" Then %>
				<input type="radio" name="Terminated" value="Yes" checked style="cursor:hand;" id="TerminatedYes"><label for="TerminatedYes" style="cursor:hand;">Yes</label>&nbsp;<input type="radio" name="Terminated" value="No" style="cursor:hand;" id="TerminatedNo"><label for="TerminatedNo" style="cursor:hand;">No</label><br>
			<% Else %>
				<input type="radio" name="Terminated" value="Yes" style="cursor:hand;" id="TerminatedYes"><label for="TerminatedYes" style="cursor:hand;">Yes</label>&nbsp;<input type="radio" checked name="Terminated" value="No" style="cursor:hand;" id="TerminatedNo"><label for="TerminatedNo" style="cursor:hand;">No</label><br>
			<% End If %>
			If Yes, please explain circumstances:<br>
			<textarea name="TerminatedCircumstances" cols="70" rows="4"><%=strTerminatedCircumstances %></textarea><br><br>
			
			Please explain fully any gaps in your employment history:<br>
			<textarea name="EmploymentGaps" cols="70" rows="4"><%=strEmploymentGaps %></textarea><br><br>
			
			May we contact your current employer?&nbsp;&nbsp;
			<% If strContactPastEmployer = "Yes" Then %>
				<input type="radio" name="ContactPastEmployer" checked value="Yes" style="cursor:hand;" id="ContactPastEmployerYes"><label for="ContactPastEmployerYes" style="cursor:hand;">Yes</label>&nbsp;<input type="radio" name="ContactPastEmployer" value="No" style="cursor:hand;" id="ContactPastEmployerNo"><label for="ContactPastEmployerNo" style="cursor:hand;">No</label><br>
			<% Else %>
				<input type="radio" name="ContactPastEmployer" value="Yes" style="cursor:hand;" id="ContactPastEmployerYes"><label for="ContactPastEmployerYes" style="cursor:hand;">Yes</label>&nbsp;<input type="radio" checked name="ContactPastEmployer" value="No" style="cursor:hand;" id="ContactPastEmployerNo"><label for="ContactPastEmployerNo" style="cursor:hand;">No</label><br>
			<% End If %>
			If No, please explain:<br>
			<textarea name="ContactPastEmployerDescription" cols="70" rows="4"><%=strContactPastEmployerDescription %></textarea><br><br>
			
			Please indicate any actual experience, special training and qualifications that you have which you feel are relevant to the position for which you are applying.<br>
			<textarea name="QualificationExperience" cols="70" rows="4"><%=strQualificationExperience %></textarea><br><br>
			
			Have you ever used another name?&nbsp;&nbsp;
			<% If strAnotherName = "Yes" Then %>
				<input type="radio" name="AnotherName" checked value="Yes" style="cursor:hand;" id="AnotherNameYes"><label for="AnotherNameYes" style="cursor:hand;">Yes</label>&nbsp;<input type="radio" name="AnotherName" value="No" style="cursor:hand;" id="AnotherNameNo"><label for="AnotherNameNo" style="cursor:hand;">No</label><br>
			<% Else %>
				<input type="radio" name="AnotherName" value="Yes" style="cursor:hand;" id="AnotherNameYes"><label for="AnotherNameYes" style="cursor:hand;">Yes</label>&nbsp;<input type="radio" checked name="AnotherName" value="No" style="cursor:hand;" id="AnotherNameNo"><label for="AnotherNameNo" style="cursor:hand;">No</label><br>
			<% End If %>
			Is any additional information relative to change of name, use of an assumed name, or<br>
			nickname necessary to enable a check on your work and educational record?&nbsp;&nbsp;If yes, please explain:<br>
			<textarea name="AnotherNameDescription" cols="70" rows="4"><%=strAnotherNameDescription %></textarea><br><br>
			
			If hired, can you furnish proof that you are over 18 years of age?&nbsp;&nbsp;
			<% If strOver18Proof = "Yes" Then %>
				<input type="radio" name="Over18Proof" checked value="Yes" style="cursor:hand;" id="Over18ProofYes"><label for="Over18ProofYes" style="cursor:hand;">Yes</label>&nbsp;<input type="radio" name="Over18Proof" value="No" style="cursor:hand;" id="Over18ProofNo"><label for="Over18ProofNo" style="cursor:hand;">No</label><br><br>
			<% Else %>
				<input type="radio" name="Over18Proof" value="Yes" style="cursor:hand;" id="Over18ProofYes"><label for="Over18ProofYes" style="cursor:hand;">Yes</label>&nbsp;<input type="radio" checked name="Over18Proof" value="No" style="cursor:hand;" id="Over18ProofNo"><label for="Over18ProofNo" style="cursor:hand;">No</label><br><br>
			<% End If %>
			
			Are you capable of satisfactorily performing the essential job duties required of the position for which you are applying?<br>
			<% If strPerformJobDuties = "Yes" Then %>
				<input type="radio" name="PerformJobDuties" checked value="Yes" style="cursor:hand;" id="PerformJobDutiesYes"><label for="PerformJobDutiesYes" style="cursor:hand;">Yes</label>&nbsp;<input type="radio" name="PerformJobDuties" value="No" style="cursor:hand;" id="PerformJobDutiesNo"><label for="PerformJobDutiesNo" style="cursor:hand;">No</label><br><br>
			<% Else %>
				<input type="radio" name="PerformJobDuties" value="Yes" style="cursor:hand;" id="PerformJobDutiesYes"><label for="PerformJobDutiesYes" style="cursor:hand;">Yes</label>&nbsp;<input type="radio" checked name="PerformJobDuties" value="No" style="cursor:hand;" id="PerformJobDutiesNo"><label for="PerformJobDutiesNo" style="cursor:hand;">No</label><br><br>
			<% End If %>
			
			Do you have adequate transportation to and from work?&nbsp;&nbsp;
			<% If strAdequateTransportation = "Yes" Then %>
				<input type="radio" checked name="AdequateTransportation" value="Yes" style="cursor:hand;" id="AdequateTransportationYes"><label for="AdequateTransportationYes" style="cursor:hand;">Yes</label>&nbsp;<input type="radio" name="AdequateTransportation" value="No" style="cursor:hand;" id="AdequateTransportationNo"><label for="AdequateTransportationNo" style="cursor:hand;">No</label><br><br>
			<% Else %>
				<input type="radio" name="AdequateTransportation" value="Yes" style="cursor:hand;" id="AdequateTransportationYes"><label for="AdequateTransportationYes" style="cursor:hand;">Yes</label>&nbsp;<input type="radio" checked name="AdequateTransportation" value="No" style="cursor:hand;" id="AdequateTransportationNo"><label for="AdequateTransportationNo" style="cursor:hand;">No</label><br><br>
			<% End If %>
			
			How many days of work have you missed in the last three years due to reasons other than paid holidays and vacation?
			<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td><input type="text" name="DaysMissedYear0" value="<%=strDaysMissedYear0 %>" size="5" maxlength="4"></td>
					<td>&nbsp;</td>
					<td><input type="text" name="DaysMissedNumberOfDays0" value="<%=strDaysMissedNumberOfDays0 %>" size="15" maxlength="2"></td>
				</tr>
				<tr>
					<td align="center">YEAR</td>
					<td></td>
					<td align="center">NUMBER OF DAYS</td>
				</tr>
				<tr>
					<td colspan="3"><span style="font-size:6px;">&nbsp;</span></td>
				</tr>
				<!-- ##################################################### -->
				<tr>
					<td><input type="text" name="DaysMissedYear1" value="<%=strDaysMissedYear1 %>" size="5" maxlength="4" ID="Text1"></td>
					<td>&nbsp;</td>
					<td><input type="text" name="DaysMissedNumberOfDays1" value="<%=strDaysMissedNumberOfDays1 %>" size="15" maxlength="2" ID="Text2"></td>
				</tr>
				<tr>
					<td align="center">YEAR</td>
					<td></td>
					<td align="center">NUMBER OF DAYS</td>
				</tr>
				<tr>
					<td colspan="3"><span style="font-size:6px;">&nbsp;</span></td>
				</tr>
				<!-- ##################################################### -->
				<tr>
					<td><input type="text" name="DaysMissedYear2" value="<%=strDaysMissedYear2 %>" size="5" maxlength="4" ID="Text3"></td>
					<td>&nbsp;</td>
					<td><input type="text" name="DaysMissedNumberOfDays2" value="<%=strDaysMissedNumberOfDays2 %>" size="15" maxlength="2" ID="Text4"></td>
				</tr>
				<tr>
					<td align="center">YEAR</td>
					<td></td>
					<td align="center">NUMBER OF DAYS</td>
				</tr>
				<tr>
					<td colspan="3"><span style="font-size:6px;">&nbsp;</span></td>
				</tr>
			</table>
			<br><br></td>
		</tr>
	</table>
	<table cellpadding="3" cellspacing="1" border="1" bordercolor="#000000" width="665" align="center">
		<tr style="font-weight:bold;">
			<td align="center">School Name</td>
			<td align="center">Years<br>
			Completed</td>
			<td align="center">Diploma/Degree</td>
			<td align="center">Describe Course<br>
			of Study or Major</td>
			<td align="center">Describe Specialized<br>
			Training, Experience,<br>
			Skills and Extra-Curricular<br>
			Activities</td>
		</tr>
		<!-- ############################################################################################## -->
		<tr>
			<td>Elementary:<br>
			<input type="text" name="ElementarySchoolName" value="<%=strSchoolName0 %>" size="17" maxlength="50"></td>
			<td>
			<table cellpadding="0" cellspacing="0" border="0" align="center">
				<tr>
					<td align="center"><input type="radio" <% If strYearsCompleted0 = "4" Then %>checked<% End If %> name="ElementaryYearsCompleted" value="4" id="ElementaryYearsCompleted4" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted0 = "5" Then %>checked<% End If %> name="ElementaryYearsCompleted" value="5" id="ElementaryYearsCompleted5" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted0 = "6" Then %>checked<% End If %> name="ElementaryYearsCompleted" value="6" id="ElementaryYearsCompleted6" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted0 = "7" Then %>checked<% End If %> name="ElementaryYearsCompleted" value="7" id="ElementaryYearsCompleted7" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted0 = "8" Then %>checked<% End If %> name="ElementaryYearsCompleted" value="8" id="ElementaryYearsCompleted8" style="cursor:hand;"></td>
				</tr>
				<tr>
					<td align="center"><label for="ElementaryYearsCompleted4" style="cursor:hand;">&nbsp;4&nbsp;</label></td>
					<td align="center"><label for="ElementaryYearsCompleted5" style="cursor:hand;">&nbsp;5&nbsp;</label></td>
					<td align="center"><label for="ElementaryYearsCompleted6" style="cursor:hand;">&nbsp;6&nbsp;</label></td>
					<td align="center"><label for="ElementaryYearsCompleted7" style="cursor:hand;">&nbsp;7&nbsp;</label></td>
					<td align="center"><label for="ElementaryYearsCompleted8" style="cursor:hand;">&nbsp;8&nbsp;</label></td>
				</tr>
			</table>
			</td>
			<td><input type="text" name="ElementaryDegreeReceived" value="<%=strDegreeReceived0 %>" size="13" maxlength="60"></td>
			<td><input type="text" name="ElementaryMajor" value="<%=strMajor0 %>" size="17" maxlength="60"></td>
			<td><textarea name="ElementarySpecializedTraining" cols="20" rows="3"><%=strSpecializedTraining0 %></textarea></td>
		</tr>
		<!-- ############################################################################################ -->
		<tr>
			<td>High School:<br>
			<input type="text" name="HighSchoolSchoolName" value="<%=strSchoolName1 %>" size="17" maxlength="50"></td>
			<td>
			<table cellpadding="0" cellspacing="0" border="0" align="center">
				<tr>
					<td align="center"><input type="radio" <% If strYearsCompleted1 = "9" Then %>checked<% End If %> name="HighSchoolYearsCompleted" value="9" id="HighSchoolYearsCompleted9" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted1 = "10" Then %>checked<% End If %> name="HighSchoolYearsCompleted" value="10" id="HighSchoolYearsCompleted10" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted1 = "11" Then %>checked<% End If %> name="HighSchoolYearsCompleted" value="11" id="HighSchoolYearsCompleted11" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted1 = "12" Then %>checked<% End If %> name="HighSchoolYearsCompleted" value="12" id="HighSchoolYearsCompleted512" style="cursor:hand;"></td>
				</tr>
				<tr>
					<td align="center"><label for="HighSchoolYearsCompleted9" style="cursor:hand;">&nbsp;9&nbsp;</label></td>
					<td align="center"><label for="HighSchoolYearsCompleted10" style="cursor:hand;">&nbsp;10&nbsp;</label></td>
					<td align="center"><label for="HighSchoolYearsCompleted11" style="cursor:hand;">&nbsp;11&nbsp;</label></td>
					<td align="center"><label for="HighSchoolYearsCompleted12" style="cursor:hand;">&nbsp;12&nbsp;</label></td>
				</tr>
			</table>
			</td>
			<td><input type="text" name="HighSchoolDegreeReceived" value="<%=strDegreeReceived1 %>" size="13" maxlength="60"></td>
			<td><input type="text" name="HighSchoolMajor" value="<%=strMajor1 %>" size="17" maxlength="60"></td>
			<td><textarea name="HighSchoolSpecializedTraining" cols="20" rows="3"><%=strSpecializedTraining1 %></textarea></td>
		</tr>
		<!-- ############################################################################################ -->
		<tr>
			<td>College/University:<br>
			<input type="text" name="UniversitySchoolName" value="<%=strSchoolName2 %>" size="17" maxlength="50"></td>
			<td>
			<table cellpadding="0" cellspacing="0" border="0" align="center">
				<tr>
					<td align="center"><input type="radio" <% If strYearsCompleted2 = "1" Then %>checked<% End If %> name="UniversityYearsCompleted" value="1" id="UniversityYearsCompleted1" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted2 = "2" Then %>checked<% End If %> name="UniversityYearsCompleted" value="2" id="UniversityYearsCompleted2" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted2 = "3" Then %>checked<% End If %> name="UniversityYearsCompleted" value="3" id="UniversityYearsCompleted3" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted2 = "4" Then %>checked<% End If %> name="UniversityYearsCompleted" value="4" id="UniversityYearsCompleted4" style="cursor:hand;"></td>
				</tr>
				<tr>
					<td align="center"><label for="UniversityYearsCompleted1" style="cursor:hand;">&nbsp;1&nbsp;</label></td>
					<td align="center"><label for="UniversityYearsCompleted2" style="cursor:hand;">&nbsp;2&nbsp;</label></td>
					<td align="center"><label for="UniversityYearsCompleted3" style="cursor:hand;">&nbsp;3&nbsp;</label></td>
					<td align="center"><label for="UniversityYearsCompleted4" style="cursor:hand;">&nbsp;4&nbsp;</label></td>
				</tr>
			</table>
			</td>
			<td><input type="text" name="UniversityDegreeReceived" value="<%=strDegreeReceived2 %>" size="13" maxlength="60"></td>
			<td><input type="text" name="UniversityMajor" value="<%=strMajor2 %>" size="17" maxlength="60"></td>
			<td><textarea name="UniversitySpecializedTraining" cols="20" rows="3"><%=strSpecializedTraining2 %></textarea></td>
		</tr>
		<!-- ############################################################################################ -->
		<tr>
			<td>Graduate/Professional:<br>
			<input type="text" name="GraduateSchoolName" value="<%=strSchoolName3 %>" size="17" maxlength="50"></td>
			<td>
			<table cellpadding="0" cellspacing="0" border="0" align="center">
				<tr>
					<td align="center"><input type="radio" <% If strYearsCompleted3 = "1" Then %>checked<% End If %> name="GraduateYearsCompleted" value="1" id="GraduateYearsCompleted1" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted3 = "2" Then %>checked<% End If %> name="GraduateYearsCompleted" value="2" id="GraduateYearsCompleted2" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted3 = "3" Then %>checked<% End If %> name="GraduateYearsCompleted" value="3" id="GraduateYearsCompleted3" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted3 = "4" Then %>checked<% End If %> name="GraduateYearsCompleted" value="4" id="GraduateYearsCompleted4" style="cursor:hand;"></td>
				</tr>
				<tr>
					<td align="center"><label for="GraduateYearsCompleted1" style="cursor:hand;">&nbsp;1&nbsp;</label></td>
					<td align="center"><label for="GraduateYearsCompleted2" style="cursor:hand;">&nbsp;2&nbsp;</label></td>
					<td align="center"><label for="GraduateYearsCompleted3" style="cursor:hand;">&nbsp;3&nbsp;</label></td>
					<td align="center"><label for="GraduateYearsCompleted4" style="cursor:hand;">&nbsp;4&nbsp;</label></td>
				</tr>
			</table>
			</td>
			<td><input type="text" name="GraduateDegreeReceived" value="<%=strDegreeReceived3 %>" size="13" maxlength="60"></td>
			<td><input type="text" name="GraduateMajor" value="<%=strMajor3 %>" size="17" maxlength="60"></td>
			<td><textarea name="GraduateSpecializedTraining" cols="20" rows="3"><%=strSpecializedTraining3 %></textarea></td>
		</tr>
		<!-- ############################################################################################ -->
		<tr>
			<td>Trade or Correspondence:<br>
			<input type="text" name="TradeSchoolName" value="<%=strSchoolName4 %>" size="17" maxlength="50" ID="Text10"></td>
			<td>
			<table cellpadding="0" cellspacing="0" border="0" align="center" ID="Table3">
				<tr>
					<td align="center"><input type="radio" <% If strYearsCompleted4 = "1" Then %>checked<% End If %> name="TradeYearsCompleted" value="1" id="TradeYearsCompleted1" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted4 = "2" Then %>checked<% End If %> name="TradeYearsCompleted" value="2" id="TradeYearsCompleted2" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted4 = "3" Then %>checked<% End If %> name="TradeYearsCompleted" value="3" id="TradeYearsCompleted3" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted4 = "4" Then %>checked<% End If %> name="TradeYearsCompleted" value="4" id="TradeYearsCompleted4" style="cursor:hand;"></td>
				</tr>
				<tr>
					<td align="center"><label for="TradeYearsCompleted1" style="cursor:hand;">&nbsp;1&nbsp;</label></td>
					<td align="center"><label for="TradeYearsCompleted2" style="cursor:hand;">&nbsp;2&nbsp;</label></td>
					<td align="center"><label for="TradeYearsCompleted3" style="cursor:hand;">&nbsp;3&nbsp;</label></td>
					<td align="center"><label for="TradeYearsCompleted4" style="cursor:hand;">&nbsp;4&nbsp;</label></td>
				</tr>
			</table>
			</td>
			<td><input type="text" name="TradeDegreeReceived" value="<%=strDegreeReceived4 %>" size="13" maxlength="60"></td>
			<td><input type="text" name="TradeMajor" value="<%=strMajor4 %>" size="17" maxlength="60"></td>
			<td><textarea name="TradeSpecializedTraining" cols="20" rows="3"><%=strSpecializedTraining4 %></textarea></td>
		</tr>
		<!-- ############################################################################################ -->
		<tr>
			<td>Other:<br>
			<input type="text" name="OtherSchoolName" value="<%=strSchoolName5 %>" size="17" maxlength="50"></td>
			<td>
			<table cellpadding="0" cellspacing="0" border="0" align="center">
				<tr>
					<td align="center"><input type="radio" <% If strYearsCompleted5 = "1" Then %>checked<% End If %> name="OtherYearsCompleted" value="1" id="OtherYearsCompleted1" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted5 = "2" Then %>checked<% End If %> name="OtherYearsCompleted" value="2" id="OtherYearsCompleted2" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted5 = "3" Then %>checked<% End If %> name="OtherYearsCompleted" value="3" id="OtherYearsCompleted3" style="cursor:hand;"></td>
					<td align="center"><input type="radio" <% If strYearsCompleted5 = "4" Then %>checked<% End If %> name="OtherYearsCompleted" value="4" id="OtherYearsCompleted4" style="cursor:hand;"></td>
				</tr>
				<tr>
					<td align="center"><label for="OtherYearsCompleted1" style="cursor:hand;">&nbsp;1&nbsp;</label></td>
					<td align="center"><label for="OtherYearsCompleted2" style="cursor:hand;">&nbsp;2&nbsp;</label></td>
					<td align="center"><label for="OtherYearsCompleted3" style="cursor:hand;">&nbsp;3&nbsp;</label></td>
					<td align="center"><label for="OtherYearsCompleted4" style="cursor:hand;">&nbsp;4&nbsp;</label></td>
				</tr>
			</table>
			</td>
			<td><input type="text" name="OtherDegreeReceived" value="<%=strDegreeReceived5 %>" size="13" maxlength="60"></td>
			<td><input type="text" name="OtherMajor" value="<%=strMajor5 %>" size="17" maxlength="60"></td>
			<td><textarea name="OtherSpecializedTraining" cols="20" rows="3"><%=strSpecializedTraining5 %></textarea></td>
		</tr>
		<!-- ############################################################################################ -->
	</table>
	<table cellpadding="0" cellspacing="0" border="0" width="665" align="center">
		<tr>
			<td><br><font style="font-size:12px; font-weight:bold;">PERSONAL REFERENCES</font><br>
			Please list persons who know you well - <b>not</b> previous employers or relatives.<br><br></td>
		</tr>
	</table>
	<table cellpadding="3" cellspacing="1" border="1" bordercolor="#000000" width="665" align="center">
		<tr style="font-weight:bold;">
			<td>Name</td>
			<td align="center">Occupation</td>
			<td align="center">Address</td>
			<td align="center">Telephone<br>
			Number</td>
			<td align="center">Number of<br>
			Years<br>
			Known</td>
		</tr>
		<!-- ############################################################################################ -->
		<tr>
			<td><input type="text" name="EmploymentReferenceName0" value="<%=strName0 %>" size="20" maxlength="60"></td>
			<td><input type="text" name="EmploymentReferenceOccupation0" value="<%=strOccupation0 %>" size="20" maxlength="60"></td>
			<td>
			<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td colspan="2">Address:</td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" name="EmploymentReferenceAddress0" value="<%=strAddress0 %>" size="30" maxlength="75"></td>
				</tr>
				<tr>
					<td>City:</td>
					<td>State:</td>
				</tr>
				<tr>
					<td><input type="text" name="EmploymentReferenceCity0" value="<%=strCity0 %>" size="20" maxlength="50"></td>
					<td><input type="text" name="EmploymentReferenceState0" value="<%=strState0 %>" size="5" maxlength="2"></td>
				</tr>
			</table>
			</td>
			<td align="center"><input type="text" name="EmploymentReferencePhone0" value="<%=strPhone0 %>" size="15" maxlength="15"></td>
			<td align="center"><input type="text" name="EmploymentReferenceYearsKnown0" value="<%=strYearsKnown0 %>" size="5" maxlength="2"></td>
		</tr>
		<!-- ############################################################################################ -->
		<tr>
			<td><input type="text" name="EmploymentReferenceName1" value="<%=strName1 %>" size="20" maxlength="60"></td>
			<td><input type="text" name="EmploymentReferenceOccupation1" value="<%=strOccupation1 %>" size="20" maxlength="60"></td>
			<td>
			<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td colspan="2">Address:</td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" name="EmploymentReferenceAddress1" value="<%=strAddress1 %>" size="30" maxlength="75"></td>
				</tr>
				<tr>
					<td>City:</td>
					<td>State:</td>
				</tr>
				<tr>
					<td><input type="text" name="EmploymentReferenceCity1" value="<%=strCity1 %>" size="20" maxlength="50"></td>
					<td><input type="text" name="EmploymentReferenceState1" value="<%=strState1 %>" size="5" maxlength="2"></td>
				</tr>
			</table>
			</td>
			<td align="center"><input type="text" name="EmploymentReferencePhone1" value="<%=strPhone1 %>" size="15" maxlength="15"></td>
			<td align="center"><input type="text" name="EmploymentReferenceYearsKnown1" value="<%=strYearsKnown1 %>" size="5" maxlength="2"></td>
		</tr>
		<!-- ############################################################################################ -->
		<tr>
			<td><input type="text" name="EmploymentReferenceName2" value="<%=strName2 %>" size="20" maxlength="60"></td>
			<td><input type="text" name="EmploymentReferenceOccupation2" value="<%=strOccupation2 %>" size="20" maxlength="60"></td>
			<td>
			<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td colspan="2">Address:</td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" name="EmploymentReferenceAddress2" value="<%=strAddress2 %>" size="30" maxlength="75"></td>
				</tr>
				<tr>
					<td>City:</td>
					<td>State:</td>
				</tr>
				<tr>
					<td><input type="text" name="EmploymentReferenceCity2" value="<%=strCity2 %>" size="20" maxlength="50"></td>
					<td><input type="text" name="EmploymentReferenceState2" value="<%=strState2 %>" size="5" maxlength="2"></td>
				</tr>
			</table>
			</td>
			<td align="center"><input type="text" name="EmploymentReferencePhone2" value="<%=strPhone2 %>" size="15" maxlength="15"></td>
			<td align="center"><input type="text" name="EmploymentReferenceYearsKnown2" value="<%=strYearsKnown2 %>" size="5" maxlength="2"></td>
		</tr>
		<!-- ############################################################################################ -->
	</table>
	<br><br>
	<table cellpadding="0" cellspacing="0" border="0" width="665" align="center">
		<tr>
			<td colspan="3">
			<% If Len(strResume) = 0 Then
				Response.Write("<p>Attach Resume: <input type=""file"" name=""File1"" Size=""45""><br><br></p>" & vbNewLine)
			Else
				Response.Write("<p><input type=""hidden"" name=""Resume"" value=""" & strResume & """><a href=""http://" & Request.ServerVariables("Server_Name") & "/application/data/" & strResume & """ target=""_blank"">View Attached Resume</a><br><br></p>" & vbNewLine)
			End If %>
			</td>
		</tr>
	</table>
	<br><br>
	<!-- #############################THECUTOFFPOINT####################################### -->
	<table cellpadding="0" cellspacing="0" border="0" width="665" align="center" ID="Table1">
		<tr>
			<td><font style="font-size:12px; font-weight:bold;">THIS APPLICATION WILL BE CONSIDERED ACTIVE FOR A MAXIMUM OF NINETY (90) DAYS.&nbsp;&nbsp;IF YOU WISH TO BE CONSIDERED FOR 
			EMPLOYMENT AFTER THAT TIME, YOU MUST REAPPLY.<br><br>
			
			I CERTIFY THAT ALL OF THE INFORMATION THAT I HAVE PROVIDED ON THIS APPLICATION IS TRUE AND ACCURATE.</font></td>
		</tr>
	</table>
	<br><br>
	<table cellpadding="0" cellspacing="0" border="0" width="665" align="center">
		<tr>
			<td>
			<center><b><u>APPLICANT'S STATEMENT & AGREEMENT</u></b><br><br></center>
			<p style="font-size:12px;">
			In the event of my employment to a position in this Company, I will comply with all rules and regulations of 
			this Company.&nbsp;&nbsp;I understand that the Company reserves the right to require me to submit to a test for the 
			presence of drugs in my system prior to employment and at any time during my employment, to the extent 
			permitted by law.&nbsp;&nbsp;I also understand that any offer of employment may be contingent upon the passing of a 
			physical examination.&nbsp;&nbsp;I consent to the disclosure of the results of any physical examination and related 
			tests to the Company.&nbsp;&nbsp;I also understand that I may be required to take other tests such as personality and 
			honesty tests, prior to employment and during my employment.&nbsp;&nbsp;I understand that should I decline to sign this 
			consent or decline to take any of the above tests, my application for employment may be rejected or my 
			employment may be terminated.&nbsp;&nbsp;I understand that bonding may be a condition of hire.&nbsp;&nbsp;If it is, I will be so 
			advised either before or after hiring and a bond application will have to be completed.<br><br>
			
			I understand that the Company may investigate my driving record and my criminal record and that an 
			investigative consumer report may be prepared whereby information is obtained through personal 
			interviews with my neighbors, friends, personal references, and others with whom I am acquainted.&nbsp;&nbsp;
			This inquiry includes information as to my character, general reputation, personal characteristics 
			and mode of living.&nbsp;&nbsp;I understand that I have the right to make a written inquiry within a reasonable 
			period of time to receive additional detailed information about the nature and scope of this 
			investigation.&nbsp;&nbsp;I further understand that the Company may contact my previous employers and I 
			authorize those employers to disclose to the Company all records and information pertinent to my 
			employment with them.&nbsp;&nbsp;In addition to authorizing the release of any information regarding my employment, 
			I hereby fully waive any rights or claims I have or may have against my former employers, their agents, 
			employees and representatives, as well as other individuals who release information to the Company, and 
			release them from any and all liability, claims, or damages that may directly or indirectly result from the 
			use, disclosure, or release of any such information by any person or party, whether such information is 
			favorable or unfavorable to me.&nbsp;&nbsp;I authorize the persons named herein as personal references to provide 
			the Company with any pertinent information they may have regarding myself.&nbsp;&nbsp;I hereby state that all the 
			information that I provided on this application or any other documents filled out in connection with my 
			employment, and in any interview is true and correct.&nbsp;&nbsp;I have withheld nothing that would, if disclosed, 
			affect this application unfavorably.&nbsp;&nbsp;I understand that if I am employed and any such information is later 
			found to be false or incomplete in any respect, I may be dismissed.&nbsp;&nbsp;I understand if selected for hire, it 
			will be necessary for me to provide satisfactory evidence of my identity and legal authority to work in 
			the United States, and that federal immigration laws require me to complete an I-9 Form in this regard.&nbsp;&nbsp;
			I further agree and acknowledge that the Company and I will utilize binding arbitration to resolve all 
			disputes that may arise out of the employment context.&nbsp;&nbsp;Both the Company and I agree that any claim, dispute, 
			and/or controversy that either I may have against the Company (or its owners, directors, officers, managers, 
			employees, agents, and parties affiliated with its employee benefit and health plans) or the Company may have 
			against me, arising from, related to, or having any relationship or connection whatsoever with my seeking 
			employment with, employment by, or other association with the Company shall be submitted to and determined 
			exclusively by binding arbitration under the Federal Arbitration Act, in conformity with the procedures 
			of the Consolidated Pennsylvania Statutes, Chapter 42, Section 7301 et seq.&nbsp;&nbsp;and all of the Act�s other 
			mandatory and permissive rights to discovery.&nbsp;&nbsp;Included within the scope of this Agreement are all disputes, 
			whether based on tort, contract, statute (including, but not limited to, any claims of discrimination and 
			harassment, whether they be based on the Pennsylvania Human Relations Act, Title VII of the Civil Rights 
			Act of 1964, as amended, or any other state or federal law or regulation), equitable law, or otherwise, 
			with exception of claims arising under the National Labor Relations Act which are brought before the 
			National Labor Relations Board, claims for medical and disability benefits under the Pennsylvania Workers� 
			Compensation Act, Pennsylvania Unemployment Compensation claims, or as otherwise required by state or 
			federal law.&nbsp;&nbsp;However, nothing herein shall prevent me from filing and pursuing proceedings before the 
			Pennsylvania Human Relations Commission, or the United States Equal Employment Opportunity Commission 
			(although if I choose to pursue a claim following the exhaustion of such administrative remedies, that 
			claim would be subject to the provisions of this Agreement).&nbsp;&nbsp;In addition to any other requirements 
			imposed by law, the arbitrator selected shall be a retired Pennsylvania Commonwealth Court Judge, or 
			otherwise qualified individual to whom the parties mutually agree, and shall be subject to 
			disqualification on the same grounds as would apply to a judge of such court.&nbsp;&nbsp;All rules of pleading, all 
			rules of evidence, all rights to resolution of the dispute by means of motions for summary judgment and 
			judgment on the pleadings, shall apply and be observed.&nbsp;&nbsp;Resolution of the dispute shall be based solely 
			upon the law governing the claims and defenses pleaded, and the arbitrator may not invoke any basis 
			(including but not limited to, notions of "just cause") other than such controlling law.&nbsp;&nbsp;The arbitrator 
			shall have the immunity of a judicial officer from civil liability when acting in the capacity of an 
			arbitrator, which immunity supplements any other existing immunity.&nbsp;&nbsp;Likewise, all communications during 
			or in connection with the arbitration proceedings are privileged.&nbsp;&nbsp;As reasonably required to allow full 
			use and benefit of this agreement's modifications to the Act�s procedures, the arbitrator shall extend 
			the times set by the Act for the giving of notices and setting of hearings.&nbsp;&nbsp;Awards shall include the 
			arbitrator's written reasoned opinion.&nbsp;&nbsp;I understand and agree to this binding arbitration provision, 
			and both I and the Company give up our right to trial by jury of any claim I or the Company may have 
			against each other.<br><br>
			
			If hired, I agree as follows: My employment and compensation is terminable at-will, is for no definite period, 
			and my employment and compensation may be terminated by either the Company (employer) or me at any time and 
			for any reason whatsoever, with or without good cause.<br><br>
			
			This is the entire agreement between the Company and me regarding dispute resolution, the length of my 
			employment, and the reasons for termination of employment, and this agreement supersedes any and all 
			prior agreements regarding these issues.&nbsp;&nbsp;It is further agreed and understood that any agreement contrary 
			to the foregoing must be entered into, in writing, by the President of the Company.&nbsp;&nbsp;No supervisor or 
			representative of the Company, other than its President, has any authority to enter into any agreement 
			for employment for any specified period of time or make any agreement contrary to the foregoing.&nbsp;&nbsp;Oral 
			representations made before or after you are hired do not alter this Agreement.<br><br>
			
			If any term or provision, or portion of this Agreement is declared void or unenforceable it 
			shall be severed and the remainder of this Agreement shall be enforceable.<br><br>
			
			If you have any questions regarding this statement, please ask a Company representative before signing.&nbsp;&nbsp;I hereby 
			acknowledge that I have read the above statements and understand the same.</p></td>
		</tr>
	</table>
	<br><br>
	<table cellpadding="0" cellspacing="0" border="0" width="665" align="center">
		<tr>
			<td><p style="font-size:12px; font-weight:bold;"><input type="checkbox" name="Agree" value="checked" id="Agree" style="cursor:hand;"><label for="Agree" style="cursor:hand;">I HAVE READ THE ABOVE STATEMENT & AGREEMENT.</label></p>
			<input type="submit" value="Submit Application" style="font-size:13px; cursor:hand;"></td>
		</tr>
	</table>
	</form>
	</body>
</html>