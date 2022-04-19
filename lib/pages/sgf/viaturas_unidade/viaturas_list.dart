import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/utils/app_routes.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class ViaturasList extends StatelessWidget {
  final List<ViaturaDTO> viaturas;
  final String router;

  const ViaturasList({Key key, this.viaturas, this.router}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return viaturas.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Nenhuma Viatura na Unidade!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: viaturas.length,
            itemBuilder: (context, index) {
              final vi = viaturas[index];
              return Card(
                color: SgpolAppTheme.background,
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  selected: true,
                  leading: CircleAvatar(
                    backgroundColor: SgpolAppTheme.accentColorSgpol,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text('${vi.marca}'),
                      ),
                    ),
                  ),
                  title: Text(
                    'Prefixo: ${vi.prefixo}',
                    style:
                        TextStyle(color: SgpolAppTheme.darkText, fontSize: 20),
                  ),
                  subtitle: Text(
                    'Placa: ${vi.placa}',
                    style: TextStyle(color: SgpolAppTheme.darkText),
                  ),
                  onTap: () => {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.STANDART_SCREEN, arguments: router)
                  },
                  trailing: Icon(
                    Icons.arrow_right_outlined,
                    color: SgpolAppTheme.darkText,
                  ),
                ),
              );
            });
  }
}
