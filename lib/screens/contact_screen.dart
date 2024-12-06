import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

// import 'dart:convert';
// import 'package:http/http.dart' as http;

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

          final sendReport = await send(message, smtpServer);
          _showSuccessDialog();
          print('Message envoyé: ${sendReport.toString()}');
      } on MailerException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send email : ${error.message}'),)
        );
        print('Erreur lors de l\'envoi de l\'email: ${error.message}');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar( 
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
        print('Error: ${e.toString()}');
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
        return AlertDialog(
          title: const Text('Succès'),
          content: const Text('Votre message a bien été envoyé !'),
          actions: [
            TextButton(
              onPressed: () {
                _resetForm;
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ContactScreen(),
                  ),
                );
              }, 
              child: const Text('OK'),
            ),
          ],
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
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Vous souhaitez me contacter ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4.0),
                Text(
                  'N\'hésitez pas à me laisser un message. Je vous contacterai dès que possible !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                _buildTextField(
                  controller: _lastNameController, 
                  labelText: 'Nom*', 
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nom';
                    } 
                    return null;
                  },
                  icon: Icons.person_outline,
                ),
                _buildTextField(
                  controller: _firstNameController, 
                  labelText: 'Prénom', 
                  validator: (value) => null,
                  icon: Icons.person,
                ),
                _buildTextField(
                  controller: _emailController, 
                  labelText: 'email*',
                  keyboardType: TextInputType.emailAddress, 
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    } 
                    return null;
                  },
                  icon: Icons.email,
                ),
                _buildTextField(
                  controller: _companyController, 
                  labelText: 'Société', 
                  validator: (value) => null,
                  icon: Icons.business,
                ),
                _buildTextField(
                  controller: _phoneController, 
                  labelText: 'Téléphone', 
                  keyboardType: TextInputType.phone,
                  validator: (value) => null,
                  icon: Icons.phone,
                ),
                _buildTextField(
                  controller: _messageController, 
                  labelText: 'Message*',
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre message';
                    } 
                    return null;
                  },
                  icon: Icons.message,
                ),
                const SizedBox(height: 16.0),
                _isSending 
                  ? Center(child: CircularProgressIndicator()) 
                  : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _sendEmail();
                      print('OK TU ES FORT');
                    }
                  }, 
                  child: const Text('Envoyer'),
                ),
              ],
            ),
          ),     
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          prefixIcon: icon != null ? Icon(icon) : null,
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(8.0)
          ),
          labelStyle: TextStyle(color: Colors.black),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
      )
    );
  }
}