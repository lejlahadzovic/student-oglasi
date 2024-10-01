using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;
namespace StudentOglasi.RabbitMQ
{
    public class SendingEmail
    {
        public static void posaljiMail(EmailObject obj)
        {
            string serverAddress = Environment.GetEnvironmentVariable("SERVER_ADDRESS");
            string mailSender = Environment.GetEnvironmentVariable("MAIL_SENDER");
            string mailPass = Environment.GetEnvironmentVariable("MAIL_PASS");
            int port = int.Parse(Environment.GetEnvironmentVariable("MAIL_PORT"));
            string content = $"<p>{obj.poruka}</p>";
            string subject = obj.tema;
            var message = new MailMessage()
            {
                From = new MailAddress(mailSender),
                To = { new MailAddress(obj.emailAdresa) },
                Subject = subject,
                Body = content,
                IsBodyHtml = true
            };
            var smtpClient = new SmtpClient(serverAddress, port)
            {
                Credentials = new NetworkCredential(mailSender, mailPass),
                EnableSsl = true
            };
            try
            {
                Console.WriteLine("ADDRESS: " + serverAddress + ", SENDER: " + mailSender  + ", PORT: " + port.ToString());
                smtpClient.Send(message);
                Console.WriteLine("Email sent successfully.");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex?.Message);
            }
        }
    }
}
    