// See https://aka.ms/new-console-template for more information

using EasyNetQ;
using eRecipes.Model.Messages;

Console.WriteLine("Hello, World!");

var bus = RabbitHutch.CreateBus("host=localhost:5672");
await bus.PubSub.SubscribeAsync<ReceptActivated>("console_printer", msg =>
{
    Console.WriteLine($"Recipes activated: {msg.Recept.Naziv}");
});

await bus.PubSub.SubscribeAsync<ReceptActivated>("console_printer", msg =>
{
    Console.WriteLine($"Recipes activated 2: {msg.Recept.Naziv}");
});

await bus.PubSub.SubscribeAsync<ReceptActivated>("mail_sender", msg =>
{
    Console.WriteLine($"Sending email for: {msg.Recept.Naziv}");
    //to do send email
});

Console.WriteLine("Listening for messages, press <return> key to close!");
Console.ReadLine();



