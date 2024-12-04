import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  final Function(GlobalKey) scrollToSection;
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey technoKey;

  const DrawerComponent({
    super.key, 
    required this.scrollToSection,
    required this.aboutKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.technoKey,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Transform.translate(
              offset: Offset(-10, 0),
              child: Text(
                'Andrés Angulo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ), 
            ),
            accountEmail: Transform.translate(
              offset: Offset(-10, 0),
              child: Text(
                textAlign: TextAlign.justify,
                'Développeur Web & Mobile',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/drawer_background.jpeg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          _createDrawerItem(
            icon: Icons.info,
            text: 'À propos',
            onTap: () => _onDrawerItemTap(context, aboutKey),
          ),
          _createDrawerItem(
            icon: Icons.folder_open,
            text: 'Projets',
            onTap: () => _onDrawerItemTap(context, projectsKey),
          ),
          _createDrawerItem(
            icon: Icons.build_circle,
            text: 'Compétences',
            onTap: () => _onDrawerItemTap(context, skillsKey),
          ),
          _createDrawerItem(
            icon: Icons.memory,
            text: 'Technologies',
            onTap: () => _onDrawerItemTap(context, technoKey),
          ),
          _createDrawerItem(
            icon: Icons.contact_mail,
            text: 'Contact',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contact');
            }
          ),
        ],
      )
    );
  }

  Widget _createDrawerItem({ required IconData icon, required String text, required GestureTapCallback onTap}) {
    return Padding( 
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListTile(
            leading: Icon(icon),
            title: Text(text),
            onTap: onTap,
          )
      ),
    );
  }

  void _onDrawerItemTap(BuildContext context, GlobalKey key) {
    Navigator.pop(context);
    scrollToSection(key);
  }
}