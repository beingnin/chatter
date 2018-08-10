using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
namespace WebApplication2.Hubs
{
    [HubName("chathub")]
    public class ChatHub : Hub
    {
        public void send(int you, string message, string youProfileImage,string date)
        {
            Clients.All.newMessage(you, message, youProfileImage,date);

        }
        public void sendToGroup(int groupid, string message, string youProfileImage, string date,string sender)
        {
            Clients.All.newGroupMessage(groupid, message, youProfileImage, date, sender);

        }
        public override Task OnConnected()
        {
            Cookie user;
            if (Context.RequestCookies.TryGetValue("ch_us_id", out user))
            {
                long userid = Convert.ToInt64(user.Value);
                List<string> connectionIds;
                if (Connections.Active.TryGetValue(userid, out connectionIds))
                {
                    connectionIds.Add(Context.ConnectionId);
                }
                else
                {
                    connectionIds = new List<string>();
                    connectionIds.Add(Context.ConnectionId);
                    Connections.Active.Add(userid, connectionIds);
                }
                List<string> result = Connections.GetConnections(userid);
                return base.OnConnected();
            }

            return base.OnConnected();
        }
        public override Task OnDisconnected(bool stopCalled)
        {
            Cookie user;
            if (Context.RequestCookies.TryGetValue("ch_us_id", out user))
            {
                long userid = Convert.ToInt64(user.Value);
                List<string> connectionIds;
                if (Connections.Active.TryGetValue(userid, out connectionIds))
                {
                    connectionIds.Remove(Context.ConnectionId);
                    List<string> result = Connections.GetConnections(userid);
                }
            }
            return base.OnDisconnected(stopCalled);
        }
    }
}