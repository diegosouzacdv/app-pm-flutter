import 'package:apppmdfflutter/models/Card3D.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_uso/3D_cards_details.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_uso/card_viatura_uso.dart';
import 'package:flutter/material.dart';

const itemSize = 150.0;

class ViaturaUsoList extends StatelessWidget {
  final ScrollController scrollListController;
  final AnimationController animationController;
  final double topContainer;

  const ViaturaUsoList({
    Key key,
    @required this.scrollListController,
    @required this.animationController,
    this.topContainer,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollListController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 70,
        bottom: 30 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: cardList.length,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        animationController.forward();
        double scale = 1.0;
        if (topContainer > 0.5) {
          scale = index + 0.5 - topContainer;
        }
        if (scale < 0) {
          scale = 0;
        } else if (scale > 1) {
          scale = 1;
        }
        return Opacity(
          opacity: scale,
          child: Transform(
            transform: Matrix4.identity()..scale(scale, scale),
            alignment: Alignment.bottomCenter,
            child: Align(
              heightFactor: 0.7,
              alignment: Alignment.topCenter,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: CardBody(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CardBody extends StatefulWidget {
  const CardBody({Key key}) : super(key: key);

  @override
  _CardBodyState createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> with TickerProviderStateMixin {
  bool _selectedMode = false;
  AnimationController _animationControllerSelection;
  AnimationController _animationControllerMovement;
  int _selectedIndex;

  Future<void> _onCardSelected(Card3D card, int index) async {
    setState(() {
      _selectedIndex = index;
    });
    final duration = Duration(milliseconds: 750);
    _animationControllerMovement.forward();
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        pageBuilder: (context, animation, _) => FadeTransition(
          opacity: animation,
          child: CardsDetails(
            card: card,
          ),
        ),
      ),
    );
    _animationControllerMovement.reverse(from: 1.0);
  }

  int _getCurrentFactor(int currentIndex) {
    if (_selectedIndex == null || currentIndex == _selectedIndex) {
      return 0;
    } else if (currentIndex > _selectedIndex) {
      return -1;
    } else {
      return 1;
    }
  }

  @override
  void initState() {
    _animationControllerSelection = AnimationController(
      vsync: this,
      lowerBound: 0.15,
      upperBound: 0.5,
      duration: const Duration(milliseconds: 500),
    );
    _animationControllerMovement = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 880),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationControllerSelection.dispose();
    _animationControllerMovement.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
            animation: _animationControllerSelection,
            builder: (context, snapshot) {
              final selectionValue = _animationControllerSelection.value;
              return GestureDetector(
                onTap: () {
                  if (!_selectedMode) {
                    _animationControllerSelection.forward().whenComplete(() {
                      setState(() {
                        _selectedMode = true;
                      });
                    });
                  } else {
                    _animationControllerSelection.reverse().whenComplete(() {
                      setState(() {
                        _selectedMode = false;
                      });
                    });
                  }
                },
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(selectionValue),
                  child: AbsorbPointer(
                    absorbing: !_selectedMode,
                    child: Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth * 0.45,
                      color: Colors.white,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: List.generate(
                          4,
                          (index) => CardItemViatura(
                            height: constraints.maxHeight / 2,
                            card: cardList[index],
                            percent: selectionValue,
                            depth: index,
                            verticalFactor: _getCurrentFactor(index),
                            animation: _animationControllerMovement,
                            onCardSelected: (card) {
                              _onCardSelected(card, index);
                            },
                          ),
                        ).reversed.toList(),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
