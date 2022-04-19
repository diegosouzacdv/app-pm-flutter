import 'package:apppmdfflutter/pages/perfil/title_card_contatos.dart';
import 'package:apppmdfflutter/pages/perfil/title_card_perfil.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class CardPerfil extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const CardPerfil({Key key, this.animationController, this.animation})
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
              padding: const EdgeInsets.all(5.0),
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
                        'Ficha de Cadastro',
                        style: TextStyle(
                            fontFamily: SgpolAppTheme.fontName,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            letterSpacing: -0.1,
                            color: SgpolAppTheme.dark_grey),
                      ),
                      leading: Icon(
                        Icons.person_outline,
                        color: SgpolAppTheme.dark_grey,
                        size: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: SgpolAppTheme.primaryColorSgpol,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            )),
                      ),
                    ),
                    bodCard(animationController),
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

Widget bodCard(AnimationController animationController) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      TitleCardPerfil(
        titleTxt: 'Nome:',
        subTxt: 'Wallace Silva',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: animationController,
      ),
      SizedBox(
        height: 5,
      ),
      TitleCardPerfil(
        titleTxt: 'Matrícula:',
        subTxt: '0123456789',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: animationController,
      ),
      SizedBox(
        height: 5,
      ),
      TitleCardPerfil(
        titleTxt: 'Situação do Policial:',
        subTxt: 'Classificado',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: animationController,
      ),
      SizedBox(
        height: 5,
      ),
      TitleCardPerfil(
        titleTxt: 'Porte de Arma:',
        subTxt: 'Ativo',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: animationController,
      ),
      SizedBox(
        height: 5,
      ),
      TitleCardPerfil(
        titleTxt: 'Data de Admissão:',
        subTxt: '20/09/2010',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: animationController,
      ),
      SizedBox(
        height: 5,
      ),
      TitleCardPerfil(
        titleTxt: 'CNH:',
        subTxt: 'B',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: animationController,
      ),
      SizedBox(
        height: 5,
      ),
      TitleCardPerfil(
        titleTxt: 'Validade:',
        subTxt: '20/12/2021',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: animationController,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 5),
        child: Container(
          height: 2,
          decoration: BoxDecoration(
            color: SgpolAppTheme.background,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
      ListTile(
        title: Text(
          'Contato',
          style: TextStyle(
              fontFamily: SgpolAppTheme.fontName,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: -0.1,
              color: SgpolAppTheme.dark_grey),
        ),
        leading: Icon(
          Icons.add_call,
          color: SgpolAppTheme.dark_grey,
          size: 20,
        ),
      ),
      TitleCardContatos(
        titleTxt: 'Email:',
        subTxt: 'wallace.silva@gmail.com',
        icon: Icons.mail_outline,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: animationController,
      ),
      SizedBox(
        height: 5,
      ),
      TitleCardContatos(
        titleTxt: 'Telefones:',
        subTxt: '(61)98569-7836)',
        icon: Icons.phone_android,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / 9) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: animationController,
      ),
      SizedBox(
        height: 5,
      ),
      TitleCardContatos(
        titleTxt: 'Endereço:',
        subTxt:
            'Quadra QR 205 Conjunto C 25 - Santa Maria - Distrito Federal / DF',
        icon: Icons.gps_fixed,
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
    ],
  );
}
