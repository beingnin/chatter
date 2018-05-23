using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebApplication2.Models
{
    public class Chatter
    {
        [Key]
        public int ChatterId { get; set; }
        [Required(AllowEmptyStrings =false,ErrorMessage ="You must provide an username")]
        [Index(IsUnique = true)]
        public string UserName { get; set; }
        [Required]
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        [NotMapped]
        public string FullName
        {
            get { return FirstName + MiddleName ?? string.Empty + LastName ?? string.Empty; }
        }
        public string Password { get; set; }

    }
}