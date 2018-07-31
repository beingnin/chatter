using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2.App.Account
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cookies[ "ch_us_id"].Expires=DateTime.Now.AddYears(-99);
            Response.Cookies["ch_us_dt"].Expires = DateTime.Now.AddYears(-99);
            Response.Cookies[".ASPXAUTH"].Expires = DateTime.Now.AddYears(-99);
            Response.Redirect("/App/Account/SignIn");
        }
    }
}