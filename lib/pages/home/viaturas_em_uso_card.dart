import 'dart:convert';

import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViaturasEmUsoCard extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ViaturasEmUsoCard({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ViaturasEmUsoCardState createState() => _ViaturasEmUsoCardState();
}

class _ViaturasEmUsoCardState extends State<ViaturasEmUsoCard> {
  Future<List<User>> _getUsers() async {
    var data = await http
        .get(Uri.parse('http://www.json-generator.com/api/json/get/cgySrEFzpK?indent=2'));

    var jsonData = json.decode(data.body);

    List<User> users = [];

    for (var u in jsonData) {
      User user =
          User(u["index"], u["about"], u["name"], u["email"], u["picture"]);

      users.add(user);
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    final double _borderRadius = 24;
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.animation.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_borderRadius),
                      gradient: LinearGradient(
                        colors: [
                          SgpolAppTheme.white,
                          SgpolAppTheme.background,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: SgpolAppTheme.grey,
                          blurRadius: 6,
                          offset: Offset(0, 6),
                        )
                      ],
                    ),
                  ),
                  Positioned.fill(
                    left: 10,
                    right: 10,
                    child: Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 13, right: 5),
                        child: Container(
                          child: FutureBuilder(
                              future: _getUsers(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Container(
                                    child: Center(
                                      child: Text(
                                        'Loading...',
                                        style: TextStyle(
                                            color: SgpolAppTheme
                                                .primaryColorSgpol),
                                      ),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(
                                            snapshot.data[index].name,
                                            style: TextStyle(
                                                color: SgpolAppTheme
                                                    .primaryColorSgpol),
                                          ),
                                        );
                                      });
                                }
                              }),
                        )),
                  )
                ]),
              )),
        );
      },
    );
  }
}

class User {
  final int index;
  final String about;
  final String name;
  final String email;
  final String picture;

  User(this.index, this.about, this.name, this.email, this.picture);
}
