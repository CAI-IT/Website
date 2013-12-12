<%@ Page Title="" Language="C#" MasterPageFile="~/design/MasterPage.master" AutoEventWireup="true" CodeFile="Map_ElkCountyCareerLink.aspx.cs" Inherits="Map_ElkCountyCareerLink" %>

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
    <artisteer:Article ID="artMap" Caption="" runat="server">
        <ContentTemplate>
            <div align="center">
                <iframe width="700" height="500" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?hl=en&amp;q=elk+county+careerlink&amp;ie=UTF8&amp;hq=elk+county+careerlink&amp;hnear=&amp;radius=15000&amp;t=m&amp;cid=809694625695191834&amp;ll=41.436678,-78.552332&amp;spn=0.032173,0.059996&amp;z=14&amp;iwloc=A&amp;output=embed"></iframe><br /><small><a href="https://maps.google.com/maps?hl=en&amp;q=elk+county+careerlink&amp;ie=UTF8&amp;hq=elk+county+careerlink&amp;hnear=&amp;radius=15000&amp;t=m&amp;cid=809694625695191834&amp;ll=41.436678,-78.552332&amp;spn=0.032173,0.059996&amp;z=14&amp;iwloc=A&amp;source=embed" style="color:#0000FF;text-align:left">View Larger Map</a></small>
            </div>
        </ContentTemplate>
    </artisteer:Article>
</asp:Content>

