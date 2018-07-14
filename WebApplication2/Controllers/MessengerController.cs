using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebApplication2.Controllers
{
    public class MessengerController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage GetChats([FromUri]long me, [FromUri]long you)
        {
            return Request.CreateResponse(HttpStatusCode.OK, new Models.Chat().GetChats(me, you));
        }
        [HttpGet]
        public HttpResponseMessage ChatList([FromUri] long me)
        {
            return Request.CreateResponse(HttpStatusCode.OK, new Models.Chat().MyChatList(me));
        }
        [HttpPost]
        public HttpResponseMessage Send([FromBody] Models.Chat chat)
        {
            if (chat != null)
            {
                chat.Save_Completed += (sender, e) =>
                {
                    IHubContext hubcontext= GlobalHost.ConnectionManager.GetHubContext<WebApplication2.Hubs.ChatHub>();
                    hubcontext.Clients.All.newMessage(sender.FromId, sender.Message,sender.From.ProfileImagePath);
                };
                return Request.CreateResponse(HttpStatusCode.OK, chat.Send());
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Bad Request");
            }
        }
    }
}