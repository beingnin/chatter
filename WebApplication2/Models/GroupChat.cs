using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebApplication2.Models
{
    public class GroupChat
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long GroupChatId { get; set; }

        public string Message { get; set; }
        public long FromId { get; set; }
        public long GroupId { get; set; }
        [ForeignKey("FromId")]
        public Chatter From { get; set; }
        [ForeignKey("GroupId")]
        public Group Group { get; set; }

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

        public bool IsDeleted { get; set; }

        public bool IsRead { get; set; }


        public static Message<List<GroupChat>> GetChats(long groupId)
        {
            using (Data db = new Data())
            {
                try
                {
                    var chats = db.GroupChats.Include("From").Where(x => x.GroupId == groupId && !x.IsDeleted).ToList();
                    return new Message<List<GroupChat>>(true, "Chats retrieved successfully", "GroupChat > GetChats", chats);
                }
                catch (Exception ex)
                {
                    return new Message<List<GroupChat>>(false, "Data retrieval failed", "GroupChat > GetChats", ex);
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
                    db.GroupChats.Add(this);
                    db.SaveChanges();
                    this.From = db.Chatters.Find(this.FromId);
                    this.Group = db.Groups.Find(this.GroupId);
                    AfterSave(this, new EventArgs());
                    return new Message<object>(true, "Message sent successfully", "GroupChat > Send", this);
                }
                catch (Exception ex)
                {
                    return new Message<object>(false, "Something went wrong", "GroupChat > Send", ex);
                }
            }
        }

        public delegate void OnSaveEventHandler(GroupChat sender, EventArgs e);
        public event OnSaveEventHandler Save_Completed;
        protected virtual void AfterSave(GroupChat source, EventArgs e)
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