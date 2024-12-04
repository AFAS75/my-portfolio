import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/screens/contact_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';

import 'components/appbar_component.dart';
import 'components/drawer_component.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _technoKey = GlobalKey();

  HomeScreen({super.key});

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: Duration(milliseconds: 500), curve: Curves.linear);
    }
  }
  
  final List<Map<String, String>> projects = [
    { 
      'name': 'App : Mon Portfolio',
      'image': 'assets/my_portfolio.png', 
      'url': 'https://weather-frontend-sage.vercel.app/',
    },
    {
      'name': 'Site : Your Wather',
      'image': 'assets/your_weather.png',
      'url': 'https://weather-frontend-sage.vercel.app/',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0), 
      drawer: DrawerComponent(
        scrollToSection: _scrollToSection,
        aboutKey: _aboutKey,
        projectsKey: _projectsKey,
        skillsKey: _skillsKey,
        technoKey: _technoKey,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.black87,
              Colors.grey[900]!,
              Colors.grey[700]!,
              Colors.grey[500]!,
              Colors.grey[300]!,
            ],
          ),
        ),
        child: _buildBody(context),
      ),
      floatingActionButton: FabCircularMenuPlus(
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
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        AppBarComponent(scrollToAboutSection: () => _scrollToSection(_aboutKey)),
        SliverToBoxAdapter(
          child: ListView(
            controller: _scrollController,
            cacheExtent: 2000,
            shrinkWrap: true,
            children: <Widget>[
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    key: _aboutKey,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'À propos de moi',
                          style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          height: 1.0,
                          width: 340.0,
                          color: Colors.white,
                        )
                      ],
                    )
                  ),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.grey[800],
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 40),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Depuis le début de cette aven-\nture, j\'explore quotidennement\nl\'univers fascinant du déve-\nloppement et du code. Cette\npassion grandissante me pou-\nsse à affiner mes compétences\net à approfondir ma compréhension de ce domaine riche et complexe. Mon parcours en développement web full-stack me permet de transformer des idées innovantes en solutions numériques. Je vous invite à découvrir certains de mes projets.\n\n🔍 Vision: Apporter des solutions technologiques qui font la différence.\n\n🚀 Motivation: L\'innovation constante, guidée par la curiosité et l\'envie de créer.\n\n🌍 Engagement: Collaborer et apprendre pour évoluer dans un monde numérique en perpétuelle mutation.', 
                              style: TextStyle(
                                fontSize: 16, 
                                color: Colors.white,
                                ),
                              ),
                            ],
                          ) 
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor:  Colors.white,
                            child: ClipOval(
                              child: Transform.translate(
                                offset: Offset(25, 2),
                                child: Image.asset(
                                  'assets/profile.png',
                                  width: 180,
                                  fit: BoxFit.cover,
                                ),
                              )
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    key: _projectsKey,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Mes projets',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          height: 1.0,
                          width: 340.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.grey[800],
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 40),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: CarouselSlider(
                          options: CarouselOptions(
                            height: 400.0, 
                            autoPlay: true,
                            enlargeCenterPage: true,
                          ),
                          items: projects.map((project) { 
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () async {
                                    if (!await launchUrl(Uri.parse(project['url']!))) {
                                      throw Exception('Could not launch ${project['url']}');
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                          ),
                                          child: Image.asset(
                                            project['image']!.toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        project['name']!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    key: _skillsKey,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Mes compétences',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          height: 1.0,
                          width: 340.0,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.grey[800],
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 40),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            color: Colors.green,
                            elevation: 5,
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
                                          color: Colors.amber,
                                          border: Border.all(color: Colors.amber, width: 1),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12)
                                          )
                                        ),
                                        width: double.infinity,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Création de sites web sur mesure',
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
                                            border: Border.all(color: Colors.amber, width: 3),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                              bottomRight: Radius.circular(12), 
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Conception de sites web personnalisés, tenant compte de vos exigences et utilisant les dernières technologies et tendances de design.',
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
                                        color: Colors.amber,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.amber, width: 2),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: FaIcon(FontAwesomeIcons.computer, color: Colors.black, size: 24),
                                    ),
                                  )
                                ),
                              ],
                            ),
                          ), 
                          Card(
                            color: Colors.green,
                            elevation: 5,
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
                                          color: Colors.green,
                                          border: Border.all(color: Colors.green, width: 1),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12)
                                          )
                                        ),
                                        width: double.infinity,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Développement d\'applications web',
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
                                            border: Border.all(color: Colors.green, width: 3),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                              bottomRight: Radius.circular(12), 
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Création d\'applications web interactives et performantes, améliorant l\'expérience utilisateur et répondant à des besoins spécifiques..',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            )
                                          ),
                                        ),       
                                      ),
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
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.green, width: 2),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: FaIcon(FontAwesomeIcons.mobile, color: Colors.black, size: 28),
                                    ),
                                  )
                                ),
                              ],
                            ),
                          ),
                          Card(
                            color: Colors.blue,
                            elevation: 5,
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
                                          color: Colors.blue,
                                          border: Border.all(color: Colors.blue, width: 1),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12)
                                          )
                                        ),
                                        width: double.infinity,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Optimisation pour les moteurs de recherche (SEO)',
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
                                            border: Border.all(color: Colors.blue, width: 3),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                              bottomRight: Radius.circular(12), 
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Amélioration de la visibilité en ligne par l\'optimisation du site web pour les moteurs de recherche',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            )
                                          ),
                                        ),
                                      ),
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
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.blue, width: 2),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: FaIcon(FontAwesomeIcons.magnifyingGlass, color: Colors.black, size: 24),
                                    ),
                                  )
                                ),
                              ],
                            ),
                          ),
                          Card(
                            color: Colors.pink,
                            elevation: 5,
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
                                          color: Colors.pink,
                                          border: Border.all(color: Colors.pink, width: 1),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12)
                                          )
                                        ),
                                        width: double.infinity,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Hébergement & Déploiement',
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
                                            border: Border.all(color: Colors.pink, width: 3),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                              bottomRight: Radius.circular(12), 
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Déploiement des solutions sur les plateformes adaptées à vos besoins, simplifiant les interactions avec les prestataires de services.',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            )
                                          ),
                                        ),
                                      ),
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
                                        color: Colors.pink,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.pink, width: 2),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: FaIcon(FontAwesomeIcons.powerOff, color: Colors.black, size: 24),
                                    ),
                                  )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    key: _technoKey,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Technologies',
                          style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          height: 1.0,
                          width: 340.0,
                          color: Colors.white,
                        )
                      ],
                    )
                  ),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.grey[800],
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 40),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.only(
                              left: 5,
                              top: 5,
                              right: 5,
                              bottom: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 20.0,
                                      runSpacing: 20.0,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            FaIcon(FontAwesomeIcons.react, size: 40, color: Colors.blue),
                                            SizedBox(height: 6),
                                            Text(
                                              'React',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            FaIcon(FontAwesomeIcons.squareJs, size: 40, color: Colors.yellow),
                                            SizedBox(height: 6),
                                            Text(
                                              'JS',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            FaIcon(FontAwesomeIcons.flutter, size: 40, color: Colors.blue[900]),
                                            SizedBox(height: 6),
                                            Text(
                                              'Flutter',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            FaIcon(FontAwesomeIcons.html5, size: 40, color: Colors.orange[900]),
                                            SizedBox(height: 6),
                                            Text(
                                              'HTML 5',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            FaIcon(FontAwesomeIcons.css3Alt, size: 40, color: Colors.blue[900]),
                                            SizedBox(height: 6),
                                            Text(
                                              'CSS 3',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  width: double.infinity,
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'FRONTEND',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                            color: Colors.grey,
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
                                      children: const <Widget>[
                                        Column(
                                          children: [
                                            FaIcon(FontAwesomeIcons.node, size: 40, color: Colors.green),
                                            SizedBox(height: 6),
                                            Text(
                                              'Node',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            FaIcon(FontAwesomeIcons.database, size: 40, color: Colors.white),
                                            SizedBox(height: 6),
                                            Text(
                                              'MongoDB',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white, width: 1),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  width: double.infinity,
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'BACKEND',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                            color: Colors.grey,
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
                                      children: const <Widget>[
                                        Column(
                                          children: [
                                            FaIcon(FontAwesomeIcons.github, size: 40, color: Colors.black),
                                            SizedBox(height: 6),
                                            Text(
                                              'GitHub',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white, width: 1),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  width: double.infinity,
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'AUTRES',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),              
                ],
              ),
            ],
          )
        )
      ],
    );
  }
}
