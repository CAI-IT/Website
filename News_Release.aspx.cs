using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class News_Release : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
    }

    // This function builds the content of a news release and outputs it into the parent object
    // Function needs to be passed the NRID
    public void BuildNewsRelease(int NRID)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Intranet"].ConnectionString);
        conn.Open();

        string sql = "Select * From NewsReleasesMedia Where NRID=" + NRID + "";
        List<string> Media = new List<string>();
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            Media.Add(dr["MediaName"].ToString());
        }
        dr.Close();

        sql = "Select Heading, ReleaseDate, ReleaseInfo, ReleaseTitle1, ReleaseTitle2, Image, ID, PictureCaption From NewsReleases as R left outer join NewsReleaseImages as I on I.RID=R.ReleaseID Where ReleaseID=" + NRID + "";
        cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            Response.Write("<tr><td colspan='2' style='border:none; text-align:center'><span style='font-size:13.5pt; color:#620f2a'><u>" + dr["Heading"].ToString() + "</u></span><br/><br/></td></tr>");
            
            Response.Write("<tr><td style='width:22%; border:none'><b>Release Date:</b></td>");
            DateTime ReleaseDate = Convert.ToDateTime(dr["ReleaseDate"]);
            Response.Write("<td style='width:78%; border:none'>" + ReleaseDate.ToString("D") + "<br/><br/></td></tr>");

            Response.Write("<tr><td style='height:23; border:none' valign='top'><b>Submitted To:</b></td>");
            Response.Write("<td valign='top' style='border:none'>");
            if (Media.Count == 0) { Response.Write("Not Submitted to Media"); }
            else
            {
                for (int i = 0; i < Media.Count; i++)
                {
                    Response.Write(Media[i].ToString() + "<br/>");
                }

            }
            Response.Write("<br/></td></tr>");

            Response.Write("<tr><td style='border:none'><b>Released By:</b></td><td style='border:none'>Robert A. Cardamone, Executive Director<br/><br/></td></tr>");
            Response.Write("<tr><td colspan='2' style='border:none; text-align:center'><span style='font-size:13.5pt; color:#620f2a'>" + dr["ReleaseTitle1"].ToString() + "<br/>" + dr["ReleaseTitle2"].ToString() + "</span><br/><br/></td></tr>");
            
            //Body of News Release
            Response.Write("<tr><td align='left' colspan='2' style='border:none'>" + dr["ReleaseInfo"].ToString().Replace("\r\n","<br/>") + "</td></tr>");
            if (!dr.IsDBNull(5))
            {
                Response.Write("<tr align='center'><td colspan='2' style='border:none; text-align:center'><br/><br/>");
                //Response.ContentType = "image/jpeg";
                //Response.BinaryWrite((byte[])dr["Image"]);
                Response.Write("<img src='Show_Image.aspx?ID=" + dr["ID"].ToString() + "' alt='News Release Image'/>");
                Response.ContentType = "text/html";
                Response.Write("</td></tr>");
                //Response.Write("<tr><td colspan='2' style='text-align:center; border:none'><hr/></td></tr>");
                if (dr[7].ToString() != "") { Response.Write("<tr><td colspan='2' style='text-align:center; border:none'>" + dr[7].ToString() + "</td></tr>"); }
            }

            //Bottom of news release
            //Response.Write("<tr><td colspan='2' style='text-align:center; border:none'><hr/></td></tr>");
            //Response.Write("<tr><td colspan='2' style='text-align:center; border:none'><b>The official registration and financial information of Community Action, Inc. may be obtained from the Pennsylvania Department of State by calling toll free, within Pennsylvania, 1-800-732-0999. Registration does not imply endorsement.</b></td></tr>");
        }
        Global_Functions.CloseConnection(conn);
    }
}