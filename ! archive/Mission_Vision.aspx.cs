﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Mission_Vision : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
    }
}