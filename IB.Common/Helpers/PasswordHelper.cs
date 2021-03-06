﻿using System;
using System.Security.Cryptography;
using System.Text;
using IB.Common.Cryptography;

namespace IB.Common.Helpers
{
    public static class PasswordHelper
    {
        /// <exception cref="System.ArgumentNullException"></exception>
        public static string ComputeHash(string password, string salt)
        {
            Expect.ArgumentNotNull(password, nameof(password));
            Expect.ArgumentNotNull(salt, nameof(salt));

            IHashAlgorithm hashAlgorithm = new Sha512Hash();
            return hashAlgorithm.CalculateHash(password + salt);
        }

        /// <exception cref="System.ArgumentException"><paramref name="length" /> must be > 0.</exception>
        /// <exception cref="CryptographicException">
        /// The cryptographic service provider (CSP) cannot be acquired.
        /// </exception>
        public static string GenerateSalt(int length)
        {
            Expect.ArgumentSatisfies(length, x => x > 0, "Value must be > 0.", nameof(length));

            var cryptoService = new RNGCryptoServiceProvider();
            var saltBytes = new byte[length];
            cryptoService.GetNonZeroBytes(saltBytes);
            return Encoding.Unicode.GetString(saltBytes);
        }

        /// <exception cref="ArgumentException"><paramref name="length" /> must be > 0.</exception>
        public static string Generate(int length)
        {
            Expect.ArgumentSatisfies(length, x => x > 0, "Value must be > 0.", nameof(length));

            var randomString = Convert.ToBase64String(Guid.NewGuid().ToByteArray()).Trim();
            return length <= randomString.Length ? randomString.Substring(0, length) : randomString;
        }
    }
}
