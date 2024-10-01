using RabbitMQ.Client.Events;
using RabbitMQ.Client;
using System.Text;
using Newtonsoft.Json;
using System.Net.Mail;
using System.Net;
using StudentOglasi.RabbitMQ;

var hostname = Environment.GetEnvironmentVariable("RABBITMQ_HOST");
var factory = new ConnectionFactory { HostName = hostname };
using var connection = factory.CreateConnection();
using var channel = connection.CreateModel();
channel.QueueDeclare(queue: "email_sending",
                     durable: false,
                     exclusive: false,
                     autoDelete: false,
                     arguments: null);
Console.WriteLine("Listening to messages....");
var consumer = new EventingBasicConsumer(channel);
consumer.Received += (model, ea) =>
{
    var body = ea.Body.ToArray();
    var message = Encoding.UTF8.GetString(body);
    var entitet = JsonConvert.DeserializeObject<EmailObject>(message);
    SendingEmail.posaljiMail(entitet!);
};
channel.BasicConsume(queue: "email_sending",
                     autoAck: true,
                     consumer: consumer);
Thread.Sleep(Timeout.Infinite);
Console.ReadLine();
