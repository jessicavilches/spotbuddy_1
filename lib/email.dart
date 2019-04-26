import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'home.dart' as home;
import 'globals.dart' as globals;

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class sendEmail extends StatefulWidget {
  @override
  _sendEmail createState() => _sendEmail();
}

class _sendEmail extends State<sendEmail> {

  final _userEmail = TextEditingController(
    text: globals.email,
  );

  final _userPassword = TextEditingController(
    text: '',
  );

  final _recipientController = TextEditingController(
    text: globals.matchEmail,
  );

  final _subjectController = TextEditingController(text: 'The subject');

  final _bodyController = TextEditingController(
    text: 'Mail body.',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



    String platformResponse;


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Send Message'),
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
              alignment: Alignment.centerLeft,
            ),
            IconButton(
              onPressed: send_email,
              icon: Icon(Icons.send),
              alignment: Alignment.centerRight,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _userEmail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Your Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _userPassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Your Password',
                      ),
                      obscureText: true,
                    ),
                  ),
                  /*Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _recipientController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Recipient',
                      ),
                    ),
                  ),*/
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Subject',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _bodyController,
                      maxLines: 10,
                      decoration: InputDecoration(
                          labelText: 'Body', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  send_email() async {
    //String username = 'jessicavilches7@gmail.com';
    //String password = '';
    final smtpServer = gmail(_userEmail.text, _userPassword.text);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = new SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = new Message()
      ..from = new Address(_userEmail.text, 'Your name')
      ..recipients.add(_recipientController.text)
    //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    //..bccRecipients.add(new Address('bccAddress@example.com'))
      ..subject = '${_subjectController.text} ${new DateTime.now()}'
      ..text = _bodyController.text;
    //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    // Use [catchExceptions]: true to prevent [send] from throwing.
    // Note that the default for [catchExceptions] will change from true to false
    // in the future!
    final sendReports = await send(message, smtpServer);
    print("recipient:");
    print(_recipientController.text);
    print(_subjectController.toString());
    print("sent email");

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
      ..from = new Address(_userEmail.text, 'Your name')
      ..recipients.add(_recipientController.toString())
     // ..ccRecipients.addAll([new Address('destCc1@example.com'), 'destCc2@example.com'])
      //..bccRecipients.add('bccAddress@example.com')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${new DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.';
      //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    final sendReports2 = await send(equivalentMessage, smtpServer);

    Navigator.pop(context);
  }

}
