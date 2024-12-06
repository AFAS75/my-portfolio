import 'package:flutter/material.dart';
import '../screens/contact_screen.dart';

class SuccessDialogComponent extends StatelessWidget {
  final VoidCallback onOkPressed;
  final VoidCallback resetForm;

  const SuccessDialogComponent({super.key, required this.onOkPressed, required this.resetForm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Succès'),
      content: const Text('Votre message a bien été envoyé !'),
      actions: [
        TextButton(
          onPressed: () {
            resetForm();
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
  }
}