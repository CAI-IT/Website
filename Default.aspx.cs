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
    }

    protected void CheckSliderContent()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["NRS"].ConnectionString);
        conn.Open();

        string sql = "Select ID, HeadlineEmailSubject, WebsiteHyperlinkText, ReleaseDate, Body, ImageCaption, Image from NEWS_RELEASE where (WebsiteFlag='true' and ApprovalFlag='true' and ExpiredFlag='false' and SliderContentFlag='true' and ReleaseDate <= '" + DateTime.Now.ToShortDateString() + "') Order By SliderPosition";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader(); bool HasContent = false;
        if (dr.HasRows == true) { HasContent = true; }
        Global_Functions.CloseConnection(conn);
        if (HasContent == false) { Article1.Visible = false; }

        conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        sql = "Select Name, Text From CONTENT_ROTATOR Where Active=1";
        cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        HasContent = false;
        if (dr.HasRows) { HasContent = true; }
        Global_Functions.CloseConnection(conn);
        if (HasContent == false) { ContentRotator.Visible = false; }
    }

    protected void BuildHeadlines()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["NRS"].ConnectionString);
        conn.Open();

        SqlConnection conn2 = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn2.Open();

        // Code to pull data from NEWS_RELEASE table
        SqlDataAdapter da;
        SqlCommand cmd;
        DataTable dt = new DataTable();
        da = new SqlDataAdapter("Select WebsiteHyperlinkText, ExpirationDate, ID From NEWS_RELEASE Where (WebsiteFlag='true' and ApprovalFlag='true' and ExpiredFlag='false' and SliderContentFlag='false' and ReleaseDate <= '" + DateTime.Now.ToShortDateString() + "') Order By ReleaseDate Desc", conn);
        da.Fill(dt);
        int count = 0;

        // Code to pull data from HEADLINE table
        string sql2 = "Select HeadlineID, Path, HeadlineText from HEADLINE where Active=1";
        SqlCommand cmd2 = new SqlCommand(sql2, conn2);
        SqlDataAdapter da2 = new SqlDataAdapter(cmd2);
        DataSet ds2 = new DataSet();
        da2.Fill(ds2);

        // Write contents of DataReaders to web page in HTML
        if (dt.Rows.Count != 0 || ds2.Tables[0].Rows.Count != 0)
        {
            Response.Write("<ul>");
            foreach (DataRow drow in dt.Rows)
            {
                if (DateTime.Now >= Convert.ToDateTime(drow["ExpirationDate"]))
                {
                    cmd = new SqlCommand("Update NEWS_RELEASE set ExpiredFlag='true' where ID=" + drow["ID"].ToString(), conn);
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    if (count == 8) { conn.Close(); return; }
                    Response.Write("<li style=\"margin-bottom:0px\"><b><a href=\"NewNews_Release.aspx?ID=" + drow["ID"].ToString() + "\" target=\"_blank\">" + drow["WebsiteHyperlinkText"].ToString().Replace("<br/>", " ") + "</a></b></li>");
                    //Response.Write("<p>" + Global_Functions.TruncateAtWord(dr["ReleaseInfo"].ToString(), 100, true, true) + "<br/>");
                    //Response.Write("<a href='News_Release.aspx?NRID=" + dr["ReleaseID"].ToString() + "'>Read more...</a></p></li></ul>");
                    count++;
                }
            }
            /*******************Code to display PDF Links*******************************************************/
            foreach (DataRow dataRow in ds2.Tables[0].Rows)
            {
                Response.Write("<li style='margin-bottom:0px'><b><a href='Headlines\\" + dataRow[1].ToString() + "' target=\"_blank\">" + dataRow[2].ToString() + "</a></b></li>");
            }
            Response.Write("</ul>");
        }
        else
        {
            Response.Write("<ul><li><b>There are no headlines at this time.</b></li></ul><span style=\"font-size:4pt\"><br /></span>");
        }
        Global_Functions.CloseConnection(conn);
        Global_Functions.CloseConnection(conn2);
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
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["NRS"].ConnectionString);
        conn.Open();
        SqlDataAdapter da;
        SqlCommand cmd;
        DataTable dt = new DataTable();

        da = new SqlDataAdapter("Select * From NEWS_RELEASE Where (WebsiteFlag='true' and ApprovalFlag='true' and ExpiredFlag='false' and SliderContentFlag='true' and ReleaseDate <= '" + DateTime.Now.ToShortDateString() + "') Order By SliderPosition", conn);
        da.Fill(dt);
        if (dt.Rows.Count != 0)
        {
            foreach (DataRow drow in dt.Rows)
            {
                if (DateTime.Now >= Convert.ToDateTime(drow["ExpirationDate"]))
                {
                    cmd = new SqlCommand("Update NEWS_RELEASE set ExpiredFlag='true' where ID=" + drow["ID"].ToString(), conn);
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    Response.Write("<div>");
                    string headline = drow["HeadlineEmailSubject"].ToString().Replace("<br/>", " ");
                    Response.Write("<span style=\"font-family:Arial; font-size:13.5pt;color: #620f2a\"><b>" + headline + "</b></span><br/>");

                    //show image
                    if (drow["ID"].ToString() == "")
                    {
                        Response.Write("<img class=\"art-article\" src=\"images/agency_logo_slider.jpg\" alt='News Release Image' style=\" float:left;border:0;margin: 1em 1em 0 0;\"/>");
                    }
                    else
                    {
                        Response.Write("<img class=\"art-article\" src='Show_Image.aspx?ID=" + drow["ID"].ToString() + "' alt='News Release Image' style=\"float:left;border:0;margin: 1em 1em 0 0; width:40%;\"/>");
                    }
                    string truncText = returnTruncText(drow["Body"].ToString());
                    Response.Write("<p>" + truncText + "<br/>");
                    Response.Write("<p><span class=\"art-button-wrapper\">");
                    Response.Write("<span class=\"art-button-l\"> </span><span class=\"art-button-r\"> </span>");
                    Response.Write("<a class=\"art-button\" href=\"NewNews_Release.aspx?ID=" + drow["ID"].ToString() + "\">Read more...</a></span></p>");
                    Response.Write("<div class=\"cleared\"></div></div>");
                }
            }
        }
        Global_Functions.CloseConnection(conn);
    }

    protected void LoadContentRotator()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        SqlDataAdapter da;
        DataTable dt = new DataTable();

        da = new SqlDataAdapter("select ID, Name, Text from CONTENT_ROTATOR where Active=1 order by ID", conn);
        da.Fill(dt);
        if (dt.Rows.Count != 0)
        {
            foreach (DataRow drow in dt.Rows)
            {
                Response.Write("<div><center><span style=\"font-family:Arial; font-size:20pt;color: #620f2a\"><b>" + drow["Name"] + "</b></span><br/>");
                Response.Write(drow["Text"] + "</center></div>");
            }
        }
        Global_Functions.CloseConnection(conn);
    }

    private string returnTruncText(string text)
    {
        string truncText = Global_Functions.TruncateAtWord(text.Replace("\n", "<br/>"), 400, true, true);
        string newline = "<br/>";
        string returnText;
        int count = 0;
        for (int i = 0; i <= truncText.Length - newline.Length; i++)
        {
            if (truncText.Substring(i, newline.Length) == newline)
            {
                count++;
                if (count > 2)
                {
                    returnText = truncText.Substring(0, i);
                    return returnText;
                }
            }
        }
        return truncText;
    }
}
