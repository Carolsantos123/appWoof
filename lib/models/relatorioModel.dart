class RelatorioPasseio {
  String relatorioID;
  String idPasseio;
  String idWalker;
  String relatorio;
  String data;

  RelatorioPasseio({
    required this.relatorioID,
    required this.idPasseio,
    required this.idWalker,
    required this.relatorio,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'relatorioID': relatorioID,
      'id_passeio': idPasseio,
      'id_walker': idWalker,
      'relatorio': relatorio,
      'data': data,
    };
  }

  factory RelatorioPasseio.fromMap(Map<String, dynamic> map, String id) {
    return RelatorioPasseio(
      relatorioID: id,
      idPasseio: map['id_passeio'] ?? '',
      idWalker: map['id_walker'] ?? '',
      relatorio: map['relatorio'] ?? '',
      data: map['data'] ?? '',
    );
  }
}
