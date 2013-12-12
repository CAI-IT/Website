using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Newsletters : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
        artNewsletters.DataBind();
    }

    protected void LoadNewsletters()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();

        string sql = "SELECT Name, Location, DateAdded From NEWSLETTER Where Active=1 Order By DateAdded Desc";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Response.Write("<ul><li><b><a href=\"" + dr["Location"].ToString() + "\">" + dr["Name"].ToString() + "</a></b></li></ul><span style=\"font-size:4pt\"><br /></span>");
            }
        }
        else { Response.Write("<ul><li><b>There are no newsletters at this time.</b></li></ul>"); }
        dr.Close(); Global_Functions.CloseConnection(conn);
    }
}