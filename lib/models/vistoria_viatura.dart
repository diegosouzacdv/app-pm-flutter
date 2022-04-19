import 'package:apppmdfflutter/models/vistoria_viatura_itens_vistoria.dart';

class VistoriaViatura {
  int id;
  int odometro;
  int odometroFinal;
  String dataVistoria;
  String dataLiberacao;
  String nivelCombustivel;
  String latitude;
  String longitude;
  int ativo;
  String observacaoMotorista;
  String observacaoValidado;
  String observacaoMotoristaFinal;
  String observacaoValidadoFinal;
  String percurso;
  List<VistoriaViaturaItensVistoria> vistoriaViaturaItensVistoria = [];
  String statusVistoria;

  VistoriaViatura(
      {this.id,
      this.odometro,
      this.odometroFinal,
      this.dataVistoria,
      this.dataLiberacao,
      this.nivelCombustivel,
      this.latitude,
      this.longitude,
      this.ativo,
      this.observacaoMotorista,
      this.observacaoValidado,
      this.observacaoMotoristaFinal,
      this.observacaoValidadoFinal,
      this.percurso,
      this.vistoriaViaturaItensVistoria,
      this.statusVistoria});

  VistoriaViatura.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    odometro = json['odometro'];
    odometroFinal = json['odometroFinal'];
    dataVistoria = json['dataVistoria'];
    dataLiberacao = json['dataLiberacao'];
    nivelCombustivel = json['nivelCombustivel'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    ativo = json['ativo'];
    observacaoMotorista = json['observacaoMotorista'];
    observacaoValidado = json['observacaoValidado'];
    observacaoMotoristaFinal = json['observacaoMotoristaFinal'];
    observacaoValidadoFinal = json['observacaoValidadoFinal'];
    percurso = json['percurso'];
    print(json['vistoriaViaturaItensVistoria'] != null);
    print(json['vistoriaViaturaItensVistoria']);
    if (json['vistoriaViaturaItensVistoria'] != null) {
      vistoriaViaturaItensVistoria = [];
      json['vistoriaViaturaItensVistoria'].forEach((v) {
        vistoriaViaturaItensVistoria
            .add(new VistoriaViaturaItensVistoria.fromJson(v));
      });
    }
    statusVistoria = json['statusVistoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['odometro'] = this.odometro;
    data['odometroFinal'] = this.odometroFinal;
    data['dataVistoria'] = this.dataVistoria;
    data['dataLiberacao'] = this.dataLiberacao;
    data['nivelCombustivel'] = this.nivelCombustivel;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['ativo'] = this.ativo;
    data['observacaoMotorista'] = this.observacaoMotorista;
    data['observacaoValidado'] = this.observacaoValidado;
    data['observacaoMotoristaFinal'] = this.observacaoMotoristaFinal;
    data['observacaoValidadoFinal'] = this.observacaoValidadoFinal;
    data['percurso'] = this.percurso;
    if (this.vistoriaViaturaItensVistoria != null) {
      data['vistoriaViaturaItensVistoria'] =
          this.vistoriaViaturaItensVistoria.map((v) => v.toJson()).toList();
    }
    data['statusVistoria'] = this.statusVistoria;
    return data;
  }
}