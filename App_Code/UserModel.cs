using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TicketReservationSystem
{
    /// <summary>
    /// Summary description for UserModel
    /// </summary>
    public class UserModel
    {
        private String firstName;
        private String lastName;
        private String userName;
        private String currentBookings = String.Empty;
        private DateTime bookingDate;
        private String[] arrCurrentBookings = new String[4];
        private int allowedBookings;
        private Boolean newBooking;
        private const int MAXALLOWEDBOOKINGS = 4;

        private SqlConnection con;
        private String sqlQuery;
               

        public int AllowedBookings
        {
            get
            {
                return allowedBookings;
            }

            set
            {
                allowedBookings = value;
            }
        }

        public string CurrentBookings
        {
            get
            {
                return currentBookings;
            }

            set
            {
                currentBookings = value;
            }
        }

        public string[] ArrCurrentBookings
        {
            get
            {
                return arrCurrentBookings;
            }

            set
            {
                arrCurrentBookings = value;
            }
        }

        public bool IsNewBooking
        {
            get
            {
                return newBooking;
            }

            set
            {
                newBooking = value;
            }
        }

        public DateTime BookingDate
        {
            get
            {
                return bookingDate;
            }

            set
            {
                bookingDate = value;
            }
        }

        public string LastName
        {
            get
            {
                return lastName;
            }

            set
            {
                lastName = value;
            }
        }

        public string UserName
        {
            get
            {
                return userName;
            }

            set
            {
                userName = value;
            }
        }

        public string FirstName
        {
            get
            {
                return firstName;
            }

            set
            {
                firstName = value;
            }
        }

        public UserModel()
        {

        }

        public UserModel(String userName)
        {
            try
            {
                con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                sqlQuery = @"SELECT FirstName, LastName From AspNetUsers WHERE UserName = '" + userName + "'";
                SqlDataAdapter adapter = new SqlDataAdapter(sqlQuery, con);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach(DataRow row in dt.Rows)
                {
                    firstName = Convert.ToString(row["FirstName"]);
                    lastName = Convert.ToString(row["LastName"]);
                }
                this.userName = userName;
            }
            catch (NullReferenceException)
            {
                throw;
            }
        }

        public void UserBookedTickets(String userName)
        {
            sqlQuery = @"SELECT BT.SeatNumber, BT.BookingDate FROM BookedTickets BT WHERE UserName = '" + userName + "'";
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            SqlDataAdapter adapter = new SqlDataAdapter(sqlQuery, con);
            DataTable dt = new DataTable();
            currentBookings = String.Empty;
            adapter.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                newBooking = true;
                AllowedBookings = MAXALLOWEDBOOKINGS;                
            }
            else
            {                 
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    newBooking = false;
                    currentBookings = currentBookings + ((i + 1 != dt.Rows.Count) ? dt.Rows[i][0].ToString().Trim() + "," : dt.Rows[i][0].ToString().Trim());
                    bookingDate = Convert.ToDateTime(dt.Rows[i][1]);
                }
                arrCurrentBookings = currentBookings.Split(',');
                AllowedBookings = MAXALLOWEDBOOKINGS - arrCurrentBookings.Count();
            }           
        }
    }
}