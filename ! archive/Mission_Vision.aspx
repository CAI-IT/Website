<%@ Page Title="" Language="C#" MasterPageFile="~/design/MasterPage.master" AutoEventWireup="true" CodeFile="Mission_Vision.aspx.cs" Inherits="Mission_Vision" %>
<%@ Import Namespace="Artisteer" %>
<%@ Register TagPrefix="artisteer" Namespace="Artisteer" %>
<%@ Register TagPrefix="art" TagName="DefaultMenu" Src="DefaultMenu.ascx" %> 
<%@ Register TagPrefix="art" TagName="DefaultHeader" Src="DefaultHeader.ascx" %> 
<%@ Register TagPrefix="art" TagName="DefaultSidebar1" Src="DefaultSidebar1.ascx" %>
          

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
    <artisteer:Article ID="artMissionVision" Caption="Community Action, Inc. Mission Statement" runat="server">
        <ContentTemplate>
            <br />
            <span style="font-size:12pt">
                To provide and coordinate activities which alleviate poverty, promote family self-sufficiency and advance community
            </span>
            <br /><br /><br />

            <span style="font-family:Arial; font-size:13.5pt;color: #620f2a"><b>Community Action, Inc. Vision Statement</b></span><br /><br />
            <span style="font-size:12pt">
                Community Action, Inc. will be recognized as a premier organization dedicated to solving social and economic problems of the community.
            </span>
            <br /><br /><br />
            <table style="width:100%; border:none; margin-left:-4px">
                <tr>
                    <td align="left" style="border:none"><img src="images/national_logo.png" alt="National Logo" /></td>
                    <td align="right" style="vertical-align:bottom; text-align:right; border:none">Revised January 20, 2011</td>
                </tr>
            </table>
        </ContentTemplate>
    </artisteer:Article>
</asp:Content>

