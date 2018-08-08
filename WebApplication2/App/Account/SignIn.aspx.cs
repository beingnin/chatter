using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2.App.Account
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Models.Chatter user = new Models.Chatter()
            {
                Email = txtEmailSI.Text.Trim(),
                Password = txtPasswordSI.Text.Trim()
            };
            if (user.IsAuthenticated)
            {
                user = new Models.Data().Chatters.Where(x => x.Email == user.Email).First();
                //FormsAuthentication.SetAuthCookie(user.Email, true);

                FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, user.Email, DateTime.UtcNow, DateTime.UtcNow.AddYears(1), true, user.ChatterId.ToString());

                HttpCookie authCookie = new HttpCookie("ch_us_dt", FormsAuthentication.Encrypt(ticket));
                HttpCookie idCookie = new HttpCookie("ch_us_id")
                {
                    Value = user.ChatterId.ToString()
                };
                Response.Cookies.Add(authCookie);
                Response.Cookies.Add(idCookie);
                FormsAuthentication.RedirectFromLoginPage(user.Email, true);
            }
            else
            {
                loginErrror.Visible = true;
            }
        }
    }
}