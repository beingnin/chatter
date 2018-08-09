using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebApplication2.Models
{
    public class Participant
    {
        public long ParticipantId { get; set; }
        public string Email { get; set; }
        public long ChatterId { get; set; }
        [ForeignKey("ChatterId")]
        public Chatter Chatter { get; set; }
        public long GroupId { get; set; }
        [ForeignKey("GroupId")]
        public Group Group { get; set; }

    }
}