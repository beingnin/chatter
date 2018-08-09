using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication2.Models
{
    public class Group
    {
        public long GroupId { get; set; }
        public string Name { get; set; }
        public List<Participant> Participants { get; set; }



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
                    if (this.Participants.Count < 2)
                    {
                        return new Message<object>(false, "Add atleast two participants", "Group > Create", null);
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
                        this.Participants = parties;
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
                    if (this.Participants.Count < 2)
                    {
                        return new Message<object>(false, "Add atleast two participants", "Group > Update", null);
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
                        group.Participants = parties;
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
    }
}