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

public partial class Employment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();

        string sql = "Select Heading, Text from EMPLOYMENT Order by OrderCol";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader(); int i = 0;
        while (dr.Read())
        {
            Control art = LoadControl("~/design/Article.ascx");
            art.ID = dr["Heading"].ToString() + i.ToString(); i++;
            PlaceHolder header = (PlaceHolder)art.FindControl("HeaderPlaceholder");
            PlaceHolder content = (PlaceHolder)art.FindControl("ContentPlaceholder");
            Literal litHeader = new Literal(); litHeader.Text = dr["Heading"].ToString();
            Literal litText = new Literal(); litText.Text = dr["Text"].ToString();

            if (header != null && content != null) { header.Controls.Add(litHeader); content.Controls.Add(litText); }
            empPanel.Controls.Add(art);
        }
        dr.Close(); Global_Functions.CloseConnection(conn);
    }

    protected void BuildJobAnnouncements()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["JOB"].ConnectionString);
        conn.Open();

        string sql = "SELECT * From JOB_ANNOUNCEMENTS INNER JOIN POSITION_TITLE as PT on POSITION_ID=PT.ID INNER JOIN POSITION_TYPE AS PTY on Position_Type=PTY.ID INNER JOIN FLSA_STATUS AS FS on FLSA_STATUS= FS.ID Where (WEBSITE_FLAG=1) AND (FILLED_FLAG=1 OR POSTING_DEADLINE>=CONVERT(VarChar(04), YEAR(GETDATE()))+ '-' + CONVERT(VarChar(02), MONTH(GETDATE()))+ '-' +CONVERT(VarChar(02), DAY(GETDATE()))) AND EXPIRED_FLAG=0 ORDER BY JID DESC";
		SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
         while (dr.Read())
                {
                    Response.Write("<span style=\"font-weight:bold; font-size:13pt\"><a href=\"job_announcement.aspx?ID=" + dr["JID"].ToString() + "\">" + dr["Title"].ToString() + "</a></span><br /><br />");
                }
        }
        else
        {
            Response.Write("<span style=\"font-weight:bold; font-size:13pt\">There are no job announcements at this time.</span><br /><br />");
        }

        dr.Close(); Global_Functions.CloseConnection(conn);
    }
}