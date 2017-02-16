<%@ Page Title="Bookings Report" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ViewBookingReport.aspx.cs"
    Inherits="ViewBookingReport" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">
    <div align="center">
        <h3>Ticket Booking Report</h3>
        <h6>This page contains details of all the seats booked and users information</h6>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
            SelectCommand="SELECT CONCAT(U.LastName, ',', U.FirstName) AS Name, U.UserName, BT.SeatNumber, BT.BookingDate 
        FROM BookedTickets BT INNER JOIN AspNetUsers U ON BT.UserName = U.UserName"></asp:SqlDataSource>

        <asp:GridView ID="gvCheckOut" runat="server" AutoGenerateColumns="False"
            DataSourceID="SqlDataSource1" AllowSorting="True" AllowPaging="True" CellPadding="4"
            class="table table-striped table-bordered table-condensed">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True"
                    SortExpression="Name" />
                <asp:BoundField DataField="UserName" HeaderText="User Name" ReadOnly="True"
                    SortExpression="UserName" />
                <asp:BoundField DataField="SeatNumber" HeaderText="Seat Number" ReadOnly="True"
                    SortExpression="SeatNumber" />
                <asp:BoundField DataField="BookingDate" HeaderText="Booking Date" ReadOnly="True"
                    SortExpression="BookingDate" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

