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
    }
}