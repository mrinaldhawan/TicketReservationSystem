<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewBookingDetails.aspx.cs" Title="BookingDetails"
    Inherits="ViewBookingDetails" MasterPageFile="~/Site.master" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">
    <div align="center">
        <h3>User Booking Details</h3>
        <div style="width: 25%; display:inline-block">            
            <br />
            <table style="width: 100%" align="center" class="table">
                <tr class="active">
                    <td>
                        <b>User Name</b>
                    </td>
                    <td>
                        <%=objUser.UserName %>
                    </td>
                </tr>
                <tr class="warning">
                    <td>
                        <b>Name</b>
                    </td>
                    <td>
                        <%=objUser.LastName+","+objUser.FirstName %>
                    </td>
                </tr>
                <tr class="success">
                    <td>
                        <b>Seat Number</b>
                    </td>
                    <td>
                        <%=objUser.CurrentBookings %>
                    </td>
                </tr>
                <tr class="danger">
                    <td>
                        <b>Booking Date</b>
                    </td>
                    <td>
                        <%=objUser.BookingDate %>
                    </td>
                </tr>
            </table>
            <br />
        </div>
        <div style="width: 70%; display:inline-block">
            <br />
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
                        <div class="seat otherSeats" id="<%=seatNumber%>"><%=seatNumber%></div>
                    </td>
                    <% }
                        else if (status.Equals("Booked"))
                        {
                    %><td class="seatPadding">
                        <div class="seat booked" id="<%=seatNumber%>"><%=seatNumber%></div>
                    </td>
                    <%
                        }
                        else if (status.Equals("UserBooked"))
                        {
                    %><td class="seatPadding">
                        <div class="seat userbooked" id="<%=seatNumber%>"><%=seatNumber%></div>
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
                        <div class="seatlegend otherSeatslegend"></div>
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
    </div>    
</asp:Content>


