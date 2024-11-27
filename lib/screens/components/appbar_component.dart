import 'package:flutter/material.dart';

class SilverAppBarComponent extends StatelessWidget {
  const SilverAppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Color(0xff052555),
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
       background: Container(
        child: Stack(
         children: <Widget>[
           Container(
            margin: EdgeInsets.all(10.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Andrés Angulo',
              style: TextStyle(
                color: Colors.white
                )),
           ),
           Container(
            margin: EdgeInsets.all(10.0),
            alignment:Alignment(-1, 0.15),
            child: Text(
              'Developpeur web fullStack',
              style: TextStyle(
                color: Colors.white
              )),
           ),
           Container(
            alignment: Alignment(1, 0),
            child: Image.asset('assets/portrait.png'),
           )
          ],
        ),
       )
      )
    );
  }
}