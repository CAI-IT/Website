<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<body>
<%
y = DatePart("yyyy",date)
m = DatePart("m",date)
If len(m) = 1 Then
	m = "0"&m
End If
d = DatePart("d",date)
If len(d) = 1 Then
	d = "0"&d
End If
parsedDate = y&"."&m&"."&d
response.Redirect("mailto:rcardamone@jccap.org?cc=jelkin@jccap.org&subject=summary%20"&parsedDate)
%>
</body>
</html>
