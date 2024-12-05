import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TechnoCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<Map<String, dynamic>> technologies;

  const TechnoCard({ super.key, required this.title, required this.color, required this.technologies });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: color,
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),  
                topRight: Radius.circular(12),  
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20.0,
                runSpacing: 20.0,
                children: technologies.map((techno) {
                  return Column(
                    children: [
                      FaIcon(techno['icon'], size: 40, color: techno['color']),
                      SizedBox(height: 6),
                      Text(
                        techno['label'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amber, width: 3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            width: double.infinity,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TechnologiesCard extends StatelessWidget {
  const TechnologiesCard({ super.key });
  
  @override
  Widget build(BuildContext context) {
  final Color backgroundColorTitle = Colors.amber;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TechnoCard(
          title: 'FRONTEND',
          color: backgroundColorTitle,
          technologies: [ 
            {'icon': FontAwesomeIcons.react, 'color': Colors.blue, 'label': 'React'},
            {'icon': FontAwesomeIcons.squareJs, 'color': Colors.yellow, 'label': 'JS'},
            {'icon': FontAwesomeIcons.flutter, 'color': Colors.blue[900], 'label': 'Flutter'},
            {'icon': FontAwesomeIcons.html5, 'color': Colors.orange[900], 'label': 'HTML 5'},
            {'icon': FontAwesomeIcons.css3Alt, 'color': Colors.blue[900], 'label': 'CSS 3'},
          ],
        ),
        TechnoCard(
          title: 'BACKEND',
          color: backgroundColorTitle,
          technologies: [ 
            {'icon': FontAwesomeIcons.node, 'color': Colors.green, 'label': 'Node'}, 
            {'icon': FontAwesomeIcons.database, 'color': Colors.white, 'label': 'MongoDB'},
            ],
        ),
        TechnoCard(
          title: 'AUTRES',
          color: backgroundColorTitle,
          technologies: [
            {'icon': FontAwesomeIcons.github, 'color': Colors.black, 'label': 'GitHub'},
          ]
        )
      ]
    );
  }
}
