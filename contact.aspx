<%@ Page Title="" Language="C#" MasterPageFile="~/design/MasterPage.master" AutoEventWireup="true" CodeFile="contact.aspx.cs" Inherits="contact" %>
<%@ Import Namespace="Artisteer" %>
<%@ Register TagPrefix="artisteer" Namespace="Artisteer" %>
<%@ Register TagPrefix="art" TagName="DefaultMenu" Src="DefaultMenu.ascx" %> 
<%@ Register TagPrefix="art" TagName="DefaultHeader" Src="DefaultHeader.ascx" %> 
<%@ Register TagPrefix="art" TagName="DefaultSidebar1" Src="DefaultSidebar1.ascx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register TagPrefix="CE" Namespace="CuteEditor" Assembly="CuteEditor" %>
<%@ Register TagPrefix="recaptcha" Namespace="Recaptcha" Assembly="Recaptcha" %>

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
    <artisteer:Article ID="artContact" Caption="Contact" runat="server">
        <ContentTemplate>
            <!--<ajax:ToolkitScriptManager ID="tsm" runat="server" />
            <asp:UpdatePanel ID="PageUpdatePanel" runat="server">
                <ContentTemplate> This page does not work unless this update panel is here commented out. DO NOT REMOVE-->
                    <table style="width:100%">
                        <tr>
                            <td style="border:none; vertical-align:middle"><asp:Label ID="lblSubject" runat="server" Text="Subject:"/></td>
                            <td style="border:none; vertical-align:middle">
                                <asp:TextBox ID="txtSubject" runat="server" Width="350px" />
                                <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtSubject" ErrorMessage="<b>Required</b>" ForeColor="Red" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border:none; vertical-align:middle"><asp:Label ID="lblMessage" runat="server" Text="Message:" /></td>
                            <td style="border:none; vertical-align:middle">
                                <CE:Editor ID="txtMessage" runat="server" Height="300px" Width="500px" ThemeType="Office2003"
                                    AutoConfigure="Simple" ShowBottomBar="false" />
                                <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage" ErrorMessage="<b>Required</b>" ForeColor="Red" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border:none; vertical-align:middle"><asp:Label ID="lblName" runat="server" Text="Name:" /></td>
                            <td style="border:none; vertical-align:middle">
                                <asp:TextBox ID="txtName" runat="server" Width="250px" />
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="<b>Required</b>" ForeColor="Red" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border:none; vertical-align:middle"><asp:Label ID="lblStreet" runat="server" Text="Street:" /></td>
                            <td style="border:none; vertical-align:middle"><asp:TextBox ID="txtStreet" runat="server" Width="300px" /></td>
                        </tr>
                        <tr>
                            <td style="border:none; vertical-align:middle"><asp:Label ID="lblCity" runat="server" Text="City:" /></td>
                            <td style="border:none; vertical-align:middle"><asp:TextBox ID="txtCity" runat="server" Width="250px" /></td>
                        </tr>
                        <tr>
                            <td style="border:none; vertical-align:middle"><asp:Label ID="lblState" runat="server" Text="State:" /></td>
                            <td style="border:none; vertical-align:middle"><asp:TextBox ID="txtState" runat="server" MaxLength="2" Width="40px" /></td>
                        </tr>
                        <tr>
                            <td style="border:none; vertical-align:middle"><asp:Label ID="lblEmail" runat="server" Text="Email Address:" /></td>
                            <td style="border:none; vertical-align:middle">
                                <asp:TextBox ID="txtEmail" runat="server" Width="175px" />
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="<b>Required</b>" ForeColor="Red" />
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" Text="<>Invalid</b>" ControlToValidate="txtEmail" 
                                    ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*([,;]\s*\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border:none; vertical-align:middle"></tdstyle><asp:Label ID="lblPhone" runat="server" Text="Phone Number:" /></td>
                            <td style="border:none; vertical-align:middle">
                                <asp:TextBox ID="txtPhone" runat="server" />
                                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="<b>Required</b>" ForeColor="Red" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border:none; vertical-align:middle">&nbsp;</td>
                            <td style="border:none; vertical-align:middle">
                                <recaptcha:RecaptchaControl ID="recaptcha" runat="server" ErrorMessage="Invalid" Theme="white"
                                    PublicKey="6LcceLwSAAAAAFLKyhNSTDsmvyuHUbTppI8TTGO8 "
                                    PrivateKey="6LcceLwSAAAAAIVm32P07UZm8ppUXGfFLUQrlRjD" />
                            </td>
                        </tr>
                        <tr>
                            <td style="border:none; vertical-align:middle"/>
                            <td style="border:none; vertical-align:middle">
                            <asp:Label ID="lblEmailError" runat="server" Font-Bold="true" ForeColor="Red" Visible="false"
                                Text="Invalid ReCaptcha entry" />
                            </td>
                        </tr>
                        <tr><td colspan="2" style="border:none; vertical-align:middle">&nbsp;</td></tr>
                        <tr>
                            <td style="border:none; vertical-align:middle">&nbsp;</td><td style="border:none; vertical-align:middle"><asp:Button ID="btnSubmit" runat="server" Text="Send Message" OnClick="btnSubmit_Click" />&nbsp;<asp:Button ID="btnReset" runat="server" Text="Reset" CausesValidation="false" OnClick="btnReset_Click" /></td>
                        </tr>
                    </table>
                <!--</ContentTemplate>
            </asp:UpdatePanel>-->
        </ContentTemplate>
    </artisteer:Article>
</asp:Content>

