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

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
        
        SpecialAnnouncements.DataBind();
        BottomContent.DataBind();
        Article1.DataBind();

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select Text From SPECIAL_ANNOUNCEMENT"; string html = "";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read()) { html = dr["Text"].ToString(); }
        dr.Close();

        if (html == "" || html == null) { SpecialAnnouncements.Visible = false; }

        sql = "Select Text From BOTTOM Where Active=1"; html = "";
        cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        if (dr.HasRows == false) { BottomContent.Visible = false; dr.Close(); Global_Functions.CloseConnection(conn); }
        else 
        { 
            while (dr.Read()) { html = dr["Text"].ToString(); }
            dr.Close(); Global_Functions.CloseConnection(conn);

            if (html == "" || html == null) { BottomContent.Visible = false; }
        }

        CheckSliderContent();
        CheckHeadlineContent();
    }

    protected void CheckHeadlineContent()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Intranet"].ConnectionString);
        conn.Open();

        string sql = "Select * From NewsReleases Where (ImportantNotice='checked' and WebFlag='Y' and Final='Y' and Del=0) and (ReleaseDate <= '" + DateTime.Now.ToShortDateString() + "') and (ExpirationDate >= '" + DateTime.Now.ToShortDateString() + "' or ExpirationDate is Null) Order By ReleaseDate Desc";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows == false) { Headlines.Visible = false; }
        Global_Functions.CloseConnection(conn);
    }

    protected void CheckSliderContent()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Intranet"].ConnectionString);
        conn.Open();

        string sql = "Select Heading, WebHeadline, ReleaseID, ReleaseDate, ReleaseInfo, ReleaseTitle1, ReleaseTitle2, Image, ID From NewsReleases as R left outer join NewsReleaseImages as I on I.RID=R.ReleaseID Where (WebFlag='Y' and Final='Y' and Del=0 and Top5Position <> 0 and ImportantNotice is null) and (ReleaseDate <= '" + DateTime.Now.ToShortDateString() + "') and (ExpirationDate >= '" + DateTime.Now.ToShortDateString() + "' or ExpirationDate is Null) Order By Top5Position";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader(); bool HasContent = false;
        if (dr.HasRows == true) {HasContent = true;}
        Global_Functions.CloseConnection(conn);

        conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        sql = "Select Name, Text From CONTENT_ROTATOR Where Active=1";
        cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        if (dr.HasRows) { HasContent = true; }
        Global_Functions.CloseConnection(conn);
        if (HasContent == false) { Article1.Visible = false; }
    }

    protected void BuildHeadlines()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Intranet"].ConnectionString);
        conn.Open();

        string sql = "Select * From NewsReleases Where (ImportantNotice='checked' and WebFlag='Y' and Final='Y' and Del=0) and (ReleaseDate <= '" + DateTime.Now.ToShortDateString() + "') and (ExpirationDate >= '" + DateTime.Now.ToShortDateString() + "' or ExpirationDate is Null) Order By ReleaseDate Desc";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            int count = 0;
            while (dr.Read())
            {
                if (count == 5) { conn.Close(); return; }
                Response.Write("<ul><li style=\"margin-bottom:-25px\"><b><a style=\"font-size:12pt; color:#335371\" href=\"News_Release.aspx?NRID=" + dr["ReleaseID"].ToString() + "\">" + dr["WebHeadline"].ToString().Replace("<br/>", " ") + "</a></b></li></ul><span style=\"font-size:4pt\"><br /></span>");
                //Response.Write("<p>" + Global_Functions.TruncateAtWord(dr["ReleaseInfo"].ToString(), 100, true, true) + "<br/>");
                //Response.Write("<a href='News_Release.aspx?NRID=" + dr["ReleaseID"].ToString() + "'>Read more...</a></p></li></ul>");
                count++;
            }
        }
        else //dr empty
        {
            //some type of default content
            Response.Write("<ul><li><b>There are no headlines at this time.</b></li></ul><span style=\"font-size:4pt\"><br /></span>");
        }

        Global_Functions.CloseConnection(conn);
    }

    protected void loadSpecialAnnouncements()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select Text From SPECIAL_ANNOUNCEMENT"; string html = "";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read()) { html = dr["Text"].ToString(); }
        dr.Close(); Global_Functions.CloseConnection(conn);
        if (html != null || html != "")
        {
            Response.Write(html);
        } 
    }

    protected void LoadBottomContent() 
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select Text From BOTTOM Where Active=1"; string html = "";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read()) { html = dr["Text"].ToString(); }
        dr.Close(); Global_Functions.CloseConnection(conn);
        if (html != null || html != "")
        {
            Response.Write(html);
        }
    }

    protected void LoadSliderContent()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Intranet"].ConnectionString);
        conn.Open();

        string sql = "Select Heading, WebHeadline, ReleaseID, ReleaseDate, ReleaseInfo, ReleaseTitle1, ReleaseTitle2, Image, ID From NewsReleases as R left outer join NewsReleaseImages as I on I.RID=R.ReleaseID Where (WebFlag='Y' and Final='Y' and Del=0 and Top5Position <> 0 and ImportantNotice is null) and (ReleaseDate <= '" + DateTime.Now.ToShortDateString() + "') and (ExpirationDate >= '" + DateTime.Now.ToShortDateString() + "' or ExpirationDate is Null) Order By Top5Position";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Response.Write("<div>");
                string headline = dr["WebHeadline"].ToString().Replace("<br/>", " ");
                Response.Write("<span style=\"font-family:Arial; font-size:13.5pt;color: #620f2a\"><b>" + headline + "</b></span><br/>");

                //show image
                if (dr["ID"].ToString() == "") { Response.Write("<img class=\"art-article\" src=\"images/agency_logo_slider.jpg\" alt='News Release Image' style=\" float:left;border:0;margin: 1em 1em 0 0;\"/>"); }
                else { Response.Write("<img class=\"art-article\" src='Show_Image.aspx?ID=" + dr["ID"].ToString() + "' alt='News Release Image' style=\"float:left;border:0;margin: 1em 1em 0 0; width:40%;\"/>"); }
                
                //loop to count occurences of '\n'
                //if 3
                //Response.Write("<p>" + Global_Functions.TruncateAtWord(dr["ReleaseInfo"].ToString().Replace("\n","<br/>"), 400, true, true) + "<br/>");
                //if 4
                //Response.Write("<p>" + Global_Functions.TruncateAtWord(dr["ReleaseInfo"].ToString().Replace("\n","<br/>"), 450, true, true) + "<br/>");

                Response.Write("<p>" + Global_Functions.TruncateAtWord(dr["ReleaseInfo"].ToString().Replace("\n","<br/>"), 400, true, true) + "<br/>");
                Response.Write("<p><span class=\"art-button-wrapper\">");
                Response.Write("<span class=\"art-button-l\"> </span><span class=\"art-button-r\"> </span>");
                Response.Write("<a class=\"art-button\" href=\"News_Release.aspx?NRID=" + dr["ReleaseID"].ToString() + "\">Read more...</a></span></p>");
                Response.Write("<div class=\"cleared\"></div></div>");
            }
            dr.Close();
        }

        //load custom content from database
        conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        sql = "Select Name, Text From CONTENT_ROTATOR Where Active=1";
        cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Response.Write("<div>");
                Response.Write("<span style=\"font-family:Arial; font-size:13.5pt;color: #620f2a\"><b>" + dr["Name"].ToString() + "</b></span><br/>");
                Response.Write(dr["Text"].ToString() + "</div>");
            }
        }

        Global_Functions.CloseConnection(conn);
    }
}
