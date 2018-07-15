namespace WebApplication2.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class newcolumnisread : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Chats", "IsRead", c => c.Boolean(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Chats", "IsRead");
        }
    }
}
