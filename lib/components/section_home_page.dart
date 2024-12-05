import 'package:flutter/material.dart';

class SectionHomePage extends StatelessWidget {
  final GlobalKey sectionKey;
  final String title;
  final Widget child;

  const SectionHomePage({ super.key, required this.sectionKey, required this.title, required this.child });

  @override
  Widget build(BuildContext context) {
    return Column( 
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [ 
        Padding( 
          key: sectionKey, 
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0), 
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: <Widget>[ 
              Text( 
                title, 
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
        child 
      ], 
    );
  }
}