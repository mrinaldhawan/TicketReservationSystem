using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using TicketReservationSystem;

/// <summary>
/// Summary description for TicketBooking
/// </summary>
public class TicketBooking
{
    private String sqlQuery;
    SqlConnection con;
    public TicketBooking()
    {
       
    }
    public String LoadBookedTickets()
    {
        con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        string allBookedTickets = String.Empty;
        sqlQuery = @"SELECT SeatNumber FROM  BookedTickets";
        SqlDataAdapter adapter = new SqlDataAdapter(sqlQuery, con);
        DataTable dt = new DataTable();
        adapter.Fill(dt);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            allBookedTickets = allBookedTickets + ((i + 1 != dt.Rows.Count) ? dt.Rows[i][0].ToString().Trim() + "," : dt.Rows[i][0].ToString().Trim());
        }
        con.Close();
        return allBookedTickets;
    }

    public void BookUserTicket(UserModel objUser)
    {
        con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        if (objUser.IsNewBooking)
        {
            sqlQuery = @"INSERT INTO BookedTickets(SeatNumber,UserName,BookingDate) VALUES('" + objUser.CurrentBookings
            + "','" + objUser.UserName + "',GETDATE())";
        }
        else
        {
            sqlQuery = @"UPDATE BookedTickets SET SeatNumber = '" + objUser.CurrentBookings + "' WHERE UserName='" + objUser.UserName + "'";
        }

        con.Open();
        SqlCommand comm = con.CreateCommand();
        comm.CommandText = sqlQuery;
        comm.ExecuteNonQuery();
        con.Close();
    }
}

