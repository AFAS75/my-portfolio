import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';


class ProjectsCard extends StatelessWidget {

  ProjectsCard({ super.key });

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
    return Card(
      elevation: 10,
      margin: EdgeInsets.only(bottom: 40),
      shape: LinearBorder(side: BorderSide.none),
      color: Color.fromARGB(150, 255, 255, 255),
      child: Padding(
        padding: EdgeInsets.all(10),
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
                        child: Image.asset(
                          project['image']!.toString(),
                          fit: BoxFit.cover,
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
      ) 
    );
  }
}