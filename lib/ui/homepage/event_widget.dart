import 'package:apppmdfflutter/models/pages.dart';
import 'package:apppmdfflutter/pages/standart_screen.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatefulWidget {
  final Pages page;

  const EventWidget({Key key, this.page}) : super(key: key);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> with TickerProviderStateMixin{
  AnimationController _animationControllerMovement;

  @override
  void initState() {
    _animationControllerMovement = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 880));
    super.initState();
  }

  @override
  void dispose() {
    _animationControllerMovement.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Future<void> _pageTransition(String router) async {
      final duration = Duration(milliseconds: 750);
      _animationControllerMovement.forward();
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: duration,
          reverseTransitionDuration: duration,

          pageBuilder: (context, animation, _) => FadeTransition(
            opacity: animation,
            child: StandartScreen(router: router),
          ),
        ),
      );
      _animationControllerMovement.reverse(from: 1.0);
    }

    return Card(
      shadowColor: SgpolAppTheme.primaryColorSgpol,
      elevation: 8,
      color: SgpolAppTheme.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: SgpolAppTheme.colorGradientSgpolTransparent,
            ),
            child: Stack(
              children: [
                Ink.image(
                  image: AssetImage(
                    widget.page.imagePath,
                  ),
                  child: InkWell(
                    onTap: () {
                      print(widget.page.router);
                      if(widget.page.router != null){
                        print('imprimindo widget.page.router');
                        print(widget.page.router['router']);
                        _pageTransition(widget.page.router['router']);
                      }
                    },
                  ),
                  height: 220,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Text(
                    widget.page.title,
                    style: eventWhiteTitleTextStyle,
                  ),
                ),
              ],
            ),
          ),
          if(widget.page.text != null) Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.page.text,
              style: TextStyle(fontSize: 16, color: SgpolAppTheme.darkText, fontWeight: FontWeight.w300, wordSpacing: 2),
            ),
          )
        ],
      ),
    );
  }
}
