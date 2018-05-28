using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication2.Models
{
    /// <summary>
    /// General class for common function returns
    /// Can be used for sending additional data with each response
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class Message<T>
    {
        public bool Success { get; set; }
        public string Response { get; set; }
        public string Operation { get; set; }
        public Exception Exception { get; set; }
        public T Data { get; set; }

        public Message(bool success, string response)
        {
            Success = success;
            Response = response;
        }

        public Message(bool success,string response, string operation,T data):this(success,response)
        {
            Operation = operation;
            Data = data;
        }
        public Message(bool success, string response, string operation, Exception ex) : this(success, response)
        {
            Operation = operation;
            Exception = ex;
        }
    }
}