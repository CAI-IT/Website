using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class job_announcement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
        artJobAnnouncement.DataBind();
    }

    protected void BuildJobAnnouncement(int JID)
    {
        //Code to read active job announcement from database and add to article
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["JOB"].ConnectionString);
        conn.Open();
        string sql = "Select JID From JOB_ANNOUNCEMENTS Where JID=@JID AND EXPIRED_FLAG=0 AND WEBSITE_FLAG=1";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.Parameters.Add(new SqlParameter("@JID", JID));
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Response.Write(Global_Functions.EmailBody(JID));
            }
        }
        else
        {
            Response.Write("<span style=\"font-weight:bold; font-size:13pt\">The job announcement you are trying to view has expired.</span>");
        }
        Global_Functions.CloseConnection(conn);
    }
}