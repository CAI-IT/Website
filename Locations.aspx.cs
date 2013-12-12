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

public partial class Locations : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();

        string sql = "Select Heading, Text From LOCATIONS Order by OrderCol";
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
            locationsPanel.Controls.Add(art);
        }
        dr.Close(); Global_Functions.CloseConnection(conn);
    }
}
