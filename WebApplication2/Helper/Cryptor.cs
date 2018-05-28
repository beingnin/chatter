using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace WebApplication2.Helper
{
    public static class Cryptor
    {
        #region Key
        const string SALT = "ksljhndfjkosfkl8werut89eut89eDSD";
        const string IV = "34345(*(*&";
        #endregion

        public static dynamic Hash(string RawData)
        {

            byte[] SaltBytes = Convert.FromBase64String(SALT);
            byte[] PlainData = ASCIIEncoding.UTF8.GetBytes(RawData);
            byte[] DataAndSalt = new byte[PlainData.Length + SaltBytes.Length];
            for (int i = 0; i < PlainData.Length; i++)
            {
                DataAndSalt[i] = PlainData[i];
            }
            for (int j = 0; j < SaltBytes.Length; j++)
            {
                DataAndSalt[PlainData.Length + j] = SaltBytes[j];
            }
            SHA256Managed sha256 = new SHA256Managed();
            byte[] HashValue = sha256.ComputeHash(DataAndSalt);
            return Convert.ToBase64String(HashValue);
        }


    }
}
