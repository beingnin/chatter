using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Models;

namespace WebApplication2.App.Account
{
    public partial class Verify : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(Request.QueryString["uid"]))
            {
                var UID = Request.QueryString["uid"].ToString();
                using (Data db = new Data())
                {
                    var user = db.Chatters.Where(x => x.VerificationCode.ToString() == UID).FirstOrDefault();
                    if (user != null)
                    {
                        if (!user.IsVerified)
                        {
                            user.IsVerified = true;
                            db.Entry(user).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                            Response.Redirect("/App/Account/Signin");
                        }

                    }
                }

            }

        }
    }
}