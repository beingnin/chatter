namespace WebApplication2.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class newcolumninserver : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Chatters", "IsVerified", c => c.Boolean(nullable: false));
            AddColumn("dbo.Chatters", "VerificationCode", c => c.Guid(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Chatters", "VerificationCode");
            DropColumn("dbo.Chatters", "IsVerified");
        }
    }
}
