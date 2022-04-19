
import 'package:apppmdfflutter/models/vistoria_viatura_itens_vistoria.dart';
import 'package:apppmdfflutter/pages/sgf/viatura_vistoria/itens_screen.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class ItensAlteracoes extends StatelessWidget {

  final List<VistoriaViaturaItensVistoria> itens;

  const ItensAlteracoes({
    Key key,
    @required this.context, this.itens, 
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FractionallySizedBox(
          alignment: Alignment.topLeft,
          heightFactor: 1.3,
          child: Container(
            color: SgpolAppTheme.background,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Selecione itens com alteração',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: SgpolAppTheme.dark_grey),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: SgpolAppTheme.primaryColorSgpol,
                      highlightColor: SgpolAppTheme.primaryColorSgpol,
                      hoverColor: SgpolAppTheme.primaryColorSgpol,
                      splashColor: SgpolAppTheme.primaryColorSgpol,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => ItensScreen(itensVistoria: itens),
                              fullscreenDialog: true),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Itens',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: SgpolAppTheme.dark_grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.sort,
                                  color: SgpolAppTheme.dark_grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }
}