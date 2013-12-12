<%@ Page Language="C#" MasterPageFile="~/design/MasterPage.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Community Action, Inc." %>

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
<artisteer:Article ID="SpecialAnnouncements" Caption="Special Announcements" runat="server">
    <ContentTemplate>
        <br />
        <%loadSpecialAnnouncements(); %>
    </ContentTemplate>
</artisteer:Article>

<artisteer:Article ID="Headlines" Caption="Headlines" runat="server">
    <contenttemplate>
        <div>
            <%BuildHeadlines();%>
        </div>
        <div align="right"><a href="NewNewsRelease.aspx">View All</a></div>
    </contenttemplate>
</artisteer:Article>

<artisteer:Article ID="Article1" Caption="" runat="server" class="art-postcontent_slider">
    <ContentTemplate>
        <div id="features">
            <%LoadSliderContent(); %>
		</div>
        <div align="right"><a href="NewNewsRelease.aspx" style="color:#8E153D">View All</a></div>
		<script type="text/javascript">
		    $(document).ready(function () { $('#features').jshowoff({ speed: 5000, links: true, effect: 'fade', hoverPause: false }); });
		</script>
    </ContentTemplate>
</artisteer:Article>

<artisteer:Article ID="ContentRotator" Caption="" runat="server" class="art-postcontent_slider">
    <ContentTemplate>
        <div id="features2">
            <%LoadContentRotator(); %>
        </div>
        <script type="text/javascript">
            $(document).ready(function () { $('#features2').jshowoff({ speed: 5000, links: true, effect: 'fade', hoverPause: false }); });
        </script>
    </ContentTemplate>
</artisteer:Article>

<artisteer:Article ID="BottomContent" Caption="" runat="server">
    <ContentTemplate>
        <%LoadBottomContent(); %>
    </ContentTemplate>
</artisteer:Article>
</asp:Content>
