using System;
using System.Collections.Generic;
using System.Web;
using System.Net.Mail;

/// <summary>
/// Class used to send a mail message.
/// Jason Werwie
/// </summary>
public class mail
{
	public mail()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //function to send email. Returns true if successful, returns false if unsuccessful
    public static bool SendMailMessage(string from, string recipient, string bcc, string cc, string subject, string body, bool isHTML, MailPriority priority)
    {
        try
        {
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress(from); //set from address
            string[] arrRecipients = recipient.Split(';'); //add recipients to "TO" field
            foreach (object x in arrRecipients) { msg.To.Add(new MailAddress(x.ToString())); }

            if (bcc != "" && bcc != null) { msg.Bcc.Add(new MailAddress(bcc)); } //set bcc field
            if (cc != "" && cc != null) { msg.CC.Add(new MailAddress(cc)); } //set cc field
            msg.Subject = subject; //set subject field

            if (isHTML == false) { msg.IsBodyHtml = false; } //set HTML option depending on param
            else { msg.IsBodyHtml = true; }

            msg.Body = body; //set body
            msg.Priority = priority; //set message priority

            SmtpClient client = new SmtpClient(); //new SMTP client - settings in web.config
            client.Send(msg); //send message
        }
        catch {return false; }
        
        return true;
    }
}