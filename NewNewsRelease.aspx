﻿<%@ Page Title="" Language="C#" MasterPageFile="~/design/MasterPage.master" AutoEventWireup="true" CodeFile="NewNewsRelease.aspx.cs" Inherits="NewNewsRelease" %>
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
    <artisteer:Article ID="artNewsReleases" Caption="News Releases" runat="server">
        <ContentTemplate>
            <ajax:ToolkitScriptManager ID="tsm" runat="server" />
            <asp:UpdatePanel ID="PageUpdatePanel" runat="server">
                <ContentTemplate>
                    <br />
                    Select Year: <asp:DropDownList id="drYears" runat="server" DataSourceID="srcYears" DataTextField="YearDate" AutoPostBack="true" DataValueVield="YearDate" OnSelectedIndexChanged="drYears_SelectedIndexChanged" /><br /><br />
                    <asp:SqlDataSource ID="srcYears" runat="server" ConnectionString="<%$ ConnectionStrings:NRS %>" SelectCommand="Select Distinct Year(ReleaseDate) as YearDate From NEWS_RELEASE Where WebsiteFlag = 'true' ORDER BY Year(ReleaseDate) DESC" />
                    <asp:Literal id="ltr" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </ContentTemplate>
    </artisteer:Article>
</asp:Content>
