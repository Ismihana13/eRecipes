using System.Net.Mail;
using System.Net;

namespace eRecipes.RabbitMQ
{
    public class EmailSender : IEmailSender
    {

        private readonly string _gMail = "erecipes.rs2@gmail.com";
        private readonly string _gPass = "gssj bomq rfwr oybg";

        public EmailSender()
        {
        }

        public Task SendEmailAsync(string email, string subject, string message)
        {
            var client = new SmtpClient("smtp.gmail.com", 587)
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(_gMail, _gPass)
            };

            return client.SendMailAsync(
                new MailMessage(from: _gMail,
                                to: email,
                                subject,
                                message
                                ));
        }
    }
}
