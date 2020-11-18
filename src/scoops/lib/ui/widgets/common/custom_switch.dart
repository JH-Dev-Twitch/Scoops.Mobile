import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:scoops/ui/styling/custom_icons_icons.dart';

class AnimatedIconSwitch extends StatefulWidget {
  @required
  final bool value;
  @required
  final Function(bool) onChanged;
  final String textOff;
  final String textOn;
  final Color colorOn;
  final Color colorOff;
  final double textSize;
  final Duration animationDuration;
  final IconData iconOn;
  final IconData iconOff;
  final Function onTap;
  final Function onDoubleTap;
  final Function onSwipe;

  AnimatedIconSwitch(
      {this.value = false,
      this.textOff = "Off",
      this.textOn = "On",
      this.textSize = 14.0,
      this.colorOn = Colors.green,
      this.colorOff = Colors.red,
      this.iconOff = CustomIcons.moon_inv,
      this.iconOn = CustomIcons.light_up,
      this.animationDuration = const Duration(milliseconds: 600),
      this.onTap,
      this.onDoubleTap,
      this.onSwipe,
      this.onChanged});

  @override
  _RollingSwitchState createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<AnimatedIconSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  double value = 0.0;

  bool turnState;
  double height = 20;
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;
    _determine();
  }

  @override
  Widget build(BuildContext context) {
    Color transitionColor = Color.lerp(widget.colorOff, widget.colorOn, value);

    return GestureDetector(
      onDoubleTap: () {
        _action();
        if (widget.onDoubleTap != null) widget.onDoubleTap();
      },
      onTap: () {
        _action();
        if (widget.onTap != null) widget.onTap();
      },
      onPanEnd: (details) {
        _action();
        if (widget.onSwipe != null) widget.onSwipe();
        //widget.onSwipe();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        width: 90,
        decoration: BoxDecoration(
            color: transitionColor, borderRadius: BorderRadius.circular(50)),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(10 * value, 0), //original
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 1.0),
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.topRight,
                  height: height,
                  child: Text(
                    widget.textOff,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.textSize),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(10 * (1 - value), 0), //original
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Container(
                  padding: EdgeInsets.only(/*top: 10,*/ left: 5),
                  alignment: Alignment.topLeft,
                  height: height,
                  child: Text(
                    widget.textOn,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.textSize),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(60 * value, 0),
              child: Transform.rotate(
                angle: lerpDouble(0, 2 * pi, value),
                child: Container(
                  height: height,
                  width: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Opacity(
                          opacity: (1 - value).clamp(0.0, 1.0),
                          child: Icon(
                            widget.iconOff,
                            size: 20,
                            color: transitionColor,
                          ),
                        ),
                      ),
                      Center(
                          child: Opacity(
                              opacity: value.clamp(0.0, 1.0),
                              child: Icon(
                                widget.iconOn,
                                size: 20,
                                color: transitionColor,
                              ))),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();

      widget.onChanged(turnState);
    });
  }
}
