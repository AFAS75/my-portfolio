import 'package:flutter/material.dart';

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart;

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

  // Future<void> _sendEmail() async {
  //   final String firstName = _firstNameController.text;
  //   final String lastName = _lastNameController.text;
  //   final String email = _emailController.text;
  //   final String company = _companyController.text;
  //   final String phone = _phoneController.text;
  //   final String message = _messageController.text;

  //   final response = await http.post(
  //     Uri.parse('https://api.sendgrid.com/v3/mail/send'),
  //     Headers: {
  //       'Authorization': 'Bearer ${dotenv.env['SENDGRID_API']}',
  //       'Content-type': 'application/json',
  //     },
  //     body: jsonEncode({
  //       'personalization': [
  //         {
  //           'to': [
  //             {'email': 'votre.email@exemple.fr'}
  //           ],
  //           'subject': 'Nouveau message de contact',
  //         }
  //       ],
  //       'from': {'email': email},
  //       'content': [
  //         {
  //           'type': 'text/plain',
  //           'value': 'LastName: $lastName\nFirstName: $firstName\nEmail: $email\nCompany: $company\nPhone: $phone\nMessage: $message',
  //         }
  //       ]
  //     })
  //   );

  //   if (!mounted) return;

  //   if (response.statusCOde == 202) {
  //     _showSuccessDialog();
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed ton send email')),
  //     );
  //   }
  // }

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
                Navigator.of(context).pop();
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // _sendEmail();
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