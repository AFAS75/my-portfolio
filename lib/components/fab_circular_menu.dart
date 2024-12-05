import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/contact_screen.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:url_launcher/url_launcher.dart';


class FabCircularMenu extends StatelessWidget {
  const FabCircularMenu({ super.key });

  @override
  Widget build(BuildContext context) {
    return FabCircularMenuPlus(
      ringColor: Color.fromARGB(200, 46, 50, 78),
      ringDiameter: 200.0,
      ringWidth: 40.0,
      fabSize: 54.0,
      fabElevation: 8.0,
      fabIconBorder: CircleBorder(),
      fabColor: Colors.white,
      fabOpenIcon: FaIcon(FontAwesomeIcons.handshake, color: Color.fromARGB(255, 46, 50, 78)),
      fabCloseIcon: Icon(Icons.close, color: Color.fromARGB(255, 46, 50, 78)),
      fabMargin: const EdgeInsets.all(0),
      animationCurve: Curves.easeInCirc,
      animationDuration: Duration(milliseconds: 500),
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.mail, color: Colors.white),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactScreen()),
            );
          }, 
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.github, color: Colors.white),
          onPressed: () async {
            final url = 'https://github.com/AFAS75';
            try {
              await launchUrl(Uri.parse(url));
            } catch (error) {
              throw 'Could not launch $url, error: $error';
            }
          }, 
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white),
          onPressed: () async {
            const url = 'https://www.linkedin.com/in/andrés-angulo';
            try {
              await launchUrl(Uri.parse(url));                
            } catch (error) {
              throw 'Could not launch $url, error: $error';
            }
          }, 
        ),
      ],
    );
  }
}