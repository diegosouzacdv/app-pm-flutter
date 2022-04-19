class VistoriaViaturaItensVistoria {
  int id;
  int vistoriaOk;
  String nomeAnexo;
  String contentType;
  List<String> fotos;
  String nome;
  List<String> vistoriaViaturaItensVistoriaAnexos;
  int tipoItem;

  VistoriaViaturaItensVistoria(
      {this.id,
      this.vistoriaOk,
      this.nomeAnexo,
      this.contentType,
      this.fotos,
      this.nome,
      this.vistoriaViaturaItensVistoriaAnexos,
      this.tipoItem});

  VistoriaViaturaItensVistoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vistoriaOk = json['vistoriaOk'];
    nomeAnexo = json['nomeAnexo'];
    contentType = json['contentType'];
    if (json['fotos'] != null) fotos = json['fotos'].cast<String>();
    nome = json['nome'];
    if (json['vistoriaViaturaItensVistoriaAnexos'].length > 0)
      vistoriaViaturaItensVistoriaAnexos =
          json['vistoriaViaturaItensVistoriaAnexos'].cast<String>();

    tipoItem = json['tipoItem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vistoriaOk'] = this.vistoriaOk;
    data['nomeAnexo'] = this.nomeAnexo;
    data['contentType'] = this.contentType;
    data['fotos'] = this.fotos;
    data['nome'] = this.nome;
    data['vistoriaViaturaItensVistoriaAnexos'] =
        this.vistoriaViaturaItensVistoriaAnexos;
    data['tipoItem'] = this.tipoItem;
    return data;
  }
}
