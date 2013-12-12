using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class NewNews_Release : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
    }

    // This function builds the content of a news release and outputs it into the parent object
    // Function needs to be passed the ID
    public void BuildNewsRelease(int ID)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["NRS"].ConnectionString);
        conn.Open();

        string sql = "SELECT M.Name FROM NEWS_RELEASE as NR inner join NEWS_SOURCES on NR.ID=NewsReleaseID inner join MEDIA_SOURCES as M on M.ID=MediaSourceID where NewsReleaseID=" + ID + " Order by Name";
        List<string> Media = new List<string>();
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            Media.Add(dr["Name"].ToString());
        }
        dr.Close();

        sql = "Select NR.HeadlineEmailSubject, NR.ReleaseDate, NR.Body, NR.ImageCaption, NR.Image, NR.WebsiteHyperlinkText, NR.NoExternalContacts, RT.ReleaseType from NEWS_RELEASE as NR inner join RELEASE_TYPE as RT on NR.ReleaseType=RT.ID Where NR.ID=" + ID + "";
        cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        int myOrdinal = dr.GetOrdinal("Image");
        while (dr.Read())
        {
            Response.Write("<tr><td colspan='2' style='border:none; text-align:center'><span style='font-size:13.5pt; color:#620f2a'><u>" + dr["ReleaseType"] + "</u></span><br/><br/></td></tr>");

            Response.Write("<tr><td style='width:22%; border:none'><b>Release Date:</b></td>");
            DateTime ReleaseDate = Convert.ToDateTime(dr["ReleaseDate"]);
            Response.Write("<td style='width:78%; border:none'>" + ReleaseDate.ToString("D") + "<br/><br/></td></tr>");

            if (Media.Count == 0) { Response.Write(""); }
            else
            {
                Response.Write("<tr><td style='height:23; border:none' valign='top'><b>Submitted To:</b></td>");
                Response.Write("<td valign='top' style='border:none'>");
                for (int i = 0; i < Media.Count; i++)
                {
                    Response.Write(Media[i].ToString() + "<br/>");
                }
            }
            Response.Write("<br/></td></tr>");

            Response.Write("<tr><td style='border:none'><b>Released By:</b></td><td style='border:none'>Robert A. Cardamone, Executive Director<br/><br/></td></tr>");
            Response.Write("<tr><td colspan='2' style='border:none; text-align:center'><span style='font-size:13.5pt; color:#620f2a'>" + dr["HeadlineEmailSubject"].ToString() + "</span><br/><br/></td></tr>");

            //Body of News Release
            Response.Write("<tr><td align='left' colspan='2' style='border:none'>" + dr["Body"].ToString().Replace("\r\n", "<br/>") + "</td></tr>");
            if (!dr.IsDBNull(5))
            {
                //Response.Write("<tr align='center'><td colspan='2' style='border:none; text-align:center'><br/><br/>");
                //Response.ContentType = "image/jpeg";
                //Response.BinaryWrite((byte[])dr["Image"]);
                if (!dr.IsDBNull(myOrdinal))
                {
                    Response.Write("<tr align='center'><td colspan='2' style='border:none; text-align:center'><br/><br/>");
                    Response.Write("<img src='ShowImage.ashx?ID=" + ID.ToString() + "' alt='News Release Image' width='533px'>");
                }
                else
                {

                }
                //img.ImageUrl = "~/ShowImage.ashx?ID=" + ID;

                Response.ContentType = "text/html";
                Response.Write("</td></tr>");
                //Response.Write("<tr><td colspan='2' style='text-align:center; border:none'><hr/></td></tr>");
                if (dr["ImageCaption"].ToString() != "") { Response.Write("<tr><td colspan='2' style='text-align:center; border:none'>" + dr["ImageCaption"].ToString() + "</td></tr>"); }
            }

            //Bottom of news release
            //Response.Write("<tr><td colspan='2' style='text-align:center; border:none'><hr/></td></tr>");
            //Response.Write("<tr><td colspan='2' style='text-align:center; border:none'><b>The official registration and financial information of Community Action, Inc. may be obtained from the Pennsylvania Department of State by calling toll free, within Pennsylvania, 1-800-732-0999. Registration does not imply endorsement.</b></td></tr>");
        }
        Global_Functions.CloseConnection(conn);
    }
}