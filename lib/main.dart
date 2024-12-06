import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './screens/home_screen.dart';
import './screens/contact_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon portfolio',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>  HomeScreen(),
        '/contact': (context) => const ContactScreen(),
      },
    );
  }
}
