using AutoMapper;
using DotNetEnv;
using FirebaseAdmin.Messaging;
using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;
using StudentOglasi.Model;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Obavijesti = StudentOglasi.Services.Database.Obavijesti;

namespace StudentOglasi.Services.Services
{
    public class ObavijestiService : BaseService<Model.Obavijesti, Database.Obavijesti, BaseSearchObject>, IObavijestiService
    {
        public ObavijestiService(StudentoglasiContext context, IMapper mapper) : base(context, mapper) { 
        
        }

        public async Task<string> SendNotificationOglasi(string title, string message, int id, string notificationType)
        {
            // Load environment variables from .env file 
            Env.Load();

            // Check if Firebase App is already initialized
            if (FirebaseApp.DefaultInstance == null)
            {
                // Retrieve environment variables for Firebase configuration
                string projectId = Environment.GetEnvironmentVariable("FIREBASE_PROJECT_ID");
                string privateKeyId = Environment.GetEnvironmentVariable("FIREBASE_PRIVATE_KEY_ID");
                string privateKey = Environment.GetEnvironmentVariable("FIREBASE_PRIVATE_KEY")?.Replace("\\n", "\n");
                string clientEmail = Environment.GetEnvironmentVariable("FIREBASE_CLIENT_EMAIL");
                string clientId = Environment.GetEnvironmentVariable("FIREBASE_CLIENT_ID");
                string authUri = Environment.GetEnvironmentVariable("FIREBASE_AUTH_URI");
                string tokenUri = Environment.GetEnvironmentVariable("FIREBASE_TOKEN_URI");
                string authProviderCertUrl = Environment.GetEnvironmentVariable("FIREBASE_AUTH_PROVIDER_CERT_URL");
                string clientCertUrl = Environment.GetEnvironmentVariable("FIREBASE_CLIENT_CERT_URL");

                // Set up Firebase options using the retrieved environment variables
                var options = new AppOptions()
                {
                    Credential = GoogleCredential.FromJson($@"
                {{
                    ""type"": ""service_account"",
                    ""project_id"": ""{projectId}"",
                    ""private_key_id"": ""{privateKeyId}"",
                    ""private_key"": ""{privateKey}"",
                    ""client_email"": ""{clientEmail}"",
                    ""client_id"": ""{clientId}"",
                    ""auth_uri"": ""{authUri}"",
                    ""token_uri"": ""{tokenUri}"",
                    ""auth_provider_x509_cert_url"": ""{authProviderCertUrl}"",
                    ""client_x509_cert_url"": ""{clientCertUrl}""
                }}")
                };

                // Initialize Firebase app
                var defaultApp = FirebaseApp.Create(options);
                Console.WriteLine($"Firebase App Initialized: {defaultApp.Name}");
            }
            var obavijest = new Obavijesti
            {
                OglasiId = id,
                Naziv = title,
                Opis = message,
                DatumKreiranja = DateTime.Now
            };

            // Save the notification to the database
            _context.Obavijestis.Add(obavijest);
            await _context.SaveChangesAsync();
            // Create a new notification message
            var notificationMessage = new Message()
            {
                Notification = new Notification
                {
                    Title = title,
                    Body = message
                },
                Topic = "news",
                Data = new Dictionary<string, string>()
            {
                { "notificationType", notificationType }
            }
            };

            var messaging = FirebaseMessaging.DefaultInstance;
            try
            {
                // Send the notification and log the message ID
                var result = await messaging.SendAsync(notificationMessage);
                Console.WriteLine($"Successfully sent message: {result}");
                return result;
            }
            catch (FirebaseMessagingException ex)
            {
                // Handle Firebase messaging errors
                Console.WriteLine($"Error sending message: {ex.Message}");
                Console.WriteLine($"Error details: {ex.ErrorCode}");
                return null;
            }
            catch (Exception e)
            {
                // Handle other exceptions
                Console.WriteLine($"An unexpected error occurred: {e.Message}");
                return null;
            }
        }
        public async Task<string> SendNotificationSmjestaj(string title, string message, int id, string notificationType)
        {
            // Load environment variables from .env file 
            Env.Load();

            // Check if Firebase App is already initialized
            if (FirebaseApp.DefaultInstance == null)
            {
                // Retrieve environment variables for Firebase configuration
                string projectId = Environment.GetEnvironmentVariable("FIREBASE_PROJECT_ID");
                string privateKeyId = Environment.GetEnvironmentVariable("FIREBASE_PRIVATE_KEY_ID");
                string privateKey = Environment.GetEnvironmentVariable("FIREBASE_PRIVATE_KEY")?.Replace("\\n", "\n");
                string clientEmail = Environment.GetEnvironmentVariable("FIREBASE_CLIENT_EMAIL");
                string clientId = Environment.GetEnvironmentVariable("FIREBASE_CLIENT_ID");
                string authUri = Environment.GetEnvironmentVariable("FIREBASE_AUTH_URI");
                string tokenUri = Environment.GetEnvironmentVariable("FIREBASE_TOKEN_URI");
                string authProviderCertUrl = Environment.GetEnvironmentVariable("FIREBASE_AUTH_PROVIDER_CERT_URL");
                string clientCertUrl = Environment.GetEnvironmentVariable("FIREBASE_CLIENT_CERT_URL");

                // Set up Firebase options using the retrieved environment variables
                var options = new AppOptions()
                {
                    Credential = GoogleCredential.FromJson($@"
                {{
                    ""type"": ""service_account"",
                    ""project_id"": ""{projectId}"",
                    ""private_key_id"": ""{privateKeyId}"",
                    ""private_key"": ""{privateKey}"",
                    ""client_email"": ""{clientEmail}"",
                    ""client_id"": ""{clientId}"",
                    ""auth_uri"": ""{authUri}"",
                    ""token_uri"": ""{tokenUri}"",
                    ""auth_provider_x509_cert_url"": ""{authProviderCertUrl}"",
                    ""client_x509_cert_url"": ""{clientCertUrl}""
                }}")
                };

                // Initialize Firebase app
                var defaultApp = FirebaseApp.Create(options);
                Console.WriteLine($"Firebase App Initialized: {defaultApp.Name}");
            }
            var obavijest = new Obavijesti
            {
                SmjestajiId = id,
                Naziv = title,
                Opis = message,
                DatumKreiranja=DateTime.Now
            };

            // Save the notification to the database
            _context.Obavijestis.Add(obavijest);
            await _context.SaveChangesAsync();
            // Create a new notification message
            var notificationMessage = new Message()
            {
                Notification = new Notification
                {
                    Title = title,
                    Body = message
                },
                Topic = "news",
                Data = new Dictionary<string, string>()
            {
                { "notificationType", notificationType }
            }
            };

            var messaging = FirebaseMessaging.DefaultInstance;
            try
            {
                // Send the notification and log the message ID
                var result = await messaging.SendAsync(notificationMessage);
                Console.WriteLine($"Successfully sent message: {result}");
                return result;
            }
            catch (FirebaseMessagingException ex)
            {
                // Handle Firebase messaging errors
                Console.WriteLine($"Error sending message: {ex.Message}");
                Console.WriteLine($"Error details: {ex.ErrorCode}");
                return null;
            }
            catch (Exception e)
            {
                // Handle other exceptions
                Console.WriteLine($"An unexpected error occurred: {e.Message}");
                return null;
            }
        }
    }
}
