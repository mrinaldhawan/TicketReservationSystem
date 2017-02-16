<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Ticket Reservation System</h1>
        <p class="lead">The TRS provides you a platform to book tickets for your favourite movie online. It's Simple. Register an account and use the service to Book Tickets and View Booking Details.</p>        
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Book Ticket</h2>
            <p>
                <a class="btn btn-default" href="/BookTicket">Book Ticket &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>View Booked Ticket</h2>            
            <p>
                <a class="btn btn-default" href="/ViewBookingDetails">View My Bookings&raquo;</a>
            </p>
        </div>     
        <div class="col-md-4">
            <h2>View Bookings Report</h2>            
            <p>
                <a class="btn btn-default" href="/ViewBookingReport">View All Bookings&raquo;</a>
            </p>
        </div>    
    </div>
</asp:Content>
