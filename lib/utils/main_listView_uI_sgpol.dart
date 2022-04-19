import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainListViewUI extends StatefulWidget {
  ScrollController scrollController = ScrollController();
  List<Widget> listViews = <Widget>[];
  final AnimationController animationController;
  bool perfil = false;

  MainListViewUI(this.animationController, this.listViews,
      this.scrollController, this.perfil);

  @override
  _MainListViewUIState createState() => _MainListViewUIState();
}

class _MainListViewUIState extends State<MainListViewUI> {
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: widget.scrollController,
            padding: EdgeInsets.only(
              top: widget.perfil
                  ? 5
                  : AppBar().preferredSize.height +
                      MediaQuery.of(context).padding.top +
                      3,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: widget.listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return widget.listViews[index];
            },
          );
        }
      },
    );
  }
}
