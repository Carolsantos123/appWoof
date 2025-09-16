class Agendamento {
  String agendamentoID;
  String data;
  List<String> diasSemana; // array de dias
  String horario;
  List<String> horarios; // array de horários
  String idCliente;
  String idPet;
  String idWalker;
  String observacoes;
  String status;
  String tempoPasseio;
  String tipo;

  Agendamento({
    required this.agendamentoID,
    required this.data,
    required this.diasSemana,
    required this.horario,
    required this.horarios,
    required this.idCliente,
    required this.idPet,
    required this.idWalker,
    required this.observacoes,
    required this.status,
    required this.tempoPasseio,
    required this.tipo,
  });

  // Converte para Map para salvar no Firebase
  Map<String, dynamic> toMap() {
    return {
      'agendamentoID': agendamentoID,
      'data': data,
      'dias_semana': diasSemana,
      'horario': horario,
      'horarios': horarios,
      'id_cliente': idCliente,
      'id_pet': idPet,
      'id_walker': idWalker,
      'observacoes': observacoes,
      'status': status,
      'tempo_passeio': tempoPasseio,
      'tipo': tipo,
    };
  }

  // Converte Map do Firebase para objeto Agendamento
  factory Agendamento.fromMap(Map<String, dynamic> map, String id) {
    return Agendamento(
      agendamentoID: id,
      data: map['data'] ?? '',
      diasSemana: map['dias_semana'] != null
          ? List<String>.from(map['dias_semana'])
          : [],
      horario: map['horario'] ?? '',
      horarios: map['horarios'] != null
          ? List<String>.from(map['horarios'])
          : [],
      idCliente: map['id_cliente'] ?? '',
      idPet: map['id_pet'] ?? '',
      idWalker: map['id_walker'] ?? '',
      observacoes: map['observacoes'] ?? '',
      status: map['status'] ?? '',
      tempoPasseio: map['tempo_passeio'] ?? '',
      tipo: map['tipo'] ?? '',
    );
  }
}
