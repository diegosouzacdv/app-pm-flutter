import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:apppmdfflutter/models/versao.dart';
import 'package:apppmdfflutter/pages/presentation_screen.dart';
import 'package:apppmdfflutter/providers/auth_providers.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/alert_dialog_sgpol.dart';
import 'package:apppmdfflutter/widgets/botao_outline_sgpol.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class UpdateApp extends StatefulWidget {
  final Versao versao;

  const UpdateApp({Key key, this.versao}) : super(key: key);

  @override
  _UpdateAppState createState() => _UpdateAppState();
}

class _UpdateAppState extends State<UpdateApp> with TickerProviderStateMixin {
  ReceivePort _port = ReceivePort();
  int progress = 0;
  String id = '';

  DownloadTaskStatus status = DownloadTaskStatus(0);
  AnimationController _animationController;
  var _colorTween;

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {
        this.status = status;
        this.progress = progress;
        this.id = id;

      });
      if(status == DownloadTaskStatus(3) ) {
        Timer(Duration(seconds: 3), () => openFile());
      }
    });

    _animationController = AnimationController(duration: const Duration(milliseconds: 3000), vsync: this);
    _colorTween = _animationController.drive(ColorTween(begin: Colors.green[50], end: Colors.green[400]));
    _animationController.repeat();
    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  openFile() async {
    FlutterDownloader.open(taskId: this.id);
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _sairSgpol(bool value) async {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PresentationScreen(),
        ),
      );
      await Provider.of<AuthProvider>(context, listen: false).logout();
    }

    Future<void> _alertDialogSgpol(bool value) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogSgpol(
            botaoSim: true,
            textBotaoCancel: 'Não',
            textBotaoOk: 'Sair',
            titulo: 'Logout',
            mensagem: 'Deseja Sair?',
            respostaAlertDialog: _sairSgpol,
          );
        },
      );
    }

    downloadApk(bool value) async {
      // TODO https://pub.dev/packages/flutter_downloader - url para configuração do download no IOS
      if (value) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }
        Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
        String tempPath = tempDir.path;
        var filePath = tempPath + '/apkSgpol';
        final savedDir = Directory(filePath);

        bool hasExisted = await savedDir.exists();
        if (!hasExisted) {
          savedDir.create();
        }

        await removeTaks(false);

        await FlutterDownloader.enqueue(
          url: widget.versao.url,
          savedDir: filePath,
          showNotification: true, // show download progress in status bar (for Android)
          openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        );
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            SgpolAppTheme.primaryColorSgpol,
            SgpolAppTheme.primaryColorContrastSgpol,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BotaoOutlineSgpol(
                textButton: 'Sair',
                iconButton: Icons.logout,
                onpressButton: _alertDialogSgpol,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sgpol',
                style: Theme.of(context).textTheme.headline2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Atualização Disponível',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'nova versão : ${widget.versao.versao}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(height: 30),
                  if (this.status == DownloadTaskStatus.undefined ||
                      this.status == DownloadTaskStatus.complete ||
                      this.status == DownloadTaskStatus.canceled ||
                      this.status == DownloadTaskStatus.failed ||
                      this.status == DownloadTaskStatus.paused)
                    BotaoOutlineSgpol(
                      textButton: 'Download',
                      iconButton: Icons.file_download,
                      onpressButton: downloadApk,
                    ),
                  if (this.status == DownloadTaskStatus.running)
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 10,
                      child: LinearProgressIndicator(
                        color: SgpolAppTheme.whiteGradient,
                        valueColor: _colorTween,
                        value: this.progress.toDouble() / 100,
                      ),
                    ),
                  if (this.status == DownloadTaskStatus.running)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        child: BotaoOutlineSgpol(
                          textButton: 'Cancelar',
                          iconButton: Icons.cancel_outlined,
                          onpressButton: removeTaks,
                          colorButtonSgpol: Colors.redAccent,
                        ),
                      ),
                    )
                ],
              ),
              Container(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> removeTaks(bool value) async {
    FlutterDownloader.loadTasks().then((tasks) {
      tasks.forEach((element) async {
        await FlutterDownloader.remove(taskId: element.taskId);
      });
    });

    if (value) {
      setState(() {
        this.status = DownloadTaskStatus(0);
      });
    }
  }
}
