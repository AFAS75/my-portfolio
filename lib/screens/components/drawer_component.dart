import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  final Function(GlobalKey) scrollToSection;
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey technoKey;

  DrawerComponent({
    required this.scrollToSection,
    required this.aboutKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.technoKey,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Text('MENU')
            )
          ),
          Expanded(
            child: ListView(
             children: <Widget>[
              ListTile(
                title: Text('À propos'),
                onTap: () {
                  Navigator.pop(context);
                  scrollToSection(aboutKey);
                },
              ),
              ListTile(
                title: Text('Projets'),
                onTap: () {
                  Navigator.pop(context);
                  scrollToSection(projectsKey);
                },
              ),
              ListTile(
                title: Text('Compétences'),
                onTap: () {
                  Navigator.pop(context);
                  scrollToSection(skillsKey);
                },
              ),
              ListTile(
                title: Text('Technologies'),
                onTap: () {
                  Navigator.pop(context);
                  scrollToSection(technoKey);
                },
              ),
              ListTile(
                title: Text('Contact'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/contact');
                }
              ),
            ]),
          ),
      ]),
    );
  }
}