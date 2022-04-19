import 'package:apppmdfflutter/pages/auth_update_screen.dart';
import 'package:apppmdfflutter/pages/login/login_page.dart';
import 'package:apppmdfflutter/pages/standart_screen.dart';
import 'package:apppmdfflutter/providers/auth_providers.dart';
import 'package:apppmdfflutter/providers/pesquisa_providers.dart';
import 'package:apppmdfflutter/providers/policial_providers.dart';
import 'package:apppmdfflutter/providers/sgf_providers.dart';
import 'package:apppmdfflutter/utils/app_routes.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

import './utils/sgpol_app_theme.dart';
import 'ui/homepage/home_page.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  FlutterDownloader.initialize(debug: true // optional: set false to disable printing logs to console
      );

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // cor da barra superior
    statusBarIconBrightness: Brightness.light, // ícones da barra superior
    systemNavigationBarColor: SgpolAppTheme.primaryColorSgpol, // c// cor da barra inferior
    systemNavigationBarIconBrightness: Brightness.light, // nes da barra inferior
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => new AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, PolicialProvider>(
          create: (_) => new PolicialProvider(),
          update: (ctx, auth, previousPoliciais) => new PolicialProvider(
            previousPoliciais.policial,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, SGFProvider>(
          create: (_) => new SGFProvider(),
          update: (ctx, auth, previousViaturas) => new SGFProvider(),
        ),
        ChangeNotifierProvider<PesquisaProvider>(
          create: (_) => new PesquisaProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sgpol PMDF',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFFFFFFF),
          primaryColor: SgpolAppTheme.primaryColorSgpol,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
          accentColor: Colors.cyan[50],
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.dark().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: SgpolAppTheme.darkText,
                  ),
                  button: TextStyle(
                    color: SgpolAppTheme.darkText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ),
        routes: {
          AppRoutes.AUTH_HOME: (ctx) => AuthOrUpdateScreen(),
          AppRoutes.LOGIN: (ctx) => LoginPage(),
          AppRoutes.HOME: (ctx) => HomePage(),
          AppRoutes.STANDART_SCREEN: (ctx) => StandartScreen(),
        },
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
