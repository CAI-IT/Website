using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class DefaultHeader : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
    }

    protected void loadHeading()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select Heading from HEADER"; string heading = "";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read()) { heading = dr["Heading"].ToString(); }
        dr.Close(); Global_Functions.CloseConnection(conn);
        if (heading != null || heading != "")
        {
            Response.Write(heading);
        }
    }

    protected void loadSubHeading()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select SubHeading from HEADER"; string subheading = "";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read()) { subheading = dr["SubHeading"].ToString(); }
        dr.Close(); Global_Functions.CloseConnection(conn);
        if (subheading != null || subheading != "")
        {
            Response.Write(subheading);
        }
    }
	
	protected void imgDonate_Click(Object sender, EventArgs e) { Response.Redirect("donations.aspx"); }
}
