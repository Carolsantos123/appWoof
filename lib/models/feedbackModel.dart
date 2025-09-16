class FeedbackPasseio {
  String feedbackID;
  double avaliacao;
  String comentario;
  String data;
  String idCliente;
  String idPasseio;
  String idWalker;

  FeedbackPasseio({
    required this.feedbackID,
    required this.avaliacao,
    required this.comentario,
    required this.data,
    required this.idCliente,
    required this.idPasseio,
    required this.idWalker,
  });

  // Converte para Map para salvar no Firebase
  Map<String, dynamic> toMap() {
    return {
      'feedbackID': feedbackID,
      'avaliacao': avaliacao,
      'comentario': comentario,
      'data': data,
      'id_cliente': idCliente,
      'id_passeio': idPasseio,
      'id_walker': idWalker,
    };
  }

  // Converte Map do Firebase para objeto FeedbackPasseio
  factory FeedbackPasseio.fromMap(Map<String, dynamic> map, String id) {
    return FeedbackPasseio(
      feedbackID: id,
      avaliacao: map['avaliacao'] != null
          ? (map['avaliacao'] as num).toDouble()
          : 0.0,
      comentario: map['comentario'] ?? '',
      data: map['data'] ?? '',
      idCliente: map['id_cliente'] ?? '',
      idPasseio: map['id_passeio'] ?? '',
      idWalker: map['id_walker'] ?? '',
    );
  }
}
