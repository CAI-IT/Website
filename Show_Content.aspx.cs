using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Show_Image : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
    }
    protected void ShowContent(int id)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["NRS"].ConnectionString);
        conn.Open();

        //Clear out existing http header info
        Response.Expires = 0;
        Response.Buffer = true;
        Response.Clear();

        string sql = "Select Text from CONTENT_ROTATOR where ID=" + id;
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
 
        if (dr.HasRows == true)
        {
            while (dr.Read())
            {
                Response.ContentType = "image/jpeg";
                Response.BinaryWrite((byte[])dr["Text"]);
                Response.End();
            }
        }
        else
        {
            Response.Write("");
        }
        Global_Functions.CloseConnection(conn);
    }
}