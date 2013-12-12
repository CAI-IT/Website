using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class board : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Global_Functions.CheckQueryStringAndCookiesForSQLInjection() == true) { Response.Redirect("contact_failure.aspx"); }
        
        artMeetings.DataBind(); artBoardMembers.DataBind();
    }

    protected void BuildMeetings()
    {
        Response.Write("<br/>");

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        conn.Open();
       
        string sql = "Select MeetingDate, MeetingType From BOARD_MEETING Order By MeetingDate";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Response.Write("<ul><li>" + String.Format("{0:dddd, MMMM d, yyyy}", dr["MeetingDate"]) + " - " + dr["MeetingType"] + "</li></ul>");
            }
        }
        else { artMeetings.Visible = false; }
        dr.Close();

        Response.Write("<br/>");

        sql = "Select MeetingText From BOARD_MEETING_TEXT Where Active=1";
        cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            Response.Write(dr["MeetingText"]);
        }
        conn.Close(); conn.Dispose();
    }


    protected void BuildMembers()
    {
        Response.Write("<br/>");
        
        // Go through each field and if it is selected display a column header
        Response.Write("<table class='sortable' style=\"width:100%\">");

        SqlConnection connHeader = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        connHeader.Open();
        string sqlHeader = "Select FieldID, Website from DISPLAY_FIELDS Order By WebsiteOrderCol";
        SqlCommand cmdHeader = new SqlCommand(sqlHeader, connHeader);
        SqlDataReader drHeader = cmdHeader.ExecuteReader();
        if (drHeader.HasRows)
        {
            while (drHeader.Read())
            {
                if (Convert.ToInt32(drHeader["FieldID"]) == 2 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Name" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 3 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Sector" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 4 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "County" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 5 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Board Position" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 6 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Original Term" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 7 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Current Term" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 8 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Mailing Address" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 9 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Home Address" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 10 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Work Address" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 11 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Primary Phone" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 12 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Home Phone" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 13 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Work Phone" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 14 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Mobile Phone" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 15 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Primary Email" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 16 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Committees" + "</th>");
                }
                if (Convert.ToInt32(drHeader["FieldID"]) == 17 && Convert.ToInt32(drHeader["Website"]) == 1)
                {
                    Response.Write("<th style='background:#335371; color:white; font-size:11pt'>" + "Primary Fax" + "</th>");
                }
            }
        }
        drHeader.Close();
        connHeader.Close(); connHeader.Dispose();

        // Go through each board member and display the information designated by the display fields table
        SqlConnection connMember = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        connMember.Open();
        string sqlMember = "Select * from BOARD_MEMBER Where Disposed = 0 Order By LastName;";
        SqlCommand cmdMember = new SqlCommand(sqlMember, connMember);
        SqlDataReader drMember = cmdMember.ExecuteReader();
        int MemberID; int PrefixNum; int SectorNum; int CountyNum; int PositionNum;
        string FirstName; string LastName; string MiddleInitial;  string TermStart; string TermEnd; string OriginalTermStart;
        string HomeAddress; string HomeCity; string HomeZip; int HomeStateNum;
        string WorkPlace; string WorkAddress; string WorkCity; string WorkZip; int WorkStateNum;
        string HomePhone; string MobilePhone; string WorkPhone; string extension;
        int MailingAddress; int PrimaryPhone; int PrimaryEmail; int PrimaryFax;
        string HomeEmail; string WorkEmail; string HomeFax; string WorkFax;
        int chkTermEnd;
        if (drMember.HasRows)
        {
            while (drMember.Read())
            {
                MemberID = Convert.ToInt32(drMember["MemberID"]);
                PrefixNum = Convert.ToInt32(drMember["Prefix"]);
                FirstName = drMember["FirstName"].ToString();
                LastName = drMember["LastName"].ToString();
                MiddleInitial = drMember["MiddleInitial"].ToString();
                SectorNum = Convert.ToInt32(drMember["Sector"]);
                CountyNum = Convert.ToInt32(drMember["County"]);
                PositionNum = Convert.ToInt32(drMember["Position"]);
                TermStart = drMember["TermStart"].ToString();
                TermEnd = drMember["TermEnd"].ToString();
                OriginalTermStart = drMember["OriginalTermStart"].ToString();
                HomeAddress = drMember["HomeAddress"].ToString();
                HomeCity = drMember["HomeCity"].ToString();
                HomeZip = drMember["HomeZip"].ToString();
                HomeStateNum = Convert.ToInt32(drMember["HomeState"]);
                WorkPlace = drMember["WorkPlace"].ToString();
                WorkAddress = drMember["WorkAddress"].ToString();
                WorkCity = drMember["WorkCity"].ToString();
                WorkZip = drMember["WorkZip"].ToString();
                WorkStateNum = Convert.ToInt32(drMember["WorkState"]);
                HomePhone = drMember["HomePhone"].ToString();
                MobilePhone = drMember["MobilePhone"].ToString();
                WorkPhone = drMember["WorkPhone"].ToString();
                MailingAddress = Convert.ToInt32(drMember["MailingAddress"]);
                PrimaryPhone = Convert.ToInt32(drMember["PrimaryPhone"]);
                PrimaryEmail = Convert.ToInt32(drMember["PrimaryEmail"]);
                HomeEmail = drMember["HomeEmail"].ToString();
                WorkEmail = drMember["WorkEmail"].ToString();
                PrimaryFax = Convert.ToInt32(drMember["PrimaryFax"]);
                HomeFax = drMember["HomeFax"].ToString();
                WorkFax = drMember["WorkFax"].ToString();
                chkTermEnd = Convert.ToInt32(drMember["chkTermEnd"]);
                extension = drMember["extension"].ToString();

                // Row begins outside of progression through the display fields checklist
                Response.Write("<tr>");
                SqlConnection connField = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
                connField.Open();
                string sqlField = "Select FieldID, FieldName, Website from DISPLAY_FIELDS Order By WebsiteOrderCol";
                SqlCommand cmdField = new SqlCommand(sqlField, connField);
                SqlDataReader drField = cmdField.ExecuteReader();
                if (drField.HasRows)
                {
                    while (drField.Read())
                    {
                        if (Convert.ToInt32(drField["FieldID"]) == 2 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            SqlConnection connPrefix = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
                            connPrefix.Open();
                            string sqlPrefix = "Select Prefix from BOARD_PREFIX WHERE PrefixID=@PrefixID";
                            SqlCommand cmdPrefix = new SqlCommand(sqlPrefix, connPrefix);
                            cmdPrefix.Parameters.Add("@PrefixID", PrefixNum);
                            SqlDataReader drPrefix = cmdPrefix.ExecuteReader();
                            while (drPrefix.Read())
                            {
                                Response.Write("<td style='padding:10px' sorttable_customkey='" + LastName + "'>" + drPrefix["Prefix"].ToString() + " " + FirstName + " ");
                                if (MiddleInitial != "")
                                    Response.Write(MiddleInitial + ". " + LastName + "</td>");
                                else
                                    Response.Write(LastName + "</td>");
                            }
                            drPrefix.Close();
                            connPrefix.Close(); connPrefix.Dispose();
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 3 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            SqlConnection connSector = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
                            connSector.Open();
                            string sqlSector = "Select Sector from BOARD_SECTOR where SectorID=@SectorID";
                            SqlCommand cmdSector = new SqlCommand(sqlSector, connSector);
                            cmdSector.Parameters.Add("@SectorID", SectorNum);
                            SqlDataReader drSector = cmdSector.ExecuteReader();
                            while (drSector.Read())
                            {
                                Response.Write("<td style='padding:10px'>" + drSector["Sector"].ToString() + "</td>");
                            }
                            drSector.Close();
                            connSector.Close(); connSector.Dispose();
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 4 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            SqlConnection connCounty = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
                            connCounty.Open();
                            string sqlCounty = "Select CountyName from COUNTY where CountyID=@CountyID";
                            SqlCommand cmdCounty = new SqlCommand(sqlCounty, connCounty);
                            cmdCounty.Parameters.Add("@CountyID", CountyNum);
                            SqlDataReader drCounty = cmdCounty.ExecuteReader();
                            while (drCounty.Read())
                            {
                                Response.Write("<td style='padding:10px'>" + drCounty["CountyName"].ToString() + "</td>");
                            }
                            drCounty.Close();
                            connCounty.Close(); connCounty.Dispose();
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 5 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            SqlConnection connPosition = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
                            connPosition.Open();
                            string sqlPosition = "Select BoardPosition from BOARD_POSITION where BoardPositionID=@BoardPositionID";
                            SqlCommand cmdPosition = new SqlCommand(sqlPosition, connPosition);
                            cmdPosition.Parameters.Add("@BoardPositionID", PositionNum);
                            SqlDataReader drPosition = cmdPosition.ExecuteReader();
                            while (drPosition.Read())
                            {
                                Response.Write("<td style='padding:10px'>" + drPosition["BoardPosition"].ToString() + "</td>");
                            }
                            drPosition.Close();
                            connPosition.Close(); connPosition.Dispose();
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 6 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            Response.Write("<td style='padding:10px'>" + OriginalTermStart + "</td>");

                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 7 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            if (TermStart != "")
                            {
                                Response.Write("<td style='padding:10px'>" + TermStart + " - ");
                                if (chkTermEnd == 1)
                                {
                                    Response.Write("End of Term" + "</td>");
                                }
                                else
                                {
                                    Response.Write(TermEnd + "</td>");
                                }
                            }
                            else
                                Response.Write("<td>&nbsp;</td>");
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 8 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            if (MailingAddress == 1 && HomeAddress != "")
                            {
                                string HomeState = StateLookUp(HomeStateNum);
                                Response.Write("<td style='padding:10px'>" + HomeAddress + "</br>" + HomeCity + ", " + HomeState + " " + HomeZip + "</td>");
                            }
                            else if (MailingAddress == 2 && WorkAddress != "")
                            {
                                string WorkState = StateLookUp(WorkStateNum);
                                Response.Write("<td style='padding:10px'>" + WorkPlace + "</br>" + WorkAddress + "</br>" + WorkCity + ", " + WorkState + " " + WorkZip + "</td>");
                            }
                            else
                            {
                                Response.Write("<td>&nbps;</td>");
                            }
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 9 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            if (HomeAddress != "")
                            {
                                string HomeState = StateLookUp(HomeStateNum);
                                Response.Write("<td style='padding:10px'>" + HomeAddress + "</br>" + HomeCity + ", " + HomeState + " " + HomeZip + "</td>");
                            }
                            else
                                Response.Write("<td>&nbsp;</td>");
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 10 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            if (WorkAddress != "")
                            {
                                string WorkState = StateLookUp(WorkStateNum);
                                Response.Write("<td style='padding:10px'>" + WorkPlace + "</br>" + WorkAddress + "</br>" + WorkCity + ", " + WorkState + " " + WorkZip + "</td>");
                            }
                            else
                                Response.Write("<td>&nbsp;</td>");
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 11 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            if (PrimaryPhone == 1)
                                Response.Write("<td style='padding:10px'>" + HomePhone + "</td>");
                            else if (PrimaryPhone == 2)
                                Response.Write("<td style='padding:10px'>" + MobilePhone + "</td>");
                            else if (PrimaryPhone == 3)
                            {
                                Response.Write("<td style='padding:10px'>" + WorkPhone);
                                if (extension != "")
                                    Response.Write(" ext. " + extension + "</td>");
                                else
                                    Response.Write("</td>");
                            }
                            else
                                Response.Write("<td>&nbsp;</td>");
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 12 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            Response.Write("<td style='padding:10px'>" + HomePhone + "</td>");
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 13 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            Response.Write("<td style='padding:10px'>" + WorkPhone);
                            Response.Write("<td style='padding:10px'>" + WorkPhone);
                            if (extension != "")
                                Response.Write(" ext. " + extension + "</td>");
                            else
                                Response.Write("</td>");
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 14 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            Response.Write("<td style='padding:10px'>" + MobilePhone + "</td>");
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 15 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            if (PrimaryEmail == 1)
                                Response.Write("<td style='padding:10px'>" + HomeEmail + "</td>");
                            else if (PrimaryEmail == 2)
                                Response.Write("<td style='padding:10px'>" + WorkEmail + "</td>");
                            else
                                Response.Write("<td>&nbsp;</td>");
                        }
                        if (Convert.ToInt32(drField["FieldID"]) == 16 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            SqlConnection connCounter = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
                            connCounter.Open();
                            string sqlCounter = "Select Committee from BOARD_COMMITTEE INNER JOIN COMMITTEE_MEMBER ON BOARD_COMMITTEE.CommitteeID=";
                            sqlCounter = sqlCounter + "COMMITTEE_MEMBER.CommitteeID Where MemberID=@MemberID";
                            SqlCommand cmdCounter = new SqlCommand(sqlCounter, connCounter);
                            cmdCounter.Parameters.Add("@MemberID", MemberID);
                            SqlDataReader drCounter = cmdCounter.ExecuteReader();
                            int count = 0;
                            while (drCounter.Read())
                            {
                                count++;
                            }
                            drCounter.Close(); connCounter.Close(); connCounter.Dispose();

                            SqlConnection connCommittee = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
                            SqlConnection connCommMember = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
                            connCommittee.Open(); connCommMember.Open();
                            string sqlCommittee = "Select Committee from BOARD_COMMITTEE INNER JOIN COMMITTEE_MEMBER ON BOARD_COMMITTEE.CommitteeID=";
                            sqlCommittee = sqlCommittee + "COMMITTEE_MEMBER.CommitteeID Where MemberID=@MemberID";
                            string sqlCommMember = "Select CommitteePosition from COMMITTEE_POSITION INNER JOIN COMMITTEE_MEMBER ON COMMITTEE_POSITION.";
                            sqlCommMember = sqlCommMember + "CommitteePositionID=COMMITTEE_MEMBER.CommitteePositionID Where MemberID=@MemberID";
                            SqlCommand cmdCommittee = new SqlCommand(sqlCommittee, connCommittee);
                            SqlCommand cmdCommMember = new SqlCommand(sqlCommMember, connCommMember);
                            cmdCommittee.Parameters.Add("@MemberID", MemberID);
                            cmdCommMember.Parameters.Add("@MemberID", MemberID);
                            SqlDataReader drCommittee = cmdCommittee.ExecuteReader();
                            SqlDataReader drCommMember = cmdCommMember.ExecuteReader();
                            Response.Write("<td style='padding:5px; font-size:8pt'>");
                            while (drCommittee.Read() && drCommMember.Read())
                            {
                                count = count - 1;
                                if (count == 0)
                                {
                                    Response.Write(drCommittee["Committee"].ToString());
                                    string commPosition = drCommMember["CommitteePosition"].ToString();
                                    if (commPosition != "")
                                        Response.Write(" (" + commPosition + ") ");
                                }
                                else
                                {
                                    Response.Write(drCommittee["Committee"].ToString());
                                    string commPosition = drCommMember["CommitteePosition"].ToString();
                                    if (commPosition != "")
                                        Response.Write(" (" + commPosition + ") ");
                                    Response.Write("<br/>");
                                }
                            }
                            Response.Write("</td>");
                            drCommittee.Close();
                            connCommittee.Close(); connCommittee.Dispose();
                        }
                        /*if (Convert.ToInt32(drField["FieldID"]) == 16 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            SqlConnection connCounter = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
                            connCounter.Open();
                            string sqlCounter = "Select Committee from BOARD_COMMITTEE INNER JOIN COMMITTEE_MEMBER ON BOARD_COMMITTEE.CommitteeID=";
                            sqlCounter = sqlCounter + "COMMITTEE_MEMBER.CommitteeID Where MemberID=@MemberID";
                            SqlCommand cmdCounter = new SqlCommand(sqlCounter, connCounter);
                            cmdCounter.Parameters.Add("@MemberID", MemberID);
                            SqlDataReader drCounter = cmdCounter.ExecuteReader();
                            int count = 0;
                            while (drCounter.Read())
                            {
                                count++;
                            }
                            drCounter.Close(); connCounter.Close(); connCounter.Dispose();

                            SqlConnection connCommittee = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
                            connCommittee.Open();
                            string sqlCommittee = "Select Committee from BOARD_COMMITTEE INNER JOIN COMMITTEE_MEMBER ON BOARD_COMMITTEE.CommitteeID=";
                            sqlCommittee = sqlCommittee + "COMMITTEE_MEMBER.CommitteeID Where MemberID=@MemberID";
                            SqlCommand cmdCommittee = new SqlCommand(sqlCommittee, connCommittee);
                            cmdCommittee.Parameters.Add("@MemberID", MemberID);
                            SqlDataReader drCommittee = cmdCommittee.ExecuteReader();
                            Response.Write("<td style='padding:10px'>");
                            while (drCommittee.Read())
                            {
                                count = count - 1;
                                if (count == 0)
                                    Response.Write(drCommittee["Committee"].ToString());
                                else
                                    Response.Write(drCommittee["Committee"].ToString() + "</br>");
                            } 
                            Response.Write("</td>");
                            drCommittee.Close();
                            connCommittee.Close(); connCommittee.Dispose();
                        }*/
                        if (Convert.ToInt32(drField["FieldID"]) == 17 && Convert.ToInt32(drField["Website"]) == 1)
                        {
                            if (PrimaryFax == 1)
                                Response.Write("<td style='padding:10px'>" + HomeFax + "</td>");
                            else if (PrimaryFax == 2)
                                Response.Write("<td style='padding:10px'>" + WorkFax + "</td>");
                            else
                                Response.Write("<td>&nbsp;</td>");
                        }
                    }
                }
                drField.Close();
                Response.Write("</tr>");
                connField.Close(); connField.Dispose();
            }
            Response.Write("</table>");
        }
        drMember.Close();
        connMember.Close(); connMember.Dispose();
    }

    protected string StateLookUp(int StateID)
    {
        string StateAbbr = "";
        SqlConnection connState = new SqlConnection(ConfigurationManager.ConnectionStrings["CAI"].ConnectionString);
        connState.Open();
        string sqlState = "Select StateAbbr from STATE where StateID=@StateID";
        SqlCommand cmdState = new SqlCommand(sqlState, connState);
        cmdState.Parameters.Add("@StateID", StateID);
        SqlDataReader drState = cmdState.ExecuteReader();
        while (drState.Read())
        {
            StateAbbr = drState["StateAbbr"].ToString();
        }
        drState.Close();
        connState.Close(); connState.Dispose();
        return StateAbbr;
    }
}