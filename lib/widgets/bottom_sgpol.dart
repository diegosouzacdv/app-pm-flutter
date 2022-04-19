import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class ButtonSgpol extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;
  final String action;
  final String label;
  final Color color1;
  final Color color2;
  final IconData icon;
  final Function(bool, String) clickButton;

  const ButtonSgpol({
    Key key,
    this.animationController,
    this.animation,
    @required this.action,
    @required this.label,
    @required this.color1,
    @required this.color2,
    @required this.icon,
    @required this.clickButton,
  }) : super(key: key);

  responseClick(bool value) {
    clickButton(value, action);
  }

  @override
  _ButtonSgpolState createState() => _ButtonSgpolState();
}

class _ButtonSgpolState extends State<ButtonSgpol> {
  double width = 105.0;
  double topRight = 0;
  double topLeft = 120;
  double bottomLeft = 120;
  double bottomRight = 300;
  var click = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(5.0, 20.0),
              color: SgpolAppTheme.primaryColorSgpol.withOpacity(0.4),
              blurRadius: 30.0,
            ),
          ]),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              click = !click;

              setState(() {
                if (click) {
                  width = 150;
                  topRight = 20;
                  topLeft = 20;
                  bottomLeft = 20;
                  bottomRight = 20;
                } else {
                  width = 105.0;
                  topRight = 0;
                  topLeft = 120;
                  bottomLeft = 120;
                  bottomRight = 300;
                }
              });
              widget.responseClick(true);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              height: 50,
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.color1,
                    widget.color2,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(topLeft),
                  bottomLeft: Radius.circular(bottomLeft),
                  topRight: Radius.circular(topRight),
                  bottomRight: Radius.circular(bottomRight),
                ),
              ),
              child: Center(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 0.1,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                widget.icon,
                color: widget.color1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
