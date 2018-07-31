using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;
using System.Web;

namespace WebApplication2.Helper
{
    public static class Emailer
    {
        private const short port= 587;
        private const string username = "nithinbchabdran@gmail.com";
        private const string password = "cisnin992";
        private const string host = "smtp.gmail.com";
        private const string from= "nithinbchabdran@gmail.com";
        private static SmtpClient client = new SmtpClient();
        public static Task<bool> SendAsync(string to,string subject,string body)
        {
            return Task.Run(()=> {
                try
                {
                    MailMessage mail = new MailMessage(from, to)
                    {
                        Body = body,
                        IsBodyHtml = true,
                        Subject = subject,

                    };
                    client.Credentials = new NetworkCredential(username, password);
                    client.Host = host;
                    client.EnableSsl = true;
                    client.Send(mail);
                    return true;
                }
                catch (Exception ex)
                {
                    return false;
                }
            });
        }
    }
}