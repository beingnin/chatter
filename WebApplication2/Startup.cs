using Microsoft.Owin;
using Owin;
using System.Web.Optimization;
using System.Web.Routing;
using WebApplication2.Models;
[assembly: OwinStartupAttribute(typeof(WebApplication2.Startup))]
namespace WebApplication2
{
    public partial class Startup
    {

        public void Configuration(IAppBuilder app)
        {
            new Data().Initialise();

            ConfigureAuth(app);
            app.MapSignalR();
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            RouteConfig.RegisterRoutes(RouteTable.Routes);

        }
    }
}
