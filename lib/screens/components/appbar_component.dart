import 'package:flutter/material.dart';
// import 'package:particles_flutter/particles_engine.dart';

class SliverAppBarComponent extends StatefulWidget {
  final VoidCallback scrollToAboutSection;

  const SliverAppBarComponent({super.key, required this.scrollToAboutSection});

  @override
  _SliverAppBarComponentState createState() => _SliverAppBarComponentState();
}
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       pinned: true,
//       backgroundColor: Color(0xff052555),
//       expandedHeight: 200.0,
//       iconTheme: IconThemeData(color: Colors.white),
//       flexibleSpace: FlexibleSpaceBar(
//        background: Container(
//         child: Stack(
//          children: <Widget>[
//            Container(
//             margin: EdgeInsets.all(10.0),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Andrés Angulo',
//               style: TextStyle(
//                 color: Colors.white
//                 )),
//            ),
//            Container(
//             margin: EdgeInsets.all(10.0),
//             alignment:Alignment(-1, 0.15),
//             child: Text(
//               'Developpeur web fullStack',
//               style: TextStyle(
//                 color: Colors.white
//               )),
//            ),
//            Container(
//             alignment: Alignment(1, 0),
//             child: Image.asset('assets/portrait.png'),
//            )
//           ],
//         ),
//        )
//       )
//     );
//   }
class _SliverAppBarComponentState extends State<SliverAppBarComponent> with TickerProviderStateMixin {
  late AnimationController _controllerButton;
  late Animation<double> _animationButton;
  late AnimationController _fadeControllerButton;
  late Animation<double> _fadeAnimationButton;
  late AnimationController _textController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  late AnimationController _controllerBackground;
  late Animation<Offset> _slideAnimationBackground;
  late Animation<double> _fadeAnimationBackground;
  late List<Animation<double>> _fadeAnimations;
  late List<AnimationController> _letterControllers;
  late List<Animation<double>> _letterAnimations;
  late List<AnimationController> _lightControllers;
  // late List<Animation<double>> _lightAnimations;

  final String name = 'WELCOME';

  @override
  void initState() {
    super.initState();
    _controllerButton = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);
    _animationButton = CurvedAnimation(
      parent: _controllerButton, 
      curve: Curves.easeInCubic,
    );

    _fadeControllerButton = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimationButton = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeControllerButton, 
      curve: Curves.easeInOut,
    ));

    _fadeControllerButton.forward();

    _lightControllers = List.generate(3, (index) {
      return AnimationController(
        duration: Duration(microseconds: 800 + index * 100),
        vsync: this,
      )..repeat(reverse: true);
    });

    // _lightAnimations = _lightControllers.map((controller) {
    //   return CurvedAnimation(
    //     parent: controller,
    //     curve: Curves.easeInOut,
    //   );
    // }).toList();

    _textController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    ); 
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController, 
      curve: Curves.easeInOut
    ));
      _fadeAnimation = Tween<double>(
      begin: 0.1,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController, 
      curve: Curves.easeInOut
    ));

    _textController.forward();

    _letterControllers = List.generate(name.length, (index) {
      return AnimationController(
        duration: Duration(milliseconds: 2000 + index * 100),
        vsync: this,
      );
    });

    _letterAnimations = _letterControllers.map((controller) {
      return Tween<double>(begin: 3.0, end: 1.0).animate(CurvedAnimation(
        parent: controller, 
        curve: Curves.easeInOut,
      ));
    }).toList();

    _fadeAnimations = _letterControllers.map((controller) {
      return Tween<double>(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: controller, 
        curve: Curves.easeInOut,
      ));
    }).toList();

    for (var controller in _letterControllers) {
      controller.forward();
    }

    _controllerBackground = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _slideAnimationBackground = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controllerBackground, 
      curve: Curves.easeInOut
    ));
    _fadeAnimationBackground = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controllerBackground, 
      curve: Curves.easeInOut
    ));

    _controllerBackground.forward();
  }

  @override
  void dispose() {
    _controllerButton.dispose();
    _fadeControllerButton.dispose();
    _textController.dispose();
    for (var controller in _lightControllers) {
      controller.dispose();
    }
    for (var controller in _letterControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Offset _getOffsetForLetter(int index, int totalLetters) {
    if (index == 0) {
      return Offset(-5.0, 0.0);
    } else if (index == totalLetters - 1) {
      return Offset(5.0, 0.0);
    } else {
      return index % 2 == 0 ? Offset(0.0, -5.0) : Offset(0.0, 5.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    String backgroundImage = screenSize.width < 780 ? 'assets/test4.png' : 'assets/test1.png';
    return SliverAppBar(
      pinned: true,
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      expandedHeight: MediaQuery.of(context).size.height,
      iconTheme: IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            SlideTransition(
              position: _slideAnimationBackground,
              child: FadeTransition(
                opacity: _fadeAnimationBackground,
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height:double.infinity,
                ),
              ),  
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    // width: MediaQuery.of(context).size.width,
                    top: MediaQuery.of(context).size.height / 2 - 12,
                    // left: 20,
                    child: Row(
                      children: List.generate(name.length, (index) {
                        return FadeTransition(
                          opacity: _fadeAnimations[index],
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: _getOffsetForLetter(index, name.length),
                              // begin: Offset(0.0, 1.0),
                              end: Offset.zero, 
                            ).animate(_letterAnimations[index]),
                            child: Text(
                              name[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ); 
                      }),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: MediaQuery.of(context).size.height / 2 + 12,
                    // width: MediaQuery.of(context).size.width,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _offsetAnimation,
                        child: 
                        Text(
                          'Bienvenido',
                          style: TextStyle(
                            color: Colors.white
                          )),
                        ),
                      )
                  ),
                  // Container(
                  //   margin: EdgeInsets.all(10.0),
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     'Andrés Angulo',
                  //     style: TextStyle(
                  //       color: Colors.white
                  //     )),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.all(10.0),
                  //   alignment:Alignment(-1, 0.15),
                  //   child: Text(
                  //     'Developpeur web fullStack',
                  //     style: TextStyle(
                  //       color: Colors.white
                  //     )),
                  // ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: MediaQuery.of(context).size.height,
                  //   alignment: Alignment(1, 1),
                  //   child: Image.asset('assets/test1.png'),
                  // ),
                  Positioned(
                    bottom: 90,
                    left: MediaQuery.of(context).size.width / 2 - 100,
                    child: Stack(
                      children: [
                        // for (int i = 0; i < _lightAnimations.length; i++)
                        //   Positioned(
                        //     left: -20 + i * 20.0,
                        //     child: AnimatedBuilder(
                        //       animation: _lightAnimations[i], 
                        //       builder: (context, child) {
                        //         return Transform.scale(
                        //           scale: _lightAnimations[i].value,
                        //           child: Container(
                        //             width: 10,
                        //             height: 10,
                        //             decoration: BoxDecoration(
                        //               shape: BoxShape.rectangle,
                        //               color: Colors.white,
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ),
                        AnimatedBuilder(
                          animation: _animationButton, 
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _animationButton.value * 20),
                              child: AnimatedBuilder(
                                animation: _fadeAnimationButton, 
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: _fadeAnimationButton.value,
                                    child: Container(
                                      width: 200,
                                      height: 25,
                                      child: MaterialButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      onPressed: widget.scrollToAboutSection,
                                      child: Icon(
                                        Icons.keyboard_arrow_down, 
                                        size: 32,
                                        color: Colors.black
                                        ),
                                      ),
                                    ), 
                                  ); 
                                },
                              ),
                            );
                          }, 
                        ),
                      ],
                    ),           
                  ),
                ],
              ), 
            ),
          ],
        ),
      ),
    );
  }
}
