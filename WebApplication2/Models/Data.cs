using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace WebApplication2.Models
{
    public class Data : DbContext
    {
        public Data() : base("DefaultConnection")
        {
        }
        public DbSet<Chatter> Chatters { get; set; }
        public DbSet<Chat> Chats { get; set; }
        public DbSet<GroupChat> GroupChats { get; set; }
        public DbSet<Group> Groups { get; set; }
        public DbSet<Participant> Participants { get; set; }
        public void Initialise()
        {
            Database.SetInitializer<Data>(new CreateDatabaseIfNotExists<Data>());
        }
        public void Close()
        {
            this.Database.Connection.Close();
        }

    }
}