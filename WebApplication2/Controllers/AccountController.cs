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
        public HttpResponseMessage UpdateProfilePic([FromUri] long chatterId, [FromBody]string b64)
        {
            return Request.CreateResponse(new Models.Chatter().ChangeProfilePic(chatterId, b64));
        }
        public HttpResponseMessage ChangeName([FromUri] long chatterId, [FromUri]string fName,[FromUri] string lName)
        {
            return Request.CreateResponse(new Models.Chatter().ChangeName(chatterId, fName,lName));
        }
        public HttpResponseMessage ChangePassword([FromUri] long chatterId, [FromUri]string oldPwd, [FromUri] string newPwd)
        {
            return Request.CreateResponse(new Models.Chatter().ChangePassword(chatterId,newPwd,oldPwd));
        }

    }
}