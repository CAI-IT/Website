<%@ Page Title="" Language="C#" MasterPageFile="~/design/MasterPage.master" AutoEventWireup="true" CodeFile="Map_EastMahoning.aspx.cs" Inherits="Map_EastMahoning" %>

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
                <iframe width="700" height="500" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=200+East+Mahoning+Street,+Punxsutawney,+PA&amp;aq=0&amp;gl=us&amp;g=105+Grace+Way,+Punxsutawney,+PA+15767-1209&amp;ie=UTF8&amp;hq=&amp;hnear=200+E+Mahoning+St,+Punxsutawney,+Pennsylvania+15767&amp;vpsrc=6&amp;ll=40.950085,-78.968697&amp;spn=0.032413,0.059996&amp;z=14&amp;iwloc=A&amp;output=embed"></iframe><br /><small><a href="http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=200+East+Mahoning+Street,+Punxsutawney,+PA&amp;aq=0&amp;gl=us&amp;g=105+Grace+Way,+Punxsutawney,+PA+15767-1209&amp;ie=UTF8&amp;hq=&amp;hnear=200+E+Mahoning+St,+Punxsutawney,+Pennsylvania+15767&amp;vpsrc=6&amp;ll=40.950085,-78.968697&amp;spn=0.032413,0.059996&amp;z=14&amp;iwloc=A" style="color:#0000FF;text-align:left">View Larger Map</a></small>
            </div>
        </ContentTemplate>
    </artisteer:Article>
</asp:Content>

