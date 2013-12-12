using System;
using System.Collections.Generic;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices.AccountManagement;
using System.Configuration;

public partial class contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
        artContact.DataBind();
    }

    protected void btnSubmit_Click(Object sender, EventArgs e) 
    {
        if (Page.IsValid)
        {
            lblEmailError.Visible = false;
            string body = "<table style=\"width=100%; border-width:1px; border-color:black; font-family:Arial\"><tr><td width=\"90%\" ><span style=\"font-size:22.0pt; color: black; font-family:&quot;Arial&quot;;\">Community Action, Inc.</span>";
            body = body + "<span style=\"font-size:10.0pt; color: black; font-family:&quot;Arial&quot;;\"><br/>105 Grace Way, Punxsutawney, PA 15767-1209<br/>";
            body = body + "<i>Phone Number:</i> (814) 938-3302 &nbsp;&nbsp;&nbsp;<i>FAX:</i> (814) 938-7596 <br/> <i>Email:</i>&nbsp;contact@jccap.org&nbsp;&nbsp;&nbsp;<i>Website:</i> <a href=\"http://www.jccap.org\">www.jccap.org</a></u><br/><br/></span>";
            body = body + "<td width=\"10%\" align=\"right\"><img src=\"" + ConfigurationManager.AppSettings.Get("URLRoot") + "images/agency_logo.jpg\" style=\"float:right\"/></td></tr>";
            body = body + "<tr><td colspan=\"2\"><hr width=\"100%\"/><br/></td></tr>";
            body = body + "<tr><td>";
            body = body + "<table style=\"width=100%; font-family:Arial; font-size:10pt\">";
            body = body + "<tr><td><b>Name: </b></td><td>" + txtName.Text + "</td></tr>";
            body = body + "<tr><td><b>Street: </b></td><td>" + txtStreet.Text + "</td></tr>";
            body = body + "<tr><td><b>City: </b></td><td>" + txtCity.Text + "</td></tr>";
            body = body + "<tr><td><b>State: </b></td><td>" + txtState.Text + "</td></tr>";
            body = body + "<tr><td><b>Email Address: </b></td><td>" + txtEmail.Text + "</td></tr>";
            body = body + "<tr><td><b>Phone Number: </b></td><td>" + txtPhone.Text + "</td></tr>";
            body = body + "<tr><td><b>Subject: </b></td><td>" + txtSubject.Text + "</td></tr>";
            body = body + "<tr><td><b>Message: </b></td><td>" + txtMessage.Text + "</td></tr></table>";
            body = body + "</td></tr>";
            body = body + "<tr><td colspan=\"2\"><hr width=\"100%\" style=\"float:right\"/></td></tr>";
            body = body + "<tr><td colspan=\"2\" style=\"text-align:center; font-size:8pt; color:black; font-family:&quot;Arial&quot;;\">";
            body = body + "<b>Our Mission:</b>  To provide and coordinate activities which alleviate poverty, promote family self-sufficiency and advance community prosperity.<br/><br/>";
            body = body + "<b>Our Vision:</b>  To be recognized as a premier organization dedicated to solving social and economic problems of the community.<br/><br/>";
            body = body + "<font color=\"#21344A\">The official registration and financial information of Community Action, Inc. may be obtained from the Pennsylvania Department of State</br>by calling toll free, within Pennsylvania, 1-800-732-0999.  Registration does not imply endorsement.</font></td></tr></table></table>";

            string strRecipients = "";

            //ADMethodsAccountManagement ADMethods = new ADMethodsAccountManagement();
            //GroupPrincipal group = ADMethods.GetGroup("Website Email");
            //foreach (UserPrincipal user in group.GetMembers())
            //{
            //    strRecipients = strRecipients + user.EmailAddress.ToString() + "; ";
            //}

            //strRecipients = strRecipients.TrimEnd(' '); strRecipients = strRecipients.TrimEnd(';');
            if (mail.SendMailMessage(txtEmail.Text, "lsealover@jccap.org", "", "", "CAI Contact Form", body, true, System.Net.Mail.MailPriority.Normal) == true)
            {
                body = "";
                body = "<table style=\"width=100%; font-family:Arial\"><tr><td width=\"90%\"><span style=\"font-size:22.0pt; color: black; font-family:&quot;Arial&quot;;\">Community Action, Inc.</span>";
                body = body + "<span style=\"font-size:10.0pt; color: black; font-family:&quot;Arial&quot;;\"><br/>105 Grace Way, Punxsutawney, PA 15767-1209<br/>";
                body = body + "<i>Phone Number:</i> (814) 938-3302 &nbsp;&nbsp;&nbsp;<i>FAX:</i> (814) 938-7596 <br/> <i>Email:</i>&nbsp;contact@jccap.org &nbsp;&nbsp;&nbsp;<i>Website:</i> <a href=\"http://www.jccap.org\">www.jccap.org</a></u><br/><br/></span></td>";
                body = body + "<td align=\"right\"><img src=\"" + ConfigurationManager.AppSettings.Get("URLRoot") + "images/agency_logo.jpg\" style=\"float:right\"/></td></tr>";
                body = body + "<tr><td colspan=\"2\"><hr width=\"100%\"/><br/></td></tr>";
                body = body + "<table style=\"width=100%; font-family:Arial; font-size:16pt\">";
                body = body + "<tr><td><b>Your message has been sent successfully.</b><br/><br/></td></tr></table>";
                body = body + "<table style=\"width=100%; font-family:Arial; font-size:10pt\">";
                body = body + "<tr><td><b>Name: </b></td><td>" + txtName.Text + "</td></tr>";
                body = body + "<tr><td><b>Street: </b></td><td>" + txtStreet.Text + "</td></tr>";
                body = body + "<tr><td><b>City: </b></td><td>" + txtCity.Text + "</td></tr>";
                body = body + "<tr><td><b>State: </b></td><td>" + txtState.Text + "</td></tr>";
                body = body + "<tr><td><b>Email Address: </b></td><td>" + txtEmail.Text + "</td></tr>";
                body = body + "<tr><td><b>Phone Number: </b></td><td>" + txtPhone.Text + "</td></tr>";
                body = body + "<tr><td><b>Subject: </b></td><td>" + txtSubject.Text + "</td></tr>";
                body = body + "<tr><td><b>Message: </b></td><td>" + txtMessage.Text + "</td></tr></table>";
                body = body + "<tr><td colspan=\"2\"><hr width=\"100%\"/></td></tr>";
                body = body + "<tr><td colspan=\"2\" style=\"text-align:center; font-size:8pt; color:black; font-family:&quot;Arial&quot;;\">";
                body = body + "<b>Our Mission:</b>  To provide and coordinate activities which alleviate poverty, promote family self-sufficiency and advance community prosperity.<br/><br/>";
                body = body + "<b>Our Vision:</b>  To be recognized as a premier organization dedicated to solving social and economic problems of the community.<br/><br/>";
                body = body + "<font color=\"#21344A\">The official registration and financial information of Community Action, Inc. may be obtained from the Pennsylvania Department of State</br>by calling toll free, within Pennsylvania, 1-800-732-0999.  Registration does not imply endorsement.</font></td></tr></table></table>";

                try { bool tmsg = mail.SendMailMessage("no_reply@jccap.org", txtEmail.Text, "", "", "Community Action, Inc. - Contact Form", body, true, System.Net.Mail.MailPriority.Normal); }
                catch { }


                Response.Redirect("contact_success.aspx");
            }
            else { Response.Redirect("contact_failure.aspx"); }
        }
        else {
            lblEmailError.Visible = true;
        }
    }

    protected void btnReset_Click(Object sender, EventArgs e) 
    {
        txtSubject.Text = "";
        txtMessage.Text = "";
        txtName.Text = "";
        txtStreet.Text = "";
        txtCity.Text = "";
        txtState.Text = "";
        txtEmail.Text = "";
        txtPhone.Text = "";
        recaptcha.DataBind();
    }
}