class Passeio {
  String passeioID;
  String nomePet;
  String bairro;
  String cep;
  String data;
  List<String> diasPasseio;
  String estado;
  String extra;
  DateTime horario;
  List<String> horariosPasseios;
  String idCliente;
  String idPet;
  String idWalker;
  int numero;
  String rua;
  String servicos;
  String tempoPasseio;
  String tipoPasseio;
  bool concluido; // ✅ novo campo

  Passeio({
    required this.passeioID,
    required this.nomePet,
    required this.bairro,
    required this.cep,
    required this.data,
    required this.diasPasseio,
    required this.estado,
    required this.extra,
    required this.horario,
    required this.horariosPasseios,
    required this.idCliente,
    required this.idPet,
    required this.idWalker,
    required this.numero,
    required this.rua,
    required this.servicos,
    required this.tempoPasseio,
    required this.tipoPasseio,
    required this.concluido, // ✅ obrigatório
  });

  Map<String, dynamic> toMap() {
    return {
      'passeioID': passeioID,
      'nome_pet': nomePet,
      'bairro': bairro,
      'cep': cep,
      'data': data,
      'dias_passeio': diasPasseio,
      'estado': estado,
      'extra': extra,
      'horario': horario.toIso8601String(),
      'horarios_passeios': horariosPasseios,
      'id_cliente': idCliente,
      'id_pet': idPet,
      'id_walker': idWalker,
      'numero': numero,
      'rua': rua,
      'servicos': servicos,
      'tempo_passeio': tempoPasseio,
      'tipo_passeio': tipoPasseio,
      'concluido': concluido, // ✅ salvar no Firebase
    };
  }

  factory Passeio.fromMap(Map<String, dynamic> map, String id) {
    return Passeio(
      passeioID: id,
      nomePet: map['nome_pet'] ?? '',
      bairro: map['bairro'] ?? '',
      cep: map['cep'] ?? '',
      data: map['data'] ?? '',
      diasPasseio: map['dias_passeio'] != null
          ? List<String>.from(map['dias_passeio'])
          : [],
      estado: map['estado'] ?? '',
      extra: map['extra'] ?? '',
      horario: map['horario'] != null
          ? DateTime.parse(map['horario'])
          : DateTime.now(),
      horariosPasseios: map['horarios_passeios'] != null
          ? List<String>.from(map['horarios_passeios'])
          : [],
      idCliente: map['id_cliente'] ?? '',
      idPet: map['id_pet'] ?? '',
      idWalker: map['id_walker'] ?? '',
      numero: map['numero'] ?? 0,
      rua: map['rua'] ?? '',
      servicos: map['servicos'] ?? '',
      tempoPasseio: map['tempo_passeio'] ?? '',
      tipoPasseio: map['tipo_passeio'] ?? '',
      concluido: map['concluido'] ?? false, // ✅ padrão: false
    );
  }
}
