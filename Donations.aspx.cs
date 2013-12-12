using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Donations : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
        LoadPage();
    }

    protected void LoadPage()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Select Heading, Text, OrderCOl From DONATION_PAGE Where Active=1 Order By OrderCol";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader(); int i = 0;
        while (dr.Read())
        {
            //-----create new article control---------
            //Load control from template and assign unique ID
            Control art = LoadControl("~/design/Article.ascx");
            art.ID = dr["Heading"].ToString() + i.ToString(); i++;

            //get header and content placeholders for newly created article control
            PlaceHolder header = (PlaceHolder)art.FindControl("HeaderPlaceholder");
            PlaceHolder content = (PlaceHolder)art.FindControl("ContentPlaceholder");

            //assign header to a literal control
            Literal litHeader = new Literal(); litHeader.Text = dr["Heading"].ToString();

           //assign text to a literal control
            Literal litText = new Literal(); litText.Text = dr["Text"].ToString();

            //add literals to placeholders and add article to PagePanel
            if (header != null && content != null) { header.Controls.Add(litHeader); content.Controls.Add(litText); }
            PagePanel.Controls.Add(art);
        }
        dr.Close(); Global_Functions.CloseConnection(conn);
    }
}