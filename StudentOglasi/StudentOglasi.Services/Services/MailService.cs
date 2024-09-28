using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using RabbitMQ.Client;
using StudentOglasi.Model;
namespace StudentOglasi.Services
{
    public class MailService : IMailService
    {
        private readonly string serverAddress = Environment.GetEnvironmentVariable("SERVER_ADDRESS") ?? "smtp.gmail.com";
        private readonly string mailSender = Environment.GetEnvironmentVariable("MAIL_SENDER") ?? "studentoglasi.com";
        private readonly string mailPass = Environment.GetEnvironmentVariable("MAIL_PASS") ?? "ocsnmzwxcraeeywi";
        private readonly int port = int.Parse(Environment.GetEnvironmentVariable("MAIL_PORT") ?? "587");
        public async Task startConnection(EmailObject obj)
        {
            var hostname = "rabbitmq";
            var factory = new ConnectionFactory { HostName = hostname };
            //UserName = username, Password = password };
            using var connection = factory.CreateConnection();
            using var channel = connection.CreateModel();
            channel.QueueDeclare(queue: "email_sending",
                                 durable: false,
                                 exclusive: false,
                                 autoDelete: false,
                                 arguments: null);
            var body = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(obj));
            channel.BasicPublish(exchange: string.Empty,
                                 routingKey: "email_sending",
                                 basicProperties: null,
                                 body: body);
        }
    }
}