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
        private const short port = 587;
        private const string username = "app.dokonnect@gmail.com";
        private const string password = "app.dokonnect123";
        private const string host = "smtp.gmail.com";
        private const string from = "app.dokonnect@gmail.com";

        public static Task<bool> SendAsync(string to, string subject, string body)
        {
            return Task.Run(() =>
            {
                try
                {
                    MailMessage mail = new MailMessage(from, to)
                    {
                        Body = body,
                        IsBodyHtml = true,
                        Subject = subject,

                    };
                    SmtpClient client = new SmtpClient(host, port);
                    client.UseDefaultCredentials = false;
                    client.Credentials = new NetworkCredential(username, password);
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
        public static bool Send(string to, string subject, string body)
        {

            try
            {
                MailMessage mail = new MailMessage(from, to)
                {
                    Body = body,
                    IsBodyHtml = true,
                    Subject = subject,

                };
                SmtpClient client = new SmtpClient(host, port);
                client.UseDefaultCredentials = false;
                client.Credentials = new NetworkCredential(username, password);
                client.EnableSsl = true;
                client.Send(mail);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }

        }
    }
}