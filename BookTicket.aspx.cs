﻿using System;
using System.Linq;
using System.Security.Claims;
using System.Web;
using System.Web.UI;
using TicketReservationSystem;

public partial class BookTicket : System.Web.UI.Page
{    
    public int totalRows = 5;
    public int seatsPerRow = 20;
    public String seatNumber = String.Empty;
    public char row = 'A';
    public String allBookedTickets = String.Empty;
    public String status = "Available";
    public UserModel objUser = new UserModel();
    public TicketBooking objTicketBooking = new TicketBooking();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {                     
            var identity = new ClaimsIdentity(User.Identity);
            int length = identity.Claims.ElementAt(0).ToString().Length;
            Session["userID"] = identity.Claims.ElementAt(0).ToString().Substring(length - 36);
            Session["userName"] = User.Identity.Name;
            objUser = new UserModel(User.Identity.Name);        
        }
        else
        {
            string OriginalUrl = HttpContext.Current.Request.RawUrl;
            string LoginPageUrl = "~/Account/Login.aspx";
            HttpContext.Current.Response.Redirect(String.Format("{0}?ReturnUrl={1}",
            LoginPageUrl, OriginalUrl));            
            //Response.Redirect("~/Account/Login.aspx");
        }
        if(!Page.IsPostBack)
        {
            LoadBookingsByCurrentUser();
            LoadBookedtickets();
        }
    }

    public void LoadBookingsByCurrentUser()
    {        
        objUser.UserBookedTickets(objUser.UserName);
        hdnUserBookingCount.Value = Convert.ToString(objUser.CurrentBookings.Count());
        hdnUserSelectedSeats.Value = objUser.CurrentBookings;
        Session["objUser"] = objUser;
    }
    protected void LoadBookedtickets()
    {
        allBookedTickets = objTicketBooking.LoadBookedTickets();
    }
    protected string CheckStatus(string seatNumber)
    {
        try
        {
            if (allBookedTickets != null)
            {
                string[] allBookedSeats = allBookedTickets.Split(',');               
                if (allBookedSeats.Contains(seatNumber))
                {
                    status = "Booked";
                    if(objUser.ArrCurrentBookings.Contains(seatNumber))
                    {
                        status = "UserBooked";
                    }
                }
                else
                    status = "Available";
            }
        }
        catch (NullReferenceException)
        {
            status = "Booked";
        }
        return status;
    }

    public void ConfirmBooking(object sender, EventArgs e)
    {
        try
        {
            objUser = (UserModel)Session["objUser"];
            objUser.CurrentBookings = hdnUserSelectedSeats.Value.ToString().Trim();
            objTicketBooking.BookUserTicket(objUser);
            LoadBookedtickets();
            LoadBookingsByCurrentUser();
            Response.Write("<script>alert('Booking Confirmed!\\nSeats Booked: " + objUser.CurrentBookings + "');</script>");                        
        }
        catch (NullReferenceException)
        {
            throw;
        }
    }
}


