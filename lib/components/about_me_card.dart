import 'package:flutter/material.dart';

class AboutMeCard extends StatelessWidget {

  const AboutMeCard({ super.key });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color.fromARGB(255, 46, 50, 78),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 40),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Depuis le début de cette aven-\n'
                  'ture, j\'explore quotidennement\n'
                  'l\'univers fascinant du déve-\n'
                  'loppement et du code. Cette'
                  '\npassion grandissante me pou-'
                  '\nsse à affiner mes compétences'
                  '\net à approfondir ma compréhension de ce domaine riche et complexe. Mon parcours en développement web full-stack me permet de transformer des idées innovantes en solutions numériques. Je vous invite à découvrir certains de mes projets.\n\n'
                  '🔍 Vision: Apporter des solutions technologiques qui font la différence.\n\n'
                  '🚀 Motivation: L\'innovation constante, guidée par la curiosité et l\'envie de créer.\n\n'
                  '🌍 Engagement: Collaborer et apprendre pour évoluer dans un monde numérique en perpétuelle mutation.', 
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Transform.translate(
                  offset: Offset(25, 2),
                  child: Image.asset(
                    'assets/profile.png',
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
