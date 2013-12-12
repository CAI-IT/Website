
<%@LANGUAGE="JAVASCRIPT"  EnableSessionState="FALSE"%>
<%
	
	sConn = "Provider=SQLOLEDB.1;Password=jcceoa;Persist Security Info=True;User ID=admin;Initial Catalog=intranet;Data Source=webserver;"

	var conn = Server.CreateObject("ADODB.Connection");


	if (String(Request.QueryString("table")) != "undefined") {
		
		sSQL = " SELECT tab.name   table_name, ";
		sSQL += "        col.name   column_name, ";
		sSQL += "        col.colid  column_id, ";
		sSQL += "        typ.name   data_type, ";
		sSQL += "        col.length length, ";
		sSQL += "        col.prec   prec, ";
		sSQL += "        col.scale  scale, ";
		sSQL += "        com.text   default_value, ";
		sSQL += "        obj.name   default_cons_name, ";
		sSQL += "        CASE ";
		sSQL += "           WHEN col.isnullable = 1 THEN 'Y' ";
		sSQL += "           ELSE 'N' ";
		sSQL += "        END        is_nullable, ";
		sSQL += "        CASE ";
		sSQL += "           WHEN col.status & 0x80 = 0x80 THEN 'Y' ";
		sSQL += "           ELSE 'N' ";
		sSQL += "        END        is_identity ";
		sSQL += "   FROM sysobjects tab, ";
		sSQL += "        syscolumns col LEFT OUTER JOIN ";
		sSQL += "        syscomments com INNER JOIN ";
		sSQL += "        sysobjects obj ON com.id = obj.id ON col.cdefault = com.id AND com.colid = 1, ";
		sSQL += "        systypes typ ";
		sSQL += "  WHERE tab.id = col.id ";
		sSQL += "    AND tab.xtype = 'U' ";
		sSQL += "    AND tab.name = '" + Request.QueryString("table") + "' ";
		sSQL += "    AND col.xusertype = typ.xusertype ";
		sSQL += "  ORDER BY 1, 3 ";
		sOut = '';
		sOut += '<h2 onclick="this.parentNode.parentNode.removeChild(this.parentNode);">Table Schema for &quot;' + Request.QueryString("table") + '&quot;</h2>';
		sOut += '<table>';
		sOut += '<tr><th>Column Name</th><th>Data Type</th><th>Length</th><th>Nulls</th><th>Identity</th><th>Default Value</th></tr>';
		rs=Server.CreateObject("ADODB.Recordset");
		rs.Open(sSQL, conn);
		while (!rs.EOF) {
			sOut += '<tr>';
			sOut += '<td>' + rs("column_name") + '</td>';
			sOut += '<td>' + rs("data_type") + '</td>';
			sOut += '<td>' + rs("length") + '</td>';
			sOut += '<td>' + rs("is_nullable") + '</td>';
			sOut += '<td>' + rs("is_identity") + '</td>';
			defaultValue = String(rs("default_value"));
			if (defaultValue.length < 20) {
				sOut += '<td>' + defaultValue + '</td>';
				} else {
					sOut += '<td><a href="#" title="' + defaultValue + '">Text Value...</a></td>';
			}
			sOut += '</tr>';
			rs.MoveNext();
		}
		sOut += '</table>';
		
		sSQL = " SELECT tab.name                                  table_name, ";
		sSQL += "        ind.name                                  constraint_name, ";
		sSQL += "        INDEX_COL(tab.name, ind.indid, idk.keyno) column_name, ";
		sSQL += "        idk.keyno                                 pos ";
		sSQL += "   FROM sysobjects tab, ";
		sSQL += "        sysindexes ind, ";
		sSQL += "        sysindexkeys idk ";
		sSQL += "  WHERE ind.status & 0x800 = 0x800 ";
		sSQL += "    AND ind.id = tab.id ";
		sSQL += "    AND idk.id = tab.id ";
		sSQL += "    AND idk.indid = ind.indid ";
		sSQL += "    AND tab.name = '" + Request.QueryString("table") + "' ";
		sSQL += "  ORDER BY 1, 2, 4 ";
				
		var rs1=Server.CreateObject("ADODB.Recordset");
		rs1.Open(sSQL, conn, 1);
		sOut += '<p><strong>Primary Key:</strong></p><ul>';
		if(rs1.RecordCount > 0) {
			while (!rs1.EOF) {
				sOut += '<li>' + rs1("column_name") + '</li>';
				rs1.MoveNext();
			}
		} else {
			sOut += '<li>None Defined</li>';
		}		
		sOut += '</ul>';
	
		Response.Write (sOut);
		Response.End;
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Database Schema</title>
    <style type="text/css">
	    body {font-family: Arial, Helvetica, sans-serif; font-size: x-small; padding: 0; margin: 0;}
	    #tables {float:left;width: 170px; padding: 3px; margin: 0; border-right: 1px dotted #444; background-color: #ddd; display:block}
	    #tables ul {list-style:none; padding: 10px 0 0 5px; margin: 0;}
	    #details { padding-left: 190px;}
	    table {border-collapse:collapse}
	    td, th {border: 1px solid #bbb; vertical-align: top; padding-right: 10px}
	    th {text-align: left}
	    h2 {cursor: pointer; font-size: medium}
	    .schema {margin-bottom:20px;}
	    #loading {width:7em; background-color: red; color:#fff; font-weight:bold; top: 0; left:0; position:absolute; padding:4px; display:none}
    </style>

    <script type="text/javascript">
          var xmlDoc = null;
      
          function load(url) {
	  	    var fromTop = document.all ? document.documentElement.scrollTop : pageYOffset
		    var s = document.getElementById('loading').style;
		    s.top = fromTop + 'px';
		    s.display='block';
            if (typeof window.ActiveXObject != 'undefined' ) {
              xmlDoc = new ActiveXObject("Microsoft.XMLHTTP");
              xmlDoc.onreadystatechange = process ;
            }
            else {
              xmlDoc = new XMLHttpRequest();
              xmlDoc.onload = process ;
            }
            xmlDoc.open( "GET", url, true );
            xmlDoc.send( null );
          }
      
          function process() {
            if ( xmlDoc.readyState != 4 ) return ;
            document.getElementById("details").innerHTML += xmlDoc.responseText ;
		    document.getElementById('loading').style.display='none';
          }
      
          function empty() {
            document.getElementById("details").value += 'error' ;
		    document.getElementById('loading').style.display='none';
          }
	  
    </script>
</head>
<body>
<%
	var sSQL = " SELECT tab.name table_name ";
	sSQL += " FROM sysobjects tab ";
	sSQL += " WHERE tab.xtype = 'U' ";
	sSQL += " AND tab.name <> 'dtproperties' ";
	sSQL += " ORDER BY 1  ";
	
	sSQL = " SELECT tab.name                                  table_name, ";
	sSQL += "        ind.name                                  constraint_name, ";
	sSQL += "        INDEX_COL(tab.name, ind.indid, idk.keyno) column_name, ";
	sSQL += "        idk.keyno                                 pos ";
	sSQL += "   FROM sysobjects tab, ";
	sSQL += "        sysindexes ind, ";
	sSQL += "        sysindexkeys idk ";
	sSQL += "  WHERE ind.status & 0x800 = 0x800 ";
	sSQL += "    AND ind.id = tab.id ";
	sSQL += "    AND idk.id = tab.id ";
	sSQL += "    AND idk.indid = ind.indid ";
	sSQL += "    AND tab.name = '" + Request.QueryString("table") + "' ";
	sSQL += "  ORDER BY 1, 2, 4 ";
	
    Response.write(sSQL);
    Response.end;
    
	var rs=Server.CreateObject("ADODB.Recordset");
	
	var thisPage = Request.ServerVariables("SCRIPT_NAME");
	var sOut = '<div id="tables">';
	sOut += '<div><a href="#" onclick="document.getElementById(\'tables\').style.display=\'none\'; document.getElementById(\'details\').style.paddingLeft=\'10px\'; return false;">Hide Table List</a></div>';	
	sOut += '<ul>';
	
	sOut += '</ul></div>';
	

	sOut += '<div id="details">&nbsp;';
	
	sOut += '</div>';
	Response.Write (sOut);
%>
<div id="loading">Loading...</div>
</body>
</html>