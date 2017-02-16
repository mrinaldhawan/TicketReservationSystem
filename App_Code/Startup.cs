using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TicketReservationSystem.Startup))]
namespace TicketReservationSystem
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);           
        }
    }
}
