<%@ Page Title="" Language="C#" MasterPageFile="~/Forms/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ROIS.Forms.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<script>
    let readSession = localStorage["locDropDownOptions"];

    if (!readSession) {
        console.log("Walang laman");
        locationDropDownReceiving();
    }
    else {
        console.log("may laman");
        let x = JSON.parse(localStorage.getItem("locDropDownOptions"));
        console.log(x[0].locationDesc);
    }

    function locationDropDownReceiving() {
        let employee = sessionStorage.getItem("userId");
        let data = JSON.stringify({ currUserId: employee });
        let request = new XMLHttpRequest();
        request.open('POST', 'ROISWebService.asmx/GetDropDownData');
        request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

        request.onload = function () {
            if (this.status >= 200 && this.status < 400) {
                let location = JSON.parse(this.responseText);

                localStorage.setItem("locDropDownOptions", JSON.stringify(location));
            }
            else {

            }
        };

        request.onerror = function () {

        };

        request.send(data);
    }
</script>

</asp:Content>
