namespace WebApplication2.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class dbcreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Chats",
                c => new
                    {
                        ChatId = c.Long(nullable: false, identity: true),
                        Message = c.String(),
                        FromId = c.Long(nullable: false),
                        ToId = c.Long(nullable: false),
                        SentTime = c.DateTime(nullable: false),
                        IsSentToGroup = c.Boolean(nullable: false),
                        IsDeleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.ChatId)
                .ForeignKey("dbo.Chatters", t => t.FromId, cascadeDelete: false)
                .ForeignKey("dbo.Chatters", t => t.ToId, cascadeDelete: false)
                .Index(t => t.FromId)
                .Index(t => t.ToId);
            
            CreateTable(
                "dbo.Chatters",
                c => new
                    {
                        ChatterId = c.Long(nullable: false, identity: true),
                        Email = c.String(nullable: false, maxLength: 50),
                        FirstName = c.String(nullable: false),
                        MiddleName = c.String(),
                        LastName = c.String(),
                        HashedPasword = c.String(nullable: false),
                        CreatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.ChatterId)
                .Index(t => t.Email, unique: true);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Chats", "ToId", "dbo.Chatters");
            DropForeignKey("dbo.Chats", "FromId", "dbo.Chatters");
            DropIndex("dbo.Chatters", new[] { "Email" });
            DropIndex("dbo.Chats", new[] { "ToId" });
            DropIndex("dbo.Chats", new[] { "FromId" });
            DropTable("dbo.Chatters");
            DropTable("dbo.Chats");
        }
    }
}
