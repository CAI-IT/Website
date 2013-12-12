<% Response.ContentType = "text/css" %>
A:link    { color: #006699; text-decoration: underline; }
A:active  { color: #006699; text-decoration: none; }
A:visited { color: #006699; text-decoration: underline; }
A:hover   { color: #666666; text-decoration: underline; }
<%
comActNORed = "#9A0034"
comActORed = "#990033"
comActNOBlue = "#32659A"
comActOBlue = "#336699"
%>

body {
font-family:arial; 
font-size:12px; 
text-decoration:none; 
color:#000000;
background-color:#FFFFFF;
}
.done {text-decoration:line-through;}
.withdrawn {color:RGB(172, 168, 153); font-style:italic;}
img {border: 0px;}
table {
	border-collapse: collapse;
	width: 100%;
}
table, td {
	border: 1px solid #FFFFFF;
	padding: 3px; 
	vertical-align: top;
}
td.label {
	font-weight:bold;
	text-align:right;
}
table {
	border-bottom:1px solid black;
}
tr.emphasis {
	background-color:#9BB4CF;
}
th {
	font-weight:bold;
	font-family: arial;
	color:#FFFFFF;
	text-align:left;
	background-color:<%=comActOBlue%>;
}
input {
	font-weight:bold;
	font-family: arial;
}
textarea {
	font-weight:bold;
	font-family: arial;
	width: 450px;
	height: 85px;
}
select {
	font-weight:bold;
	font-family: arial;
}
/*
body input {background-color: #006699; color:#FFFFFF; font-weight:bold; font-family: arial;}
*/
.COLD { background-Color:#ffcc99; color:#006699; }
.HOT { background-Color:#32659A; color:#9A0034; test-align:center;} 

.pastDue {
	background-color:<%=comActORed%>;/*#D00000;*/
	/*color:#9A0034;*/
	color:#FFFFFF;
	font-weight:bold;
}

div.detailIco {
	display:inline;
	width:24px;
	text-align:center;
	vertical-align:middle;
	border-style:solid;
	border-width:0px;
}