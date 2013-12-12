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

public partial class Holiday2013 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    protected void grdHoliday_Insert(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();

        TextBox txtName = (TextBox)grdHoliday.FooterRow.FindControl("txtName");
        TextBox txtCD = (TextBox)grdHoliday.FooterRow.FindControl("txtCoveredDish");
        CheckBox cb = (CheckBox)grdHoliday.FooterRow.FindControl("cbGiftExchange");
        string sql = "Insert into HOLIDAY_2013 (Name, CoveredDish, GiftExchange) values (@Name, @CoveredDish, @GiftExchange)";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.Parameters.Add("@Name", txtName.Text);
        cmd.Parameters.Add("@CoveredDish", txtCD.Text);
        cmd.Parameters.Add("@GiftExchange", cb.Checked);
        cmd.ExecuteNonQuery();
        grdHoliday.DataBind();
        conn.Close(); conn.Dispose();
    }
}