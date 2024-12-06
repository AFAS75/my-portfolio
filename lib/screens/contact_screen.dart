import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../components/success_dialog_component.dart';
import '../components/form_contact_component.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({ super.key });

   @override
   ContactScreenState createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _resetForm() { 
    _firstNameController.clear(); 
    _lastNameController.clear(); 
    _emailController.clear();
    _companyController.clear(); 
    _phoneController.clear(); 
    _messageController.clear();
    _formKey.currentState?.reset();
  }

  Future<void> _sendEmail() async {
    setState(() {
      _isSending = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        final smtpServer = SmtpServer(
          dotenv.env['MAILTRAP_HOST']!,
          port: int.parse(dotenv.env['MAILTRAP_PORT']!),
          username: dotenv.env['MAILTRAP_USERNAME'],
          password: dotenv.env['MAILTRAP_PASSWORD'],
        );

        final message = Message()
        ..from = Address(dotenv.env['MAILTRAP_FROM']!,'${_firstNameController.text} ${_lastNameController.text}')
        ..recipients.add(dotenv.env['MAILTRAP_TO']!)
        ..subject = 'New contact message'
        ..text = 'LastName: ${_lastNameController.text}\n'
                  'FirstName: ${_firstNameController.text}\n'
                  'Email: ${_emailController.text}\n'
                  'Company: ${_companyController.text}\n'
                  'Phone: ${_phoneController.text}\n'
                  'Message: ${_messageController.text}';

          await send(message, smtpServer);
          _showSuccessDialog();
      } on MailerException catch (error) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send email : ${error.message}'),)
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar( 
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isSending = false;
        });
      }
    } else {
      setState(() {
        _isSending = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessDialogComponent(
          onOkPressed: () {
            Navigator.of(context).pop();
          },
          resetForm: _resetForm
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 46, 50, 78),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 46, 50, 78),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormContactComponent(
            formKey: _formKey, 
            firstNameController: _firstNameController, 
            lastNameController: _lastNameController, 
            emailController: _emailController, 
            companyController: _companyController, 
            phoneController: _phoneController, 
            messageController: _messageController, 
            isSending: _isSending, 
            sendEmail: _sendEmail,
            ),
           
        ),
      ),
    );
  }
}