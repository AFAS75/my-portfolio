import 'package:flutter/material.dart';

class FormContactComponent extends StatelessWidget {
  final GlobalKey<FormState> formKey; 
  final TextEditingController firstNameController; 
  final TextEditingController lastNameController; 
  final TextEditingController emailController; 
  final TextEditingController companyController; 
  final TextEditingController phoneController; 
  final TextEditingController messageController;
  final bool isSending; 
  final VoidCallback sendEmail;

  const FormContactComponent({ 
    super.key, 
    required this.formKey, 
    required this.firstNameController, 
    required this.lastNameController, 
    required this.emailController, 
    required this.companyController, 
    required this.phoneController, 
    required this.messageController, 
    required this.isSending, 
    required this.sendEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
            controller: lastNameController, 
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
            controller: firstNameController, 
            labelText: 'Prénom', 
            validator: (value) => null,
            icon: Icons.person,
          ),
          _buildTextField(
            controller: emailController, 
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
            controller: companyController, 
            labelText: 'Société', 
            validator: (value) => null,
            icon: Icons.business,
          ),
          _buildTextField(
            controller: phoneController, 
            labelText: 'Téléphone', 
            keyboardType: TextInputType.phone,
            validator: (value) => null,
            icon: Icons.phone,
          ),
          _buildTextField(
            controller: messageController, 
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
          isSending 
            ? Center(child: CircularProgressIndicator()) 
            : ElevatedButton(
            onPressed: sendEmail,
            child: const Text('Envoyer'),
          ),
        ],
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