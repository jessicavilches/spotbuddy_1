import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

send1() async {
  String username = 'jessicavilches7@gmail.com';
  String password = '';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = new SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = new Message()
    ..from = new Address(username, 'Your name')
    ..recipients.add('jessicavilches7@gmail.com')
    ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    ..bccRecipients.add(new Address('bccAddress@example.com'))
    ..subject = 'Test Dart Mailer library :: 😀 :: ${new DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

  // Use [catchExceptions]: true to prevent [send] from throwing.
  // Note that the default for [catchExceptions] will change from true to false
  // in the future!
  final sendReports = await send(message, smtpServer);

  // DONE


  // Let's send another message using a slightly different syntax:
  //
  // Addresses without a name part can be set directly.
  // For instance `..recipients.add('destination@example.com')`
  // If you want to display a name part you have to create an
  // Address object: `new Address('destination@example.com', 'Display name part')`
  // Creating and adding an Address object without a name part
  // `new Address('destination@example.com')` is equivalent to
  // adding the mail address as `String`.
  final equivalentMessage = new Message()
    ..from = new Address(username, 'Your name')
    ..recipients.add(new Address('destination@example.com'))
    ..ccRecipients.addAll([new Address('destCc1@example.com'), 'destCc2@example.com'])
    ..bccRecipients.add('bccAddress@example.com')
    ..subject = 'Test Dart Mailer library :: 😀 :: ${new DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

  final sendReports2 = await send(equivalentMessage, smtpServer);
}