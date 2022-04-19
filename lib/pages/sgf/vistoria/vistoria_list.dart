import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/pages/sgf/vistoria/vistoria_screen.dart';
import 'package:apppmdfflutter/providers/sgf_providers.dart';
import 'package:apppmdfflutter/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'card_aviso_pesquisa.dart';
import 'card_vistoria_viatura.dart';

const itemSize = 150.0;

class VistoriaList extends StatelessWidget {
  final ScrollController scrollListController;
  final List<Widget> listViews;
  final VistoriaScreen widget;
  final double topContainer;

  const VistoriaList({Key key, this.scrollListController, this.listViews, this.widget, this.topContainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final sgf = Provider.of<SGFProvider>(context);
    final _pesquisaViaturas = sgf.listViaturaPesquisa;

    return ListView.builder(
      controller: scrollListController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 70,
        bottom: 30 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: _pesquisaViaturas.length == 0 ? listViews.length : _pesquisaViaturas.length,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ChangeNotifierProvider(
          create: (_) => sgf,
          child: cardAvisoOuCardPesquisa(index, _pesquisaViaturas),
        );
      },
    );
  }

  Widget cardAvisoOuCardPesquisa(int index, List<ViaturaDTO> _pesquisaViaturas) {
    widget.animationController.forward();
    double scale = 1.0;
    if (topContainer > 0.5) {
      scale = index + 0.5 - topContainer;
    }
    if (scale < 0) {
      scale = 0;
    } else if (scale > 1) {
      scale = 1;
    }
    return _pesquisaViaturas.length == 0
        ? CardAvisoPesquisa(
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve: Interval((0.3) * 2, 1.0, curve: Curves.fastOutSlowIn),
              ),
            ),
            animationController: widget.animationController,
          )
        : Opacity(
            opacity: scale,
            child: Transform(
              transform: Matrix4.identity()..scale(scale, scale),
              alignment: Alignment.bottomCenter,
              child: Align(
                heightFactor: 0.7,
                alignment: Alignment.topCenter,
                child: CardVistoriaViatura(
                  animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: widget.animationController,
                      curve: Interval((1 / 5) + 0.5, 1.0, curve: Curves.fastOutSlowIn),
                    ),
                  ),
                  router: AppRoutes.VISTORIA,
                  viatura: _pesquisaViaturas[index],
                  animationController: widget.animationController,
                ),
              ),
            ),
          );
  }
}