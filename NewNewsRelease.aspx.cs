using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class NewNewsRelease : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
        artNewsReleases.DataBind();
        LoadReleases();
    }

    protected void drYears_SelectedIndexChanged(Object sender, EventArgs e)
    {
        LoadReleases();
    }

    protected void LoadReleases()
    {
        ltr.Text = "";
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["NRS"].ConnectionString);
        conn.Open(); SqlCommand cmd; string sql; SqlDataReader dr;

        sql = "Select ID, WebsiteHyperlinkText From NEWS_RELEASE Where WebsiteFlag='true'and ApprovalFlag='true' and ReleaseDate <='" + DateTime.Now.ToShortDateString() + "' and @Month=Month(ReleaseDate) and @Year=Year(ReleaseDate) Order by ReleaseDate DESC";
        int Months = 12;
        while (Months >= 1)
        {
            cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@Month", Months)); cmd.Parameters.Add(new SqlParameter("@Year", drYears.SelectedValue));
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                ltr.Text = ltr.Text + "<h4>" + System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(Months) + "</h4>";
                while (dr.Read())
                {
                    ltr.Text = ltr.Text + "<a href=\"NewNews_Release.aspx?ID=" + dr["ID"].ToString() + "\">" + dr["WebsiteHyperlinkText"].ToString().Replace("<br/>", " ") + "</a><br/><br/>";
                }
                ltr.Text = ltr.Text + "<br/>";
            }
            dr.Close(); Months = Months - 1; cmd.Dispose();
        }
        Global_Functions.CloseConnection(conn);
    }
}