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

public partial class Emergencies : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }

        //History.DataBind();

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select Text From EMERGENCY"; string html = "";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read()) { html = dr["Text"].ToString(); }
        dr.Close();

        //if (html == "" || html == null) { History.Visible = false; }
    }

    protected void loadEmergencies()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select Text From EMERGENCY"; string html = "";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read()) { html = dr["Text"].ToString(); }
        dr.Close(); Global_Functions.CloseConnection(conn);
        if (html != null || html != "")
        {
            Response.Write(html);
        }
    }
}
