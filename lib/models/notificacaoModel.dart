class Notificacao {
  String notificacaoID;
  String dataEnvio;
  String idUsuario;
  bool lida;
  String mensagem;
  String tipoUsuario;

  Notificacao({
    required this.notificacaoID,
    required this.dataEnvio,
    required this.idUsuario,
    required this.lida,
    required this.mensagem,
    required this.tipoUsuario,
  });

  // Converte para Map para salvar no Firebase
  Map<String, dynamic> toMap() {
    return {
      'notificacaoID': notificacaoID,
      'data_envio': dataEnvio,
      'id_usuario': idUsuario,
      'lida': lida,
      'mensagem': mensagem,
      'tipo_usuario': tipoUsuario,
    };
  }

  // Converte Map do Firebase para objeto Notificacao
  factory Notificacao.fromMap(Map<String, dynamic> map, String id) {
    return Notificacao(
      notificacaoID: id,
      dataEnvio: map['data_envio'] ?? '',
      idUsuario: map['id_usuario'] ?? '',
      lida: map['lida'] ?? false,
      mensagem: map['mensagem'] ?? '',
      tipoUsuario: map['tipo_usuario'] ?? '',
    );
  }
}
