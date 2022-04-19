import 'dart:async';

import 'package:apppmdfflutter/exceptions/AuthException.dart';
import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/pages/sgf/vistoria/vistoria_list.dart';
import 'package:apppmdfflutter/providers/pesquisa_providers.dart';
import 'package:apppmdfflutter/providers/sgf_providers.dart';
import 'package:apppmdfflutter/utils/app_bar_sgpol.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/utils/show_erro_dialog.dart';
import 'package:apppmdfflutter/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VistoriaScreen extends StatefulWidget {
  final AnimationController animationController;
  const VistoriaScreen({Key key, this.animationController}) : super(key: key);

  @override
  _VistoriaScreenState createState() => _VistoriaScreenState();
}

class _VistoriaScreenState extends State<VistoriaScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  bool isSelected = false;
  bool _loadingPesquisaViatura = false;
  double paddingLR = 20;
  double topContainer = 0;
  Timer _debounce;
  String busca;
  List<ViaturaDTO> listViaturaPesquisa = [];

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollListController = ScrollController();
  double topBarOpacity = 0.0;
  SGFProvider _sgf;
  PesquisaProvider _pesquisa;

  void onListen() {
    double value = scrollListController.offset / 119;
    setState(() {
      topContainer = value;
    });

    if (scrollListController.offset >= 24) {
      if (topBarOpacity != 1.0) {
        setState(() {
          topBarOpacity = 1.0;
        });
      }
    } else if (scrollListController.offset <= 24 && scrollListController.offset >= 0) {
      if (topBarOpacity != scrollListController.offset / 24) {
        setState(() {
          topBarOpacity = scrollListController.offset / 24;
        });
      }
    } else if (scrollListController.offset <= 0) {
      if (topBarOpacity != 0.0) {
        setState(() {
          topBarOpacity = 0.0;
        });
      }
    }
    if (scrollListController.offset >= 13) {
      setState(() {
        isSelected = true;
        paddingLR = 0;
      });
    } else if (scrollListController.offset <= 13 && scrollListController.offset >= 0) {
      setState(() {
        isSelected = false;
        paddingLR = 20;
      });
    }
  }


  @override
  void initState() {
    _pesquisa = Provider.of<PesquisaProvider>(context, listen: false);
    _sgf = Provider.of<SGFProvider>(context, listen: false);
    _loadingPesquisaViatura = _sgf.loadingPesquisaViatura;
    scrollListController.addListener(onListen);
    listViews.add(Container());
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: widget.animationController, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    super.initState();
  }

  @override
  void dispose() {
    widget.animationController.dispose();
    _debounce.cancel();
    super.dispose();
  }

  void isLoadingPesquisaViatura(bool loading) {
    setState(() {
      _loadingPesquisaViatura = loading;
    });
  }

  @override
  void didChangeDependencies() {
    _pesquisa = Provider.of<PesquisaProvider>(context, listen: false);
    _sgf = Provider.of<SGFProvider>(context, listen: false);
      isLoadingPesquisaViatura(_sgf.loadingPesquisaViatura);
    _pesquisaDidChange();
    super.didChangeDependencies();
    print('didChangeDependencies do vistoria_screen');
  }

  Future<void> _pesquisaDidChange() async {
    if (_pesquisa.pesquisa != null && _pesquisa.pesquisa.length > 0) {
      await _sgf.pesquisarViatura(_pesquisa.pesquisa);
      isLoadingPesquisaViatura(_sgf.loadingPesquisaViatura);
    }
  }

  void snackBarSgpol() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 10.0,
        backgroundColor: SgpolAppTheme.primaryColorSgpol,
        content: Text(
          'Viatura não encontrada!',
          textAlign: TextAlign.center,
          style: TextStyle(color: SgpolAppTheme.nearlyWhite),
        ),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Fechar',
          textColor: Colors.amber[300],
          onPressed: () {},
        ),
      ),
    );
  }

  void _pesquisaViatura() async {
    isLoadingPesquisaViatura(_sgf.loadingPesquisaViatura);
    var value;
    try{
      value = await _sgf.pesquisarViatura(_pesquisa.pesquisa);
    } on AuthException catch (error) {
      showErrorDialogAuthLogout(error.toString(), context);
    }
    isLoadingPesquisaViatura(_sgf.loadingPesquisaViatura);
    if (!value) {
      snackBarSgpol();
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SgpolAppTheme.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(32.0),
          topLeft: Radius.circular(32.0),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            _loadingPesquisaViatura
                ? Container(
                    child: Center(
                      child: Image.asset('assets/images/ripple.gif'),
                    ),
                  )
                : VistoriaList(
                    scrollListController: scrollListController,
                    listViews: listViews,
                    widget: widget,
                    topContainer: topContainer,
                  ),
            AppBarSgpol(
              widget.animationController,
              topBarAnimation,
              topBarOpacity,
              isSelected,
              'Vistoria',
              'viatura',
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: paddingLR == 0
                      ? AppBar().preferredSize.height +
                          MediaQuery.of(context).padding.top +
                          paddingLR -
                          5
                      : AppBar().preferredSize.height +
                          MediaQuery.of(context).padding.top +
                          paddingLR,
                  left: paddingLR,
                  right: paddingLR,
                  bottom: 0
                ),
                child: SearchBar(_pesquisaViatura, paddingLR),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
