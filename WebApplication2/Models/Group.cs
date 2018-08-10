using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication2.Models
{
    public class Group
    {
        public long GroupId { get; set; }
        public string Name { get; set; }
        public List<Participant> Participants { get; set; }
        public long AdminId { get; set; }
        [ForeignKey("AdminId")]
        public Chatter Admin { get; set; }
        public DateTime CreatedAt { get; set; }
        [NotMapped]
        public string CreatedAtString { get; set; }


        public Message<object> Create()
        {
            try
            {
                using (Data db = new Data())
                {
                    if (string.IsNullOrWhiteSpace(this.Name))
                    {
                        return new Message<object>(false, "Provide a valid name for group", "Group > Create", null);
                    }

                    else
                    {
                        List<Participant> parties = new List<Participant>();
                        foreach (var party in this.Participants)
                        {
                            var chatter = db.Chatters.Where(x => x.Email == party.Email).FirstOrDefault();
                            if (chatter != null)
                            {
                                party.ChatterId = chatter.ChatterId;
                                parties.Add(party);
                            }

                        }
                        parties.Add(new Participant()
                        {
                            ChatterId = this.AdminId,
                            Email = db.Chatters.Find(this.AdminId).Email
                        });
                        this.Participants = parties;
                        this.CreatedAt = DateTime.UtcNow;
                        if (this.Participants.Count < 3)
                        {
                            return new Message<object>(false, "Add atleast two valid participants", "Group > Create", null);
                        }
                        db.Groups.Add(this);
                        db.SaveChanges();
                        return new Message<object>(true, "Group created", "Group > Create", null);
                    }

                }
            }
            catch (Exception ex)
            {
                return new Message<object>(false, "Something went wrong", "Group > Create", ex);
            }
        }

        public Message<object> Update()
        {
            try
            {
                using (Data db = new Data())
                {
                    if (string.IsNullOrWhiteSpace(this.Name))
                    {
                        return new Message<object>(false, "Provide a valid name for group", "Group > Update", null);
                    }

                    else
                    {
                        var group = db.Groups.Find(this.GroupId);
                        if (group == null)
                        {
                            return new Message<object>(false, "Invalid Group", "Group > Update", null);
                        }

                        List<Participant> parties = new List<Participant>();
                        foreach (var party in this.Participants)
                        {
                            var chatter = db.Chatters.Where(x => x.Email == party.Email).FirstOrDefault();
                            if (chatter != null)
                            {
                                party.ChatterId = chatter.ChatterId;
                                parties.Add(party);
                            }

                        }
                        parties.Add(new Participant()
                        {
                            ParticipantId = this.AdminId,
                            Email = db.Chatters.Find(this.AdminId).Email
                        });
                        group.Participants = parties;
                        if (this.Participants.Count < 3)
                        {
                            return new Message<object>(false, "Add atleast two participants", "Group > Update", null);
                        }
                        db.Participants.RemoveRange(db.Participants.Where(x => x.GroupId == group.GroupId));
                        db.SaveChanges();
                        db.Entry(group).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                        return new Message<object>(true, "Group updated", "Group > Update", null);
                    }

                }
            }
            catch (Exception ex)
            {
                return new Message<object>(false, "Something went wrong", "Group > Create", ex);
            }
        }

        public static Message<object> Delete(long groupId)
        {
            try
            {
                using (Data db = new Data())
                {

                    var group = db.Groups.Find(groupId);
                    if (group == null)
                    {
                        return new Message<object>(false, "Invalid Group", "Group > Delete", null);
                    }
                    db.GroupChats.RemoveRange(db.GroupChats.Where(x => x.GroupId == group.GroupId));
                    db.Participants.RemoveRange(db.Participants.Where(x => x.GroupId == group.GroupId));
                    db.Groups.Remove(group);
                    db.SaveChanges();
                    return new Message<object>(true, "Group deleted", "Group > Delete", null);
                }
            }
            catch (Exception ex)
            {
                return new Message<object>(false, "Something went wrong", "Group > Create", ex);
            }
        }

        public static Message<List<Group>> Get(long me)
        {
            try
            {
                using (Data db = new Data())
                {
                    var groups = db.Participants.Where(x => x.ChatterId == me).Select(x => x.Group).ToList();
                    groups.ForEach(x =>
                    {
                        x.Admin = db.Chatters.Find(x.AdminId);
                        x.CreatedAtString = x.CreatedAt.ToString("dd MMM yy");
                    });

                    if (groups != null && groups.Count != 0)
                    {
                        return new Message<List<Group>>(true, "Groups retrieved successfully", "Groups > Get", groups);
                    }
                    return new Message<List<Group>>(false, "retrieval failed");
                }

            }
            catch (Exception ex)
            {
                return new Message<List<Group>>(false, "Something went wrong", "Group > Get", ex);
                throw;
            }
        }
    }
}