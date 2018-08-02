using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebApplication2.Controllers
{
    public class AccountController : ApiController
    {
        public HttpResponseMessage Register([FromBody] Models.Chatter chatter)
        {
            return Request.CreateResponse(HttpStatusCode.OK, chatter.Register());
        }
        public HttpResponseMessage Get([FromUri] string email)
        {
            return Request.CreateResponse(HttpStatusCode.OK, new Models.Chatter().Get(email));
        }
        public HttpResponseMessage Get([FromUri] long id)
        {
            return Request.CreateResponse(HttpStatusCode.OK, new Models.Chatter().Get(id));
        }
        public HttpResponseMessage UpdateProfilePic([FromUri] long chatterId, [FromBody]string b64)
        {
            return Request.CreateResponse(new Models.Chatter().ChangeProfilePic(chatterId, b64));
        }
        [HttpPost]
        public HttpResponseMessage ChangeName([FromUri] long chatterId, [FromUri]string fName,[FromUri] string lName)
        {
            return Request.CreateResponse(new Models.Chatter().ChangeName(chatterId, fName,lName));
        }

        [HttpPost]
        public HttpResponseMessage ChangePassword([FromUri] long chatterId, [FromUri]string oldPwd, [FromUri] string newPwd)
        {
            return Request.CreateResponse(new Models.Chatter().ChangePassword(chatterId,newPwd,oldPwd));
        }
        [HttpPost]
        public HttpResponseMessage Invite([FromUri] string toemail,  [FromUri] long by)
        {
            return Request.CreateResponse(new Models.Chatter().Invite(toemail,by));
        }
        [HttpPost]
        public HttpResponseMessage PasswordReset([FromUri]  string email)
        {
            return Request.CreateResponse(new Models.Chatter().ResetPassword(email));
        }

    }
}