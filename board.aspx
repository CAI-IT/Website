<%@ Page Title="" Language="C#" MasterPageFile="~/design/MasterPage.master" AutoEventWireup="true" CodeFile="board.aspx.cs" Inherits="board" %>

<%@ Import Namespace="Artisteer" %>
<%@ Register TagPrefix="artisteer" Namespace="Artisteer" %>
<%@ Register TagPrefix="art" TagName="DefaultMenu" Src="DefaultMenu.ascx" %> 
<%@ Register TagPrefix="art" TagName="DefaultHeader" Src="DefaultHeader.ascx" %> 
<%@ Register TagPrefix="art" TagName="DefaultSidebar1" Src="DefaultSidebar1.ascx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
          

<asp:Content ID="PageTitle" ContentPlaceHolderID="TitleContentPlaceHolder" Runat="Server">
    Community Action, Inc.
</asp:Content>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeaderContentPlaceHolder" Runat="Server">
    <art:DefaultHeader ID="DefaultHeader" runat="server" />
</asp:Content>
<asp:Content ID="MenuContent" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">
    <art:DefaultMenu ID="DefaultMenuContent" runat="server" />
</asp:Content>
<asp:Content ID="SideBar1" ContentPlaceHolderID="Sidebar1ContentPlaceHolder" Runat="Server">
    <art:DefaultSidebar1 ID="DefaultSidebar1Content" runat="server" />
</asp:Content>

<asp:Content ID="SheetContent" ContentPlaceHolderID="SheetContentPlaceHolder" Runat="Server">
    <artisteer:Article ID="artMeetings" Caption="Upcoming Board Meetings" runat="server">
        <ContentTemplate>

             <br /><b><span style="font-size:10pt">Meetings are normally held every other month starting at 12:00 p.m. The public is welcome to attend.<br /></b></span>
            <%BuildMeetings(); %>
        </ContentTemplate>
    </artisteer:Article>
    <artisteer:Article ID="artBoardMembers" Caption="Board of Directors" runat="server">
        <ContentTemplate>
            <!--<ajax:ToolkitScriptManager ID="tsm" runat="server" />
            <asp:UpdatePanel ID="MembersUpdatePanel" runat="server">
                <ContentTemplate>-->
                    <div align="left">
                        <%BuildMembers(); %>
                    </div>
                <!--</ContentTemplate>
            </asp:UpdatePanel>-->
        </ContentTemplate>
    </artisteer:Article>

</asp:Content>
