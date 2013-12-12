<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DefaultSidebar1.ascx.cs"
    Inherits="Sidebar1" %>
<%@ Import Namespace="Artisteer" %>
<%@ Register TagPrefix="artisteer" Namespace="Artisteer" %>
<asp:Panel ID="ProjectPanel" runat="server" Style="text-align: center" />
<artisteer:Block ID="Important_Notices" Caption="Notices" runat="server">
    <contenttemplate>
        <div>
            <ul>
                <%BuildImportantNotices(); %>
            </ul>
            <div align="right"><a href="Important_Notices.aspx">View All</a></div>
        </div>
    </contenttemplate>
</artisteer:Block>
<artisteer:Block ID="Newsletters" Caption="Newsletters" runat="server">
    <contenttemplate>
        <div>
            <ul>
                <%BuildNewsletters(); %>
            </ul>
            <div align="right"><a href="Newsletters.aspx">View All</a></div>
        </div>
    </contenttemplate>
</artisteer:Block>
<artisteer:Block ID="Employment" Caption="Employment Opportunities" runat="server">
    <contenttemplate>
        <div>
            <ul>
                <%BuildJobAnnouncements(); %>
            </ul>
        </div>
    </contenttemplate>
</artisteer:Block>

<asp:Panel ID="SidebarPanel" runat="server"></asp:Panel>