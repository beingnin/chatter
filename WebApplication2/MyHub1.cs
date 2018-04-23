using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

namespace WebApplication2
{
    [HubName("chat")]
    public class MyHub1 : Hub
    {
        
        public void Send(string Message,string Chatter)
        {
            Clients.Others.addMessage(Message,Chatter);
            Clients.Caller.selfMessage(Message,Chatter);
        }

        public void newChatter(string Name)
        {
            Chatters.AddMember(Name);
            Clients.All.newChatterOnline(Chatters.Names);
        }
        public void removeChatter(string Name)
        {
            Chatters.RemoveMember(Name);
            Clients.All.removeChatterOnline(Chatters.Names);
        }
    }
}