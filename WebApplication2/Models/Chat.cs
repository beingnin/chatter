using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebApplication2.Models
{
    public class Chat
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long ChatId { get; set; }

        public string Message { get; set; }
        public long FromId { get; set; }
        public long ToId { get; set; }
        [ForeignKey("FromId")]
        public Chatter From { get; set; }
        [ForeignKey("ToId")]
        public Chatter To { get; set; }

        [Required]
        public DateTime SentTime { get; set; }
        [NotMapped]
        public string RelativeTime
        {
            get
            {

                return this.SentTime.ToString("MMM dd");

            }

        }


        [Required]
        public bool IsSentToGroup { get; set; }

        public bool IsDeleted { get; set; }

        public bool IsRead { get; set; }


        public Message<List<Chat>> GetChats(long me, long you)
        {
            using (Data db = new Data())
            {
                try
                {
                    List<Chat> chats = db.Chats.Include("From").Include("To").Where(x => (x.From.ChatterId == me && x.To.ChatterId == you) || (x.From.ChatterId == you && x.To.ChatterId == me) && !x.IsDeleted).ToList();
                    return new Message<List<Chat>>(true, "Chats retrieved successfully", "Chat > GetChats", chats);
                }
                catch (Exception ex)
                {
                    return new Message<List<Chat>>(false, "Data retrieval failed", "Chat > GetChats", ex);
                }
            }
        }

        public Message<object> MyChatList(long me)
        {
            using (Data db = new Data())
            {
                try
                {
                    object chatList = (from chat in db.Chats
                                       join
                 chatter in db.Chatters on chat.FromId equals chatter.ChatterId
                                       where chat.IsDeleted == false && chat.ToId == me
                                       orderby chat.SentTime descending
                                       select chatter).Union(
                                       from chat in db.Chats
                                       join
                 chatter in db.Chatters on chat.ToId equals chatter.ChatterId
                                       where chat.IsDeleted == false && chat.FromId == me
                                       orderby
chat.SentTime descending
                                       select chatter).Select(x => new
                                       {
                                           x.ChatterId,
                                           x.FirstName,
                                           x.Email,
                                           x.ProfileImagePath,
                                           Unread = db.Chats.Count(y => !y.IsRead && y.FromId == x.ChatterId && y.ToId == me)
                                       }).ToList();
                    return new Message<object>(true, "Data retrieved successfully", "Chat > MyChatList", chatList);

                }
                catch (Exception ex)
                {

                    return new Message<object>(false, "Data retreival failed", "Chat > MyChatList", ex);
                }
            }
        }

        public Message<object> Send()
        {
            using (Data db = new Data())
            {
                try
                {
                    this.SentTime = DateTime.UtcNow;
                    db.Chats.Add(this);
                    db.SaveChanges();
                    this.From = db.Chatters.Find(this.FromId);
                    this.To = db.Chatters.Find(this.ToId);
                    AfterSave(this, new EventArgs());
                    return new Message<object>(true, "Message sent successfully", "Chat > Send", this);
                }
                catch (Exception ex)
                {
                    return new Message<object>(false, "Something went wrong", "Chat > Send", ex);
                }
            }
        }

        public delegate void OnSaveEventHandler(Chat sender, EventArgs e);
        public event OnSaveEventHandler Save_Completed;
        protected virtual void AfterSave(Chat source, EventArgs e)
        {
            if (Save_Completed != null)
            {
                Save_Completed(source, e);
            }
        }

        public Message<object> MarkAsRead(long me, long you)
        {
            using (Data db = new Data())
            {
                try
                {
                    var chats = db.Chats.Where(x => (x.From.ChatterId == you && x.To.ChatterId == me && x.IsRead == false) && !x.IsDeleted).ToList();
                    chats.ForEach(x =>
                    {
                        x.IsRead = true;
                        db.Chats.Add(x);
                        db.Entry(x).State = System.Data.Entity.EntityState.Modified;
                    });

                    db.SaveChanges();
                    return new Message<object>(true, "Marked as unread", "Chat > MarkAsRead", null);
                }
                catch (Exception ex)
                {
                    return new Message<object>(false, "Marking failed", "Chat > MarkAsRead", ex);
                }
            }

        }

    }
}