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
using System.IO;

public partial class Sidebar1 : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e) //Triggered on page load
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }

        if (Request.QueryString["ProjectID"] != null)
        {
            LoadProjectBlock(Convert.ToInt32(Request.QueryString["ProjectID"])); Employment.Visible = false;
        }

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();

        string sql = "Select Heading, Text From SIDEBAR_CONTENT Order By OrderCol";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader(); int i = 0;
        while (dr.Read())
        {
            Control blk = LoadControl("~/design/Block.ascx");
            blk.ID = dr["Heading"].ToString() + i.ToString(); i++;
            PlaceHolder header = (PlaceHolder)blk.FindControl("HeaderPlaceholder");
            PlaceHolder content = (PlaceHolder)blk.FindControl("ContentPlaceholder");
            Literal litHeader = new Literal(); litHeader.Text = dr["Heading"].ToString();
            Literal litText = new Literal(); litText.Text = dr["Text"].ToString();

            if (header != null && content != null) { header.Controls.Add(litHeader); content.Controls.Add(litText); }
            SidebarPanel.Controls.Add(blk);
        }
        dr.Close(); Global_Functions.CloseConnection(conn);
    }

    protected void imgDonate_Click(Object sender, EventArgs e) { Response.Redirect("https://www.paypal.com/us/cgi-bin/webscr?cmd=_xclick&business=me@mybusiness.com&item_name=Community Action, Inc.&currency_code=USD"); }

    protected void LoadProjectBlock(int ProjectID)
    {
        /*SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select ProjectID, ImgLocation, ImgHeading, ImgCaption From PROJECT Where ProjectID=@ProjectID";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.Parameters.Add(new SqlParameter("@ProjectID", Request.QueryString["ProjectID"]));
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (dr["ImgLocation"].ToString() != "")
            {
                //------create new block control and add content-------------
                Control block = LoadControl("~/design/Block.ascx");
                block.ID = "Project" + dr["ProjectID"].ToString();

                //get header and content placeholders for newly created article control
                PlaceHolder header = (PlaceHolder)block.FindControl("HeaderPlaceholder");
                PlaceHolder content = (PlaceHolder)block.FindControl("ContentPlaceholder");

                //literal control for caption -- add to header
                Literal litHeader = new Literal(); litHeader.Text = dr["ImgHeading"].ToString();
                if (header != null) { header.Controls.Add(litHeader); }

                //liteal control for body, image control for picture -- add to content
                Literal litContent = new Literal(); if (dr["ImgCaption"].ToString() != "") { litContent.Text = dr["ImgCaption"].ToString() + "<br/><br/>"; }
                Image img = new Image();
                img.ImageUrl = ConfigurationManager.AppSettings.Get("URLRoot") + dr["ImgLocation"].ToString();
                img.Attributes.Add("style","height:75px; width:75px; border:none");
                if (content != null) { content.Controls.Add(litContent); content.Controls.Add(img); }

                //add article to PagePanel
                ProjectPanel.Controls.Add(block);
            }
        }
        Global_Functions.CloseConnection(conn);*/
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select ApprovedID, AppImgLocation, AppImageHeading, AppImageCaption From APPROVED_PROJ_PAGES Where ApprovedID=@ApprovedID";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.Parameters.Add(new SqlParameter("@ApprovedID", Request.QueryString["ProjectID"]));
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (dr["AppImgLocation"].ToString() != "")
            {
                //------create new block control and add content-------------
                Control block = LoadControl("~/design/Block.ascx");
                block.ID = "Project" + dr["ApprovedID"].ToString();

                //get header and content placeholders for newly created article control
                PlaceHolder header = (PlaceHolder)block.FindControl("HeaderPlaceholder");
                PlaceHolder content = (PlaceHolder)block.FindControl("ContentPlaceholder");

                //literal control for caption -- add to header
                Literal litHeader = new Literal(); litHeader.Text = dr["AppImageHeading"].ToString();
                if (header != null) { header.Controls.Add(litHeader); }

                //liteal control for body, image control for picture -- add to content
                Literal litContent = new Literal(); if (dr["AppImageCaption"].ToString() != "") { litContent.Text = dr["AppImageCaption"].ToString() + "<br/><br/>"; }
                Image img = new Image();
                img.ImageUrl = ConfigurationManager.AppSettings.Get("URLRoot") + "ApprovedUploads/" + Request.QueryString["ProjectID"] + "/" +dr["AppImgLocation"].ToString();
                img.Attributes.Add("style", "height:75px; width:75px; border:none");
                if (content != null) { content.Controls.Add(litContent); content.Controls.Add(img); }

                //add article to PagePanel
                ProjectPanel.Controls.Add(block);
            }
        }
        conn.Close(); conn.Dispose();
    }

    protected void BuildJobAnnouncements()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["JOB"].ConnectionString);
        conn.Open();
        SqlDataAdapter da;
        SqlCommand cmd;
        DataTable dt = new DataTable();

        da = new SqlDataAdapter("SELECT * From JOB_ANNOUNCEMENTS INNER JOIN POSITION_TITLE as PT on POSITION_ID=PT.ID INNER JOIN POSITION_TYPE AS PTY on Position_Type=PTY.ID INNER JOIN FLSA_STATUS AS FS on FLSA_STATUS= FS.ID Where (WEBSITE_FLAG=1) AND (FILLED_FLAG=1 OR POSTING_DEADLINE>=CONVERT(VarChar(04), YEAR(GETDATE()))+ '-' + CONVERT(VarChar(02), MONTH(GETDATE()))+ '-' +CONVERT(VarChar(02), DAY(GETDATE()))) AND EXPIRED_FLAG=0 ORDER BY JID DESC", conn);
        da.Fill(dt);

        if (dt.Rows.Count != 0)
        {
            foreach (DataRow drow in dt.Rows)
            {
                if (Convert.ToBoolean(drow["Filled_Flag"].Equals(false)))
                {
                    if (DateTime.Now >= Convert.ToDateTime(drow["Posting_Deadline"]))
                    {
                        cmd = new SqlCommand("Update JOB_ANNOUNCEMENTS set Expired_Flag='true', ExpireDate=@ExpireDate where JID=" + drow["JID"].ToString(), conn);
                        cmd.Parameters.AddWithValue("@ExpireDate", DateTime.Now);
                        cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        Response.Write("<ul><li><b><a href=\"job_announcement.aspx?ID=" + drow["JID"].ToString() + "\">" + drow["Title"].ToString() + "</a></b></li></ul><span style=\"font-size:4pt\"><br /></span>");
                    }
                }
                else
                {
                    Response.Write("<ul><li><b><a href=\"job_announcement.aspx?ID=" + drow["JID"].ToString() + "\">" + drow["Title"].ToString() + "</a></b></li></ul><span style=\"font-size:4pt\"><br /></span>");
                }
            }
        }
        else
        {
            BuildEmploymentLine1();
        }

        BuildEmploymentLine2();
        Global_Functions.CloseConnection(conn);
    }

    //protected void BuildJobAnnouncements()
    //{
    //    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["JOB"].ConnectionString);
    //    conn.Open();

    //    string sql = "SELECT * From JOB_ANNOUNCEMENTS INNER JOIN POSITION_TITLE as PT on POSITION_ID=PT.ID INNER JOIN POSITION_TYPE AS PTY on Position_Type=PTY.ID INNER JOIN FLSA_STATUS AS FS on FLSA_STATUS= FS.ID Where (WEBSITE_FLAG=1) AND (FILLED_FLAG=1 OR POSTING_DEADLINE>=CONVERT(VarChar(04), YEAR(GETDATE()))+ '-' + CONVERT(VarChar(02), MONTH(GETDATE()))+ '-' +CONVERT(VarChar(02), DAY(GETDATE()))) AND EXPIRED_FLAG=0 ORDER BY JID DESC";
    //    SqlCommand cmd = new SqlCommand(sql, conn);
    //    SqlDataReader dr = cmd.ExecuteReader();
    //    if (dr.HasRows)
    //    {
    //        while (dr.Read())
    //        {
    //            Response.Write("<ul><li><b><a href=\"job_announcement.aspx?ID=" + dr["JID"].ToString() + "\">" + dr["Title"].ToString() + "</a></b></li></ul><span style=\"font-size:4pt\"><br /></span>");
    //        }
    //    }
    //    else
    //    {
    //        BuildEmploymentLine1();
    //    }

    //    BuildEmploymentLine2();
    //    dr.Close(); Global_Functions.CloseConnection(conn);
    //}

    protected void BuildEmploymentLine1()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select Line1 from EMPLOYMENT_MESSAGE"; string line1 = "";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            line1 = "<p><ul><li><b>" + dr["Line1"].ToString() + "</b></li></ul></p>";
        }
        dr.Close(); Global_Functions.CloseConnection(conn);
        if (line1 != null || line1 != "")
        {
            Response.Write(line1);
        }
    }

    protected void BuildEmploymentLine2()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        String sql = "Select Line2 from EMPLOYMENT_MESSAGE"; string line2 = "";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            line2 = "<br/><p>" + dr["Line2"].ToString() + "</p>";
        }
        dr.Close(); Global_Functions.CloseConnection(conn);
        if (line2 != null || line2 != "")
        {
            Response.Write(line2);
        }
    }

    protected void BuildNewsletters()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();

        string sql = "SELECT Top 5 Name, Location, DateAdded From NEWSLETTER Where Active=1 Order By DateAdded Desc";
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

    protected void BuildImportantNotices()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();

        string sql = "SELECT Top 5 Name, Location, OrderCol From IMPORTANT_NOTICES Where Active=1 Order By OrderCol";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Response.Write("<ul><li><b><a href=\"" + dr["Location"].ToString() + "\">" + dr["Name"].ToString() + "</a></b></li></ul><span style=\"font-size:4pt\"><br /></span>");
            }
        }
        else { Response.Write("<ul><li><b>There are no important notices at this time.</b></li></ul>"); }
        dr.Close(); Global_Functions.CloseConnection(conn);
    }
}
