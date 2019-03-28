import 'package:flutter/material.dart';
import 'package:delightful_animations/src/widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  AnimationController boxController;
  Animation<double> boxAnimation;

  void initState() { 
    super.initState();
    catController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    catAnimation = Tween(begin: -35.0, end: -82.0).animate(
      CurvedAnimation(parent: catController, curve: Curves.easeInOut)
    );

    boxController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(parent: boxController, curve: Curves.ease)
    );
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) boxController.reverse();
      else if (status == AnimationStatus.dismissed) boxController.forward();
    });
    boxController.forward();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap()
            ],
          )
        )
      )
    );
  }

  void onTap () {
    if (catAnimation.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();
    }
    else if (catAnimation.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    }
  }

  Widget buildCatAnimation () {
    return AnimatedBuilder(
      animation: catAnimation,
      child: Cat(),
      builder: (BuildContext context, Widget child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      }
    );
  }

  Widget buildBox () {
    return Container(
      height: 200,
      width: 200,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap () {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10,
          width: 125,
          color: Colors.brown
        ),
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
            child: child,
          );
        },
      )
    );
  }

  Widget buildRightFlap () {
    return Positioned(
      right: 3,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10,
          width: 125,
          color: Colors.brown,
        ),
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
            child: child,
          );
        },
      ),
    );
  }
}