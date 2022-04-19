import 'package:apppmdfflutter/pages/perfil/card_perfil.dart';
import 'package:apppmdfflutter/pages/perfil/foto_perfil.dart';
import 'package:apppmdfflutter/pages/perfil/nome_perfil.dart';
import 'package:apppmdfflutter/utils/main_listView_uI_sgpol.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<PerfilScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  bool isSelected = false;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );
    addAllListData();

    super.initState();
  }

  void addAllListData() {
    const int count = 7;
    listViews.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: CardPerfil(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: widget.animationController,
              curve:
                  Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: widget.animationController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SgpolAppTheme.white,
      ),
      child: Scaffold(
        appBar: AppbarPerfil(widget.animationController),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            MainListViewUI(
                widget.animationController, listViews, scrollController, true),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}

class AppbarPerfil extends StatelessWidget with PreferredSizeWidget {
  const AppbarPerfil(this.animationController);
  final AnimationController animationController;
  final String url =
      "https://www.fatosdesconhecidos.com.br/wp-content/uploads/2020/01/images-600x377.png";

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        decoration: BoxDecoration(
          color: SgpolAppTheme.primaryColorSgpol,
          boxShadow: [
            BoxShadow(
                color: SgpolAppTheme.primaryColorSgpol,
                offset: Offset(1.1, 1.1),
                blurRadius: 9.0),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    FotoPerfil(
                      url: url,
                      animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / 9) * 4, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      ),
                      animationController: animationController,
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    NomePerfil(
                      nome: '3º SGT Wallace',
                      animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / 9) * 5, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      ),
                      animationController: animationController,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 180);
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(0, size.height - 70);
    p.lineTo(size.width, size.height);
    p.lineTo(size.width, -10);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
