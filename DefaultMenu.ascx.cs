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

public partial class Menu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
    }

    protected void LoadMenu()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();

        string sql = "Select LinkID, Name, Location, DocumentID, OrderCol, LinkTypeID From NAV_MAINLINK Order By OrderCol";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter daMain = new SqlDataAdapter(cmd); DataSet ds = new DataSet();
        daMain.Fill(ds, "MainLinks");
        foreach (DataRow datarow in ds.Tables["MainLinks"].Rows)
        {
            if (datarow[5].ToString() == "2")
            {
                Response.Write("<li><a href=\"" + datarow[2].ToString() + "\"><span class=\"l\"></span><span class=\"r\"></span><span class=\"t\">" + datarow[1].ToString() + "</span></a>");
            }
            else if (datarow[5].ToString() == "3")
            {
                //get location of document
                String loc = "";
                sql = "Select Location From NAV_DOCUMENT Where DocumentID=" + datarow[3].ToString();
                SqlDataAdapter daDoc = new SqlDataAdapter(sql, conn);
                daDoc.Fill(ds, "Document");
                foreach (DataRow drDoc in ds.Tables["Document"].Rows) { loc = drDoc[0].ToString(); }
                daDoc.Dispose();

                //write menu item
                Response.Write("<li><a href=\"" + loc + "\"><span class=\"l\"></span><span class=\"r\"></span><span class=\"t\">" + datarow[1].ToString() + "</span></a>");
            }

            if (datarow[1].ToString() == "Projects")
            {
                //get project pages and create links.
                sql = "Select ApprovedID, AppProjectName, AppLinkName From APPROVED_PROJ_PAGES Where Approved=1 and Visible=1 Order By AppLinkName";
                cmd = new SqlCommand(sql, conn);
                SqlDataAdapter daProjects = new SqlDataAdapter(cmd);
                daProjects.Fill(ds, "Projects");
                Response.Write("<ul>");
                foreach (DataRow drProjects in ds.Tables["Projects"].Rows)
                {
                    Response.Write("<li><a href=\"project.aspx?ProjectID=" + drProjects[0].ToString() + "\"><span class=\"l\"></span><span class=\"r\"></span><span class=\"t\">" + drProjects[2].ToString() + "</span></a></li>");
                }
                Response.Write("</ul>");
            }

            else
            {
                //get child elements
                sql = "Select LinkID, Name, Location, DocumentID, OrderCol, LinkTypeID From NAV_SUBLINK1 Where ParentLink=@ParentLink Order By OrderCol";
                cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add(new SqlParameter("@ParentLink", datarow[0]));
                SqlDataAdapter daSublink1 = new SqlDataAdapter(cmd);
                daSublink1.Fill(ds, "Sublink1");
                int i = 0;
                foreach (DataRow drSublink1 in ds.Tables["Sublink1"].Rows)
                {
                    if (i == 0) { Response.Write("<ul>"); } i++;
                    if (drSublink1[5].ToString() == "2")
                    {
                        Response.Write("<li><a href=\"" + drSublink1[2].ToString() + "\"><span class=\"l\"></span><span class=\"r\"></span><span class=\"t\">" + drSublink1[1].ToString() + "</span></a>");
                    }
                    else if (drSublink1[5].ToString() == "3")
                    {
                        //get location of document
                        String loc = "";
                        sql = "Select Location From NAV_DOCUMENT Where DocumentID=" + drSublink1[3].ToString();
                        SqlDataAdapter daDoc = new SqlDataAdapter(sql, conn);
                        daDoc.Fill(ds, "Document");
                        foreach (DataRow drDoc in ds.Tables["Document"].Rows) { loc = drDoc[0].ToString(); }
                        daDoc.Dispose();

                        //write menu item
                        Response.Write("<li><a href=\"" + loc + "\"><span class=\"l\"></span><span class=\"r\"></span><span class=\"t\">" + drSublink1[1].ToString() + "</span></a>");
                    }

                    //get child elements
                    sql = "Select LinkID, Name, Location, DocumentID, OrderCol, LinkTypeID From NAV_SUBLINK2 Where ParentLink=@ParentLink Order By OrderCol";
                    cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.Add(new SqlParameter("@ParentLink", drSublink1[0]));
                    SqlDataAdapter daSublink2 = new SqlDataAdapter(cmd);
                    daSublink2.Fill(ds, "Sublink2");
                    int j = 0;
                    foreach (DataRow drSublink2 in ds.Tables["Sublink2"].Rows)
                    {
                        if (j == 0) { Response.Write("<ul>"); } j++;
                        if (drSublink2[5].ToString() == "2")
                        {
                            Response.Write("<li><a href=\"" + drSublink2[2].ToString() + "\"><span class=\"l\"></span><span class=\"r\"></span><span class=\"t\">" + drSublink2[1].ToString() + "</span></a></li>");
                        }
                        else if (drSublink2[5].ToString() == "3")
                        {
                            //get location of document
                            String loc = "";
                            sql = "Select Location From NAV_DOCUMENT Where DocumentID=" + drSublink2[3].ToString();
                            SqlDataAdapter daDoc = new SqlDataAdapter(sql, conn);
                            daDoc.Fill(ds, "Document");
                            foreach (DataRow drDoc in ds.Tables["Document"].Rows) { loc = drDoc[0].ToString(); }
                            daDoc.Dispose();

                            //write menu item
                            Response.Write("<li><a href=\"" + loc + "\"><span class=\"l\"></span><span class=\"r\"></span><span class=\"t\">" + drSublink2[1].ToString() + "</span></a></li>");
                        }
                    }
                    if (j != 0) { Response.Write("</ul>"); }
                    Response.Write("</li>");
                    ds.Tables.Remove("Sublink2");
                }
                if (i != 0) { Response.Write("</ul>"); }
                Response.Write("</li>");
                ds.Tables.Remove("Sublink1");
            }
        }
        Global_Functions.CloseConnection(conn);
    }
}
