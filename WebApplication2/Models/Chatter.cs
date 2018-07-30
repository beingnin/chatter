﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.IO;

namespace WebApplication2.Models
{
    public class Chatter
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long ChatterId { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "You must provide an email address")]
        [Index(IsUnique = true)]
        [MaxLength(50)]
        public string Email { get; set; }
        [Required]
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        [Required]
        public string HashedPasword { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ProfileImagePath { get; set; }
        [NotMapped]
        public string FullName
        {
            get { return FirstName + MiddleName ?? string.Empty + LastName ?? string.Empty; }
        }
        [NotMapped]
        public string Password { get; set; }
        /// <summary>
        /// Check this property to verify the chatter is an authenticated user in the app
        /// </summary>
        [NotMapped]
        public bool IsAuthenticated
        {
            get
            {
                return Authenticate();
            }
        }


        public Message<object> Register()
        {
            using (Data db = new Data())
            {
                try
                {
                    if (db.Chatters.LongCount(x => x.Email == this.Email) > 0)
                    {
                        return new Message<object>(false, "This email address has been already registered with us. Try login instead", "Chatter > Register", null);
                    }
                    else
                    {
                        this.HashedPasword = Helper.Cryptor.Hash(this.Password);
                        this.CreatedDate = DateTime.UtcNow;
                        this.ProfileImagePath = @"Theme/Images/Defaults/profile_default.jpg";
                        db.Chatters.Add(this);
                        db.SaveChanges();
                        db.Close();
                        return new Message<object>(true, "User registered succesfully", "Chatter > Register", null);
                    }
                }
                catch (Exception ex)
                {
                    return new Message<object>(false, "Something went wrong", "Chatter > Register", ex);
                }
                finally
                {
                    db.Close();
                }
            }
        }

        bool Authenticate()
        {
            using (Data db = new Data())
            {
                try
                {
                    string hashedPassword = Helper.Cryptor.Hash(this.Password);
                    long count = db.Chatters.LongCount(x => x.Email == this.Email && x.HashedPasword == hashedPassword);
                    db.Close();
                    return count == 1;
                }
                catch (Exception ex)
                {
                    return false;
                }
                finally
                {
                    db.Close();
                }
            }
        }

        public Message<object> Get(string email)
        {
            using (Data db = new Data())
            {
                try
                {
                    Chatter user = db.Chatters.Where(x => x.Email == email.Trim()).First();
                    return new Message<object>(true, "Successfully retrieved data", "Chatter > Get", new { Name = user.FirstName + " " + user.MiddleName + " " + user.LastName, Email = user.Email, ChatterId = user.ChatterId });
                }
                catch (Exception ex)
                {
                    return new Message<object>(false, "Data retrieval failed", "Chatter > Get", ex);
                }
            }
        }
        public Message<object> Get(long id)
        {
            using (Data db = new Data())
            {
                try
                {
                    Chatter user = db.Chatters.Find(id);
                    return new Message<object>(true, "Successfully retrieved data", "Chatter > Get", new { Name = user.FirstName + " " + user.MiddleName + " " + user.LastName, Email = user.Email, ChatterId = user.ChatterId });
                }
                catch (Exception ex)
                {
                    return new Message<object>(false, "Data retrieval failed", "Chatter > Get", ex);
                }
            }
        }

        public Message<object> ChangeProfilePic(long chatterId,string b64)
        {
            try
            {
                byte[] bytes = Convert.FromBase64String(b64);
                var dir = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Resources", "ProfilePics");
                if (!Directory.Exists(dir))
                {
                    Directory.CreateDirectory(dir);
                }
                string file = Guid.NewGuid().ToString() + ".jpg";
                File.WriteAllBytes(Path.Combine(dir,file), bytes);
                using (Data db=new Data())
                {
                    var chatter = db.Chatters.Find(chatterId);
                    if (chatter == null)
                    {
                        return new Message<object>(false, "You are not a valid chatter. Register with us");
                    }
                    chatter.ProfileImagePath = "/Resources/ProfilePics/" + file;
                    db.Entry<Chatter>(chatter).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    return new Message<object>(true, "Profile picture updated");
                }

            }
            catch (Exception ex)
            {
                return new Message<object>(false, "Something went wrong. Try again", "Chatter > UpdateProfilePic", ex);
            }
        }

    }
}