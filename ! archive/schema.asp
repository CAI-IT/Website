<html>
<body>
<%
Set Session("sesConn") = Server.CreateObject("ADODB.Connection")
connStr = "Provider=SQLOLEDB.1;Password=jcceoa;Persist Security Info=True;User ID=admin;Initial Catalog=CAAFACSPA-2007-04-19;Data Source=web"
Session("sesConn").open connStr
Set conn = Session("sesConn")
Session.Timeout = 360


SQL2 = "SELECT tab.name table_name, ind.name constraint_name, INDEX_COL(tab.name, ind.indid, idk.keyno) column_name, idk.keyno pos FROM sysobjects tab, sysindexes ind, sysindexkeys idk WHERE ind.status & 0x800 = 0x800 AND ind.id = tab.id AND idk.id = tab.id AND idk.indid = ind.indid AND tab.name = 'undefined' ORDER BY 1, 2, 4"
SQL1 = "SELECT tab.name table_name FROM sysobjects tab WHERE tab.xtype = 'U' AND tab.name <> 'dtproperties' ORDER BY 1"

set rs = conn.execute(SQL1)

response.Write(rs("table_name"))

%>

</body>
</html>