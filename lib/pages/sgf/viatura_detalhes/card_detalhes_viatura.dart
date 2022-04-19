import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/pages/perfil/title_card_perfil.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class CardDetalhesViatura extends StatelessWidget {
  final ViaturaDTO viatura;
  final AnimationController animationController;
  final Animation animation;

  const CardDetalhesViatura(
      {Key key,
      @required this.animationController,
      @required this.animation,
      @required this.viatura})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
              opacity: animation,
              child: new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 30 * (1.0 - animation.value), 0.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: SgpolAppTheme.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: SgpolAppTheme.grey,
                          blurRadius: 6,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            viatura.modelo,
                            style: TextStyle(
                                fontFamily: SgpolAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                letterSpacing: -0.1,
                                color: SgpolAppTheme.dark_grey),
                          ),
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              maxRadius: 30.0,
                              onBackgroundImageError: (exception, stackTrace) =>
                                  Icon(Icons.time_to_leave_outlined),
                              backgroundImage: NetworkImage(
                                  'https://sgpol.pm.df.gov.br/img/sgf/${viatura?.marcaSigla}.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: SgpolAppTheme.primaryColorSgpol,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 15),
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: SgpolAppTheme.background,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                        ),
                        bodCard(animationController),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  Widget bodCard(AnimationController animationController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TitleCardPerfil(
          titleTxt: 'Prefixo:',
          subTxt: viatura.prefixo != null ? viatura.prefixo : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        SizedBox(
          height: 10,
        ),
        TitleCardPerfil(
          titleTxt: 'Placa:',
          subTxt: viatura.placa != null ? viatura.placa : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        SizedBox(
          height: 10,
        ),
        TitleCardPerfil(
          titleTxt: 'Placa Vinculada:',
          subTxt: viatura.placaVinculada != null ? viatura.placaVinculada : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        SizedBox(
          height: 10,
        ),
        TitleCardPerfil(
          titleTxt: 'Combustível:',
          subTxt:
              viatura.tipoCombustivel != null ? viatura.tipoCombustivel : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        SizedBox(
          height: 10,
        ),
        TitleCardPerfil(
          titleTxt: 'Lotação:',
          subTxt: viatura.lotacao != null ? viatura.lotacao : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        SizedBox(
          height: 10,
        ),
        TitleCardPerfil(
          titleTxt: 'Tombamento:',
          subTxt: viatura.tombamento != null ? viatura.tombamento : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        SizedBox(
          height: 10,
        ),
        TitleCardPerfil(
          titleTxt: 'Tipo:',
          subTxt: viatura.tipoViatura != null ? viatura.tipoViatura : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        SizedBox(
          height: 10,
        ),
        TitleCardPerfil(
          titleTxt: 'Inclusão:',
          subTxt: viatura.dataInclusao != null ? viatura.dataInclusao : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        SizedBox(
          height: 10,
        ),
        TitleCardPerfil(
          titleTxt: 'Chassi:',
          subTxt: viatura.chassi != null ? viatura.chassi : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        SizedBox(
          height: 10,
        ),
        TitleCardPerfil(
          titleTxt: 'Renavam:',
          subTxt: viatura.renavam != null ? viatura.renavam : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        SizedBox(
          height: 10,
        ),
        TitleCardPerfil(
          titleTxt: 'Odômetro Atual:',
          subTxt: viatura.odometro != null ? viatura.odometro.toString() : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        SizedBox(
          height: 10,
        ),
        TitleCardPerfil(
          titleTxt: 'Odômetro Próxima Revisão:',
          subTxt: viatura.odometroProximaRevisao != null
              ? viatura.odometroProximaRevisao.toString()
              : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        SizedBox(
          height: 10,
        ),
        TitleCardPerfil(
          titleTxt: 'Data da Próxima Revisão:',
          subTxt: viatura.odometroProximaRevisao != null
              ? viatura.odometroProximaRevisao.toString()
              : '',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          animationController: animationController,
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 5),
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: SgpolAppTheme.background,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
        ),
      ],
    );
  }
}
