using System;
using System.DirectoryServices;
using System.Collections.Generic;
using System.Web;
using System.Collections;
using System.Configuration;
using System.Data.SqlClient;

/// <summary>
/// These are all common functions used throughout the website
/// </summary>
public class Global_Functions
{
    public static string TruncateAtWord(string s, int length, bool atWord, bool addEllipsis)
    {
        // Return if the string is less than or equal to the truncation length
        if (s == null || s.Length <= length)
            return s;

        // Do a simple tuncation at the desired length
        string s2 = s.Substring(0, length);

        // Truncate the string at the word
        if (atWord)
        {
            // List of characters that denote the start or a new word (add to or remove more as necessary)
            List<char> alternativeCutOffs = new List<char>();
            alternativeCutOffs.Add(' ');
            alternativeCutOffs.Add(',');
            alternativeCutOffs.Add('.');
            alternativeCutOffs.Add('?');
            alternativeCutOffs.Add('/');
            alternativeCutOffs.Add(':');
            alternativeCutOffs.Add(';');
            alternativeCutOffs.Add('\'');
            alternativeCutOffs.Add('\"');
            alternativeCutOffs.Add('-');

            // Get the index of the last space in the truncated string
            int lastSpace = s2.LastIndexOf(' ');

            // If the last space index isn't -1 and also the next character in the original
            // string isn't contained in the alternativeCutOffs List (which means the previous
            // truncation actually truncated at the end of a word),then shorten string to the last space
            if (lastSpace != -1 && (s.Length >= length + 1 && !alternativeCutOffs.Contains(s.ToCharArray()[length])))
                s2 = s2.Remove(lastSpace);
        }

        // Add Ellipsis if desired
        if (addEllipsis)
            s2 += "...";

        return s2;
    }

    public static string EmailBody(int JID)
    {
        int queryJID = JID;
        string paragraphs = "", postingDate = "", positionTitle = "", flsaStatus = "", positionType = "", path = "", fileName = "", emailFrom = "";
        decimal payRate = 00;
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["JOB"].ToString());
        conn.Open();
        string sql = "Select PARAGRAPHS,POSTING_DATE, TITLE, STATUS, TYPE, PAY_RATE, PATH, EMAILED_FROM FROM JOB_ANNOUNCEMENTS as JA INNER JOIN POSITION_TITLE as PT on JA.POSITION_ID=PT.ID INNER JOIN FLSA_STATUS as FS on JA.FLSA_Status=FS.ID INNER JOIN POSITION_TYPE as POSTYPE on JA.POSITION_TYPE=POSTYPE.ID INNER JOIN JOB_DESCRIPTION as JD on JA.Position_ID=JD.Position_ID Where JID=" + queryJID;
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            paragraphs = dr["Paragraphs"].ToString();
            postingDate = (Convert.ToDateTime(dr["Posting_Date"]).ToShortDateString()).ToString();
            positionTitle = dr["Title"].ToString();
            flsaStatus = dr["Status"].ToString();
            positionType = dr["Type"].ToString();
            payRate = (Convert.ToDecimal(dr["Pay_Rate"]));
            path = dr["Path"].ToString();
            emailFrom = dr["Emailed_From"].ToString();
        }
        dr.Close();

        int position = path.LastIndexOf("\\") + 1;
        fileName = path.Substring(position);


        Global_Functions.CloseConnection(conn);

        string imagePath = ConfigurationManager.AppSettings.Get("ImageRoot");

        //HEADER
        string body = "<div><table style=\"border:none\"><tr>";
        body = body + "<td valign=\"center\" style=\"border:none\">";
        body = body + "<span style=\"font-size:22.0pt; color: black; font-family:&quot;Arial&quot;;\">Community Action, Inc.</span>";
        body = body + "<span style=\"font-size:10.0pt; color: black; font-family:&quot;Arial&quot;;\"><br/>105 Grace Way, Punxsutawney, PA 15767-1209<br/>";
        body = body + "<i>Phone Number:</i> (814) 938-3302 &nbsp;&nbsp;&nbsp;<i>FAX:</i> (814) 938-7596 <br/> <i>Email:</i> " + emailFrom + " &nbsp;&nbsp;&nbsp;<i>Website:</i> <a href=\"http://www.jccap.org\">www.jccap.org</a></u><br/><br/></span></td>";
        body = body + "<td style=\"border:none\" valign=\"top\"><img src=\"" + imagePath + "Logo.jpg\" align=\"right\"></td></tr>";
        //POSTING DATE & ANNOUNCEMENT NUMBER
        body = body + "<tr><td style=\"border:none\" colspan=\"2\" valign=\"top\"><hr>";
        body = body + "<i><span style=\"font-size:10.0pt; color:black; font-family:&quot;Arial&quot;;\"><b>Announcement Number:</b> </span>";
        body = body + "<span style=\"font-size:10.0pt;color:black;font-family:&quot;Arial&quot;;\">" + queryJID + "</span></i><br/>";
        body = body + "<i><span style=\"font-size:10.0pt; color:black; font-family:&quot;Arial&quot;;\"><b>Posted On:</b> " + postingDate + "</span></i><br/><br/></td></tr>";

        //PARAGRAPHS INCLUDING DEFAULT
        body = body + "<tr><td style=\"border:none\" colspan=\"2\" valign=\"top\">";
        body = body + "<span style=\"font-size:10.0pt; color:black; font-family:&quot;Arial&quot;;\">";
        body = body + paragraphs;


        string website = ConfigurationManager.AppSettings.Get("JobDescRoot") + "" + fileName.Replace(" ", "%20");
        string websiteRoot = ConfigurationManager.AppSettings.Get("URLRoot");
        //JOB DESCRIPTION
        body = body + "<br/><br/><b><a href=" + website + "><i>Click here to view the job description</i></a></b>";
        body = body + "<br/><br/><b><a href=" + websiteRoot + "employment.aspx" + "><i>Click here to view the application instructions</a></i></b></span></tr></td>";
        
        //FOOTER
        body = body + "<tr><td colspan=\"2\" valign=\"top\" style=\"border:none; font-family:&quot;Arial&quot;; text-align:center; font-size:8pt; color:black\"><br/><hr><br/>";
        body = body + "<b>Our Mission:</b>  To provide and coordinate activities which alleviate poverty, promote family self-sufficiency and advance community prosperity.<br/><br/>";
        body = body + "<b>Our Vision:</b>  To be recognized as a premier organization dedicated to solving social and economic problems of the community.<br/><br/>";
        body = body + "<font color=\"#21344A\">The official registration and financial information of Community Action, Inc. may be obtained from the Pennsylvania Department of State</br>by calling toll free, within Pennsylvania, 1-800-732-0999.  Registration does not imply endorsement.</font></tr></td></table></div>";
        return body;
    }

    public static void CloseConnection(SqlConnection conn)
    {
        conn.Close();
        conn.Dispose();
    }

    public static void AddTransaction(int projectID, string action, string username)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
        string sql = "Insert Into TRANS_HISTORY (ProjectID, Username, Date, Time, Action) values (@ProjectID, @Username, @Date, @Time, @Action)";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.Parameters.Add("@ProjectID", projectID);
        cmd.Parameters.Add("@Username", username);
        cmd.Parameters.Add("@Date", DateTime.Now.Date.ToShortDateString());
        cmd.Parameters.Add("@Time", DateTime.Now.ToShortTimeString());
        cmd.Parameters.Add("@Action", action);
        cmd.ExecuteNonQuery();
        conn.Close(); conn.Dispose();
    }

    public static bool CheckStringForSQLInjection(string str, bool Semicolon)
    {
        //create array list of blacklisted characters or groups of characters
        ArrayList Blacklist = new ArrayList();
        Blacklist.Add("--"); Blacklist.Add("%3B"); Blacklist.Add("/*"); Blacklist.Add("*/");
        Blacklist.Add("<script"); Blacklist.Add("banner82"); Blacklist.Add("</script>");
        if (Semicolon == true) { Blacklist.Add(";"); }

        if (String.IsNullOrEmpty(str) == true) { return false; }
        str = str.Replace("'", "\'"); string lstr = str.ToLower();

        for (int i=0; i < Blacklist.Count; i++)
        {
            if (lstr.IndexOf(Blacklist[i].ToString(), 0) != -1) { return true; }
        }
        return false;
    }

    public static bool CheckQueryStringAndCookiesForSQLInjection()
    {
        for (int i=0; i < HttpContext.Current.Request.QueryString.Count; i++)
        {
            try{if (CheckStringForSQLInjection(HttpContext.Current.Request.QueryString[i].ToString(), true) == true) { return true; }}
            catch { return true; }
        }

        String[] cookieArray = HttpContext.Current.Request.Cookies.AllKeys;
        for (int i=0; i < cookieArray.Length; i++)
        {
            try { if (CheckStringForSQLInjection(cookieArray[i].ToString(), true) == true) { return true; } }
            catch { return true; }
        }

        return false;
    }
}