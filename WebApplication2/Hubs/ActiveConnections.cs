using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication2.Hubs
{
    public static class Connections
    {
        public static Dictionary<long, List<string>> Active = new Dictionary<long, List<string>>();
        public static List<string> GetConnections(long key)
        {
            List<string> connections;
            if (Active.TryGetValue(key, out connections))
            {
                return connections;
            }

            return new List<string>();
        }
    }
    
}