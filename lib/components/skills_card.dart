import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SkillsCard extends StatelessWidget {
  const SkillsCard({ super.key });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> skills =[
      { 
        'title': 'Création de sites web sur mesure', 
        'color': Colors.amber, 
        'description': 'Conception de sites web personnalisés, tenant compte de vos ' 'exigences et utilisant les dernières technologies et ' 'tendances de design.', 
        'icon': FontAwesomeIcons.computer, 
      }, 
      { 
        'title': 'Développement d\'applications web', 
        'color': Colors.green, 
        'description': 'Création d\'applications web interactives et performantes, ' 'améliorant l\'expérience utilisateur et répondant à des ' 'besoins spécifiques.', 
        'icon': FontAwesomeIcons.mobile, 
      }, 
      { 
        'title': 'Optimisation pour les moteurs de recherche (SEO)', 
        'color': Colors.blue, 
        'description': 'Amélioration de la visibilité en ligne par l\'optimisation du ' 'site web pour les moteurs de recherche.', 
        'icon': FontAwesomeIcons.magnifyingGlass, 
      }, 
      { 
        'title': 'Hébergement & Déploiement', 
        'color': Colors.pink, 
        'description': 'Déploiement des solutions sur les plateformes adaptées à vos ' 'besoins, simplifiant les interactions avec les prestataires ' 'de services.', 
        'icon': FontAwesomeIcons.powerOff,
      }
    ];
    
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: skills.map((skill) {
          return Card(
            color: skill['color'],
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 25),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 230,
                  child: Column( 
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: skill['color'],
                          border: Border.all(color: skill['color'], width: 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)
                          )
                        ),
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          skill['title'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: skill['color'], width: 3),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12), 
                            ),
                          ),
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            skill['description'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ), 
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: -20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: skill['color'],
                        shape: BoxShape.circle,
                        border: Border.all(color: skill['color'], width: 2),
                      ),
                      padding: EdgeInsets.all(8),
                      child: FaIcon(skill['icon'], color: Colors.black, size: 24),
                    ),
                  ),
                ),
              ],
            ),
          ); 
        }).toList(), 
      ),
    );
  }
}