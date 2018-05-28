namespace WebApplication2.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class propicadd : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Chatters", "ProfileImagePath", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.Chatters", "ProfileImagePath");
        }
    }
}
