using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using Artisteer;

public partial class Links : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
        LoadLinks();
    }

    protected void LoadLinks()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select GroupID, GroupName, GOrder From LINK_GROUP Order By GOrder";
        SqlCommand cmd = new SqlCommand(sql, conn); DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds, "GROUPS"); int i = 1;
        foreach (DataRow dr in ds.Tables["GROUPS"].Rows)
        {
            //-----create new article control with links-----------
            //Load control from template and assign unique ID
            Control art = LoadControl("~/design/Article.ascx");
            art.ID = dr[1].ToString() + i.ToString();

            //get header and content placeholders for newly created article control
            PlaceHolder header = (PlaceHolder)art.FindControl("HeaderPlaceholder");
            PlaceHolder content = (PlaceHolder)art.FindControl("ContentPlaceholder");

            //assign GroupName to a literal control
            Literal litHeader = new Literal(); litHeader.Text = dr[1].ToString();
            
            //loop through all links with the selected GroupID and add <li> and <a> tags containing location and name to a literal control
            sql = "Select LinkID, LinkName, Location, LOrder From LINK Where LinkGroupID=@LinkGroupID Order By LOrder";
            cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@LinkGroupID", dr[0]));
            SqlDataAdapter daLinks = new SqlDataAdapter(cmd);
            Literal litContent = new Literal();
            litContent.Text = "<ul style=\"margin-left:0px\">";
            daLinks.Fill(ds, "LINKS");
            foreach (DataRow dr2 in ds.Tables["LINKS"].Rows)
            {
                litContent.Text = litContent.Text + "<li><a target=\"_blank\" href=\"" + dr2[2].ToString() + "\">" + dr2[1].ToString() + "</a></li>";
            }
            ds.Tables.Remove("LINKS"); i++;litContent.Text = litContent.Text + "</ul>";
            
            //add literals to placeholders and add article to PagePanel
            if (header != null && content != null) { header.Controls.Add(litHeader); content.Controls.Add(litContent); }
            PagePanel.Controls.Add(art);
        }
        Global_Functions.CloseConnection(conn);
    }
}