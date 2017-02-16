<%@ Page Title="BookTicket" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="BookTicket.aspx.cs" Inherits="BookTicket" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script type="text/javascript">
        var selectedSeats = [];
        var currentSelectionCount = 0;
        var index;
        $(document).ready(function () {
            if ($("#MainContent_hdnUserSelectedSeats").val() != "")
                selectedSeats = $("#MainContent_hdnUserSelectedSeats").val().split(',')
            $(".available").click(function (e) {
                if (selectedSeats.length < 4) {                    
                    $(this).toggleClass("selected");
                    if ($.inArray($(this).attr('id'), selectedSeats) == -1) {
                        selectedSeats.push($(this).attr('id'));
                        currentSelectionCount++;
                        //alert("push in 1st " + selectedSeats);
                        //("#MainContent_hdnUserBookingCount").val(selectedSeats.length.toString())
                    }
                    else {
                        index = selectedSeats.indexOf($(this).attr('id'));
                        selectedSeats.splice(index, 1);
                        //selectedSeats.pop($(this).attr('id'));
                        currentSelectionCount--;
                        //alert("pop in 2nd " + selectedSeats);
                        //("#MainContent_hdnUserBookingCount").val(selectedSeats.length)
                    }
                }
                else if ($.inArray($(this).attr('id'), selectedSeats) > -1) {
                    $(this).toggleClass("selected");
                    index = selectedSeats.indexOf($(this).attr('id'));
                    selectedSeats.splice(index, 1);
                    //selectedSeats.pop($(this).attr('id'));
                    //alert("pop in 3rd " + selectedSeats);
                    currentSelectionCount--;
                    //("#MainContent_hdnUserBookingCount").val(selectedSeats.length)
                }
            });

            $("#MainContent_btnConfirm").click(function () {
                if (currentSelectionCount == 0) {
                    $("#modalSelectSeats").modal('toggle');
                    return false;
                }
                else if (currentSelectionCount > 0) {
                    $("#MainContent_hdnUserSelectedSeats").val(selectedSeats);
                };
            });
        });
    </script>
    <div style="text-align: center">
        <label for="name" class="bookTickets">
            <h2>Book Seats</h2>
        </label>
        <br />
        <label for="message">
            <h4>You can book upto a maximum of 4 tickets</h4>
        </label>
        <br />
        <div class="alert alert-success col-md-6 col-md-offset-3">
            <%if (objUser.CurrentBookings.Equals(String.Empty))
                { %>
            <label for="currentBookings">
                You have no current bookings. 
            </label>
            <% }
                else
                {%>
            <label for="currentBookings">
                Your current bookings are : 
            <%=objUser.CurrentBookings %>.</label>
            <br />
            <label for="bookingCount">
                You can book
            <%=objUser.AllowedBookings%> more seats.</label>
            <%} %>
        </div>
        <div>
            <table style="width: 70%; background: #f1f1f1; padding: 5px 5px 5px 5px;" align="center" id="tblSeats">
                <%  
                    String status = String.Empty;
                    for (int i = 1; i <= totalRows; i++)
                    {
                %>
                <tr>
                    <%
                        for (int j = 1; j <= seatsPerRow; j++)
                        {
                            seatNumber = row + Convert.ToString(j);
                            status = CheckStatus(seatNumber);
                            if (status.Equals("Available"))
                            {
                    %>
                    <td class="seatPadding">
                        <div class="seat available" id="<%=seatNumber%>" style="cursor: pointer"><%=seatNumber%></div>
                    </td>
                    <% }
                        else if (status.Equals("Booked"))
                        {
                    %><td class="seatPadding">
                        <div class="seat booked" id="<%=seatNumber%>" style="cursor: not-allowed"><%=seatNumber%></div>
                    </td>
                    <%
                        }
                        else if (status.Equals("UserBooked"))
                        {
                    %><td class="seatPadding">
                        <div class="seat userbooked" id="<%=seatNumber%>" style="cursor: not-allowed"><%=seatNumber%></div>
                    </td>
                    <%
                            }
                        }
                        row++; %>
                </tr>
                <% } %>
            </table>
            <br />
            <table style="width: 50%; background: #f1f1f1; text-align: left" align="center">
                <tr>
                    <td>
                        <div class="seatlegend availablelegend"></div>
                    </td>
                    <td>Available</td>
                    <td>
                        <div class="seatlegend selectedlegend"></div>
                    </td>
                    <td>Selected</td>
                    <td>
                        <div class="seatlegend bookedlegend"></div>
                    </td>
                    <td>Booked</td>
                    <td>
                        <div class="seatlegend userbookedlegend"></div>
                    </td>
                    <td>Booked By You</td>
                </tr>
            </table>
        </div>
        <br />
        <div style="text-align: right;">
            <asp:Button ID="btnConfirm" runat="server" CssClass="btn btn-primary" Text="Book Ticket(s)!"
                OnClick="ConfirmBooking" />
        </div>
        <asp:HiddenField ID="hdnUserSelectedSeats" runat="server" />
        <asp:HiddenField ID="hdnUserBookingCount" runat="server" />
    </div>
    <div class="modal fade" id="modalSelectSeats">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header alert-danger">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">x</button>
                    <h5 class="modal-title"><strong>No Seat Selected</strong></h5>
                </div>
                <div class="modal-body">
                    <strong>No seats selected. Please select a seat to continue!!</strong>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

