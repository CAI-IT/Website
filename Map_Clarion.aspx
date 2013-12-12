<%@ Page Title="" Language="C#" MasterPageFile="~/design/MasterPage.master" AutoEventWireup="true" CodeFile="Map_Clarion.aspx.cs" Inherits="Map_Clarion" %>

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
                <iframe width="700" height="500" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=30A+South+Sheridan+Road+Clarion+PA&amp;aq=&amp;sll=40.943975,-78.990862&amp;sspn=0.009919,0.019355&amp;vpsrc=6&amp;gl=us&amp;ie=UTF8&amp;hq=&amp;hnear=30+S+Sheridan+Rd,+Clarion,+Pennsylvania+16214&amp;ll=41.219792,-79.370899&amp;spn=0.03228,0.059996&amp;z=14&amp;iwloc=A&amp;output=embed"></iframe><br /><small><a href="http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=30A+South+Sheridan+Road+Clarion+PA&amp;aq=&amp;sll=40.943975,-78.990862&amp;sspn=0.009919,0.019355&amp;vpsrc=6&amp;gl=us&amp;ie=UTF8&amp;hq=&amp;hnear=30+S+Sheridan+Rd,+Clarion,+Pennsylvania+16214&amp;ll=41.219792,-79.370899&amp;spn=0.03228,0.059996&amp;z=14&amp;iwloc=A" style="color:#0000FF;text-align:left">View Larger Map</a></small>
            </div>
        </ContentTemplate>
    </artisteer:Article>
</asp:Content>

