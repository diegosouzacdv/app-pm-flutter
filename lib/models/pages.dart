import 'package:apppmdfflutter/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';

class Pages {
  final String imagePath, title, text;
  final List menusIds;
  final Map<String, Object> router;
  bool permissions = true;

  Pages({
    this.imagePath,
    this.title,
    this.text,
    this.menusIds,
    this.router,
    this.permissions,
  });




  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Pages(imagePath: $imagePath, title: $title, text: $text, menusIds: $menusIds, router: $router, permissions: $permissions)';
  }
}

const _path = 'assets/event_images';
final mensagensLidas = Pages(
  imagePath: "$_path/new_mensagem1.png",
  title: "Caixa de Entrada",
  text: "Todas Mensagens lidas",
  menusIds: [0, 4],
  router: null,
  permissions: true,
);



final viaturasUso = Pages(
  imagePath: "$_path/viatura-uso.jpeg",
  title: "Viaturas em Uso",
  text: "Nenhuma Viatura Cautelada",
  menusIds: [0, 1],
  router: {
    'router': AppRoutes.VIATURA_USO,
    'arguments': null,
  },
  permissions: true,
);

final viaturas = Pages(
  imagePath: "$_path/viatura-unidade.jpg",
  title: "Viaturas Unidade",
  text: null,
  menusIds: [1],
  router: {
    'router': AppRoutes.VIATURA_UNIDADE,
    'arguments': null,
  },
  permissions: true,
);

final vistoria = Pages(
  imagePath: "$_path/viatura-vistoria.jpeg",
  title: "Vistoriar Viaturas",
  text: null,
  menusIds: [1],
  router: {
    'router': AppRoutes.VIATURA_VISTORIA,
    'arguments': null,
  },
  permissions: false,
);

final cadastroBens = Pages(
  imagePath: "$_path/cadastro-bens.png",
  title: "Cadastro de Bens",
  text: null,
  menusIds: [2],
  permissions: true,
);

final conferenciaBens = Pages(
  imagePath: "$_path/conferencia.png",
  title: "Conferência de Bens",
  text: null,
  menusIds: [2],
  permissions: true,
);

final saude = Pages(
  imagePath: "$_path/saude.png",
  title: "Saúde",
  text: null,
  menusIds: [3],
  permissions: true,
);
final administrador = Pages(
  imagePath: "$_path/admin.png",
  title: "Administrador",
  text: null,
  menusIds: [5],
  permissions: true,
);

final pages = [
  mensagensLidas,
  viaturasUso,
  viaturas,
  vistoria,
  cadastroBens,
  conferenciaBens,
  saude,
  administrador
];


