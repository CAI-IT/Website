using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using Artisteer;

public partial class project : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
        
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select ApprovedID, AppProjectName, AppDescription, AppSuccessStory, AppDisclaimer, AppImgLocation, AppContactInfo, AppCustomHTML, ";
        sql = sql + "AppImageHeading, AppImageCaption, AppWebLinksTitle, AppSuccessStoryHeading, TransPendingID From APPROVED_PROJ_PAGES Where ApprovedID=@ApprovedID";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.Parameters.Add(new SqlParameter("@ApprovedID", Request.QueryString["ProjectID"]));
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            Control art = LoadControl("~/design/Article.ascx");
            art.ID = "Project" + dr["ApprovedID"].ToString();

            //get header and content placeholders for newly created article control
            PlaceHolder header = (PlaceHolder)art.FindControl("HeaderPlaceholder");
            PlaceHolder content = (PlaceHolder)art.FindControl("ContentPlaceholder");


            Literal litHeader = new Literal(); litHeader.Text = dr["AppProjectName"].ToString();
            if (header != null) { header.Controls.Add(litHeader); }

            Literal litContent = new Literal();
            if (dr["AppDescription"].ToString() != "" && dr["AppDescription"].ToString() != " ")
            {
                litContent.Text = litContent.Text + "<br/>" + dr["AppDescription"];
            }
            SqlConnection connCountCounties = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
            connCountCounties.Open();
            string sqlCountCounties = "Select count(ApprovedID) as NumberOfCounties from APPROVED_COUNTY where ApprovedID=@ApprovedID";
            SqlCommand cmdCountCounties = new SqlCommand(sqlCountCounties, connCountCounties);
            int ApprovedID = Convert.ToInt32(Request.QueryString["ProjectID"]);
            cmdCountCounties.Parameters.Add("@ApprovedID", ApprovedID);
            SqlDataReader drCountCounties = cmdCountCounties.ExecuteReader();
            //litContent.Text = "<br/><div align=\"left\" style=\"font-size:10pt\">";
            while (drCountCounties.Read())
            {
                int count = Convert.ToInt32(drCountCounties["NumberOfCounties"]);
                if (count > 0)
                {

                    litContent.Text = litContent.Text + "<br/><b>This project serves ";
                    SqlConnection connService = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
                    connService.Open();
                    string sqlService = "Select CountyServedName from COUNTY_SERVED inner join APPROVED_COUNTY on CountyServedID=CountyID where ApprovedID=@ApprovedID order by CountyServedName";
                    SqlCommand cmdService = new SqlCommand(sqlService, connService);
                    cmdService.Parameters.Add("@ApprovedID", ApprovedID);
                    SqlDataReader drService = cmdService.ExecuteReader(); bool TwoOrMore = false;
                    while (drService.Read())
                    {
                        if (count == 1)
                        {
                            if (TwoOrMore == true)
                            {
                                litContent.Text = litContent.Text + drService["CountyServedName"] + " Counties. </b><br/>";
                            }
                            else
                            {
                                litContent.Text = litContent.Text + drService["CountyServedName"] + " County. </b><br/>";
                            }
                        }
                        else if (count == 2)
                        {
                            litContent.Text = litContent.Text + drService["CountyServedName"] + " and ";
                            TwoOrMore = true;
                        }
                        else if (count >= 3)
                        {
                            litContent.Text = litContent.Text + drService["CountyServedName"] + ", ";
                            TwoOrMore = true;
                        }
                        count = count - 1;
                    }
                    connService.Close(); connService.Dispose();
                }
            }
            litContent.Text = litContent.Text + "<br/><br/>" + dr["AppCustomHTML"];
            // Retrieve Web Links information from database
            SqlConnection connCountRefs = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
            connCountRefs.Open();
            string sqlCountRefs = "Select count(ApprovedID) as NumberOfRefs from APPROVED_LINKS where ApprovedID=@ApprovedID";
            SqlCommand cmdCountRefs = new SqlCommand(sqlCountRefs, connCountRefs);
            // int TransPendingID = Convert.ToInt32(dr["TransPendingID"]);
            cmdCountRefs.Parameters.Add("@ApprovedID", ApprovedID);
            SqlDataReader drCountRefs = cmdCountRefs.ExecuteReader();
            while (drCountRefs.Read())
            {
                int count = Convert.ToInt32(drCountRefs["NumberOfRefs"]);
                if (count > 0)
                {
                    if (dr["AppWebLinksTitle"].ToString() != "") { litContent.Text = litContent.Text + "</br><hr/><br/><h4>" + dr["AppWebLinksTitle"] + "</h4><br/><ul>"; }
                    else { litContent.Text = litContent.Text + "<br/><hr/><br/><h4>Web Links</h4><br/><ul>"; }
                    SqlConnection connRefs = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
                    connRefs.Open();
                    string sqlRefs = "Select ApprovedLinkUrl, ApprovedLinkText from APPROVED_LINKS where ApprovedID=@ApprovedID";
                    SqlCommand cmdRefs = new SqlCommand(sqlRefs, connRefs);
                    cmdRefs.Parameters.Add("@ApprovedID", ApprovedID);
                    SqlDataReader drRefs = cmdRefs.ExecuteReader();
                    while (drRefs.Read())
                    {
                        string LinkText = drRefs["ApprovedLinkText"].ToString(); string LinkUrl = drRefs["ApprovedLinkUrl"].ToString();
                        litContent.Text = litContent.Text + "<li><a href='" + LinkUrl + "'>" + LinkText + "</a></li>";
                    }
                    litContent.Text = litContent.Text + "</ul>";
                    connRefs.Close(); connRefs.Dispose();
                }
            }
            connCountRefs.Close(); connCountRefs.Dispose();
            if (dr["AppContactInfo"].ToString() != "")
            {
                litContent.Text = litContent.Text + "<br/><b>" + dr["AppContactInfo"].ToString().Replace("\n","<br/>") + "</b><br/>";
            }
            if (dr["AppDisclaimer"].ToString() != "")
            {
                litContent.Text = litContent.Text + "<br/><hr/><div align=\"center\" style=\"font-size:8pt\">" + dr["AppDisclaimer"].ToString() + "</div>";
            }
            //litContent.Text = litContent.Text + "</div>";
            content.Controls.Add(litContent);
            PagePanel.Controls.Add(art);

            if (dr["AppSuccessStory"].ToString() != "")
            {
                Control artStory = LoadControl("~/design/Article.ascx");
                //artStory.ID = "SuccessStory" + dr["PendingID"].ToString();
                PlaceHolder headerStory = (PlaceHolder)artStory.FindControl("HeaderPlaceholder");
                PlaceHolder contentStory = (PlaceHolder)artStory.FindControl("ContentPlaceholder");
                Literal litHeaderStory = new Literal(); litHeaderStory.Text = "";
                headerStory.Controls.Add(litHeaderStory);
                Literal litContentStory = new Literal();
                litContentStory.Text = "<div align=\"left\" style=\"font-size:10pt\">";
                string successLink = dr["AppSuccessStory"].ToString();
                string successHeading;
                if (dr["AppSuccessStoryHeading"].ToString() != "")
                { successHeading = dr["AppSuccessStoryHeading"].ToString(); }
                else { successHeading = "Success Story"; }
                string successURL = ConfigurationManager.AppSettings.Get("DevelURL").ToString() + "ApprovedUploads/" + ApprovedID + "/" + successLink;
                litContentStory.Text = litContentStory.Text + "<a href = '" + successURL + "'>" + successHeading + "</a></div>";
                contentStory.Controls.Add(litContentStory);
                PagePanel.Controls.Add(artStory);
            }
        }
        conn.Close(); conn.Dispose();
    }
}