using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using System.Web.Http;
using Microsoft.AspNet.FriendlyUrls;

namespace WebApplication2
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);
            routes.MapHttpRoute(
    name: "DefaultApi",
    routeTemplate: "api/{controller}/{action}/{id}",
    defaults: new { id = System.Web.Http.RouteParameter.Optional }
    );

        }
    }
}
