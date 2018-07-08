using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2.App
{
    public partial class Messenger : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.Cookies["ch_us_id"]==null||string.IsNullOrWhiteSpace(Request.Cookies["ch_us_id"].Value))
            {
                Response.Redirect("/App/Account/Signin");
            }
            else
            {

                var chatter = new Models.Chatter().Get(Convert.ToInt64(Request.Cookies["ch_us_id"].Value)).Data;
                if (chatter == null)
                {
                    Response.Redirect("/App/Account/Signin");
                }
            }
        }
    }
}