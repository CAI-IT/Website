<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DefaultHeader.ascx.cs"
    Inherits="DefaultHeader" %>
<div class="art-headerobject">
</div>
<div class="art-logo">
    <table style="width: 796px;">
        <tr>
            <td>
                <h1 class="art-logo-name">
                    <a href="default.aspx">
                        <%loadHeading(); %></a></h1>
                <h2 class="art-logo-text">
                    <%loadSubHeading(); %></h2>
            </td>
            <td style="text-align:right">
                <asp:ImageButton ID="imgDonate" runat="server" CausesValidation="false" ImageUrl="http://www.paypal.com/en_US/i/btn/btn_donate_LG.gif"
                    OnClick="imgDonate_Click" />
            </td>
        </tr>
    </table>
</div>
