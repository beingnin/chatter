using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
namespace WebApplication2.Hubs
{
    [HubName("chathub")]
    public class ChatHub:Hub
    {
        public void send( int you, string message,string youProfileImage)
        {
            Clients.All.newMessage(you, message, youProfileImage);
        }
    }
}