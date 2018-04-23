using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication2
{
    public static class Chatters
    {
        public static int Count { get { return Names.Count; }  }

        public static List<string> Names { get; set; } = new List<string>();

        public static List<string> AddMember(string Name)
        {
            Names.Add(Name);
            return Names;
        }
        public static List<string> RemoveMember(string Name)
        {
            Names.Remove(Name);
            return Names;
        }
    }
}