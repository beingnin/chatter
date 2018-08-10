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
            var result = new Models.Chat().GetChats(me, you);
            new Models.Chat().MarkAsRead(me, you);
            return Request.CreateResponse(HttpStatusCode.OK, result);
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
                    IHubContext hubcontext = GlobalHost.ConnectionManager.GetHubContext<WebApplication2.Hubs.ChatHub>();

                    foreach (var con in Hubs.Connections.GetConnections(chat.ToId))
                    {

                        hubcontext.Clients.Client(con).newMessage(sender.FromId, sender.Message, sender.From.ProfileImagePath, sender.RelativeTime);
                    }

                };
                return Request.CreateResponse(HttpStatusCode.OK, chat.Send());
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Bad Request");
            }
        }

        [HttpGet]
        public HttpResponseMessage GetConnections(long id)
        {
            var cons = Hubs.Connections.GetConnections(id);
            return Request.CreateResponse<List<string>>(HttpStatusCode.OK, cons);
        }
        [HttpPost]
        public HttpResponseMessage SaveorUpdateGroup([FromBody] Models.Group group)
        {
            if (group.GroupId == 0)
            {
                return Request.CreateResponse(HttpStatusCode.OK, group.Create());
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, group.Update());
            }


        }
        [HttpPost]
        public HttpResponseMessage DeleteGroup([FromUri] long groupId)
        {
            return Request.CreateResponse(HttpStatusCode.OK, Models.Group.Delete(groupId));
        }
        [HttpGet]
        public HttpResponseMessage GetGroups([FromUri] long me)
        {
            return Request.CreateResponse(HttpStatusCode.OK, Models.Group.Get(me));
        }

    }
}