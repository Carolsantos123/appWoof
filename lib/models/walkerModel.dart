class Walker {
  String walkerID;
  String addExperienciasAnteriores;
  String bairro;
  String cep;
  String? complemento;  // opcional
  String cpf;
  String dataNascimento;
  String disponibilidades;
  String email;
  String estado;
  String? extra;
  String foto;
  String localizacaoPasseios;
  String nomeCompleto;
  int numero;
  String rua;
  String telefone;
  String uidUser; // 🔑 ligação com Firebase Auth

  Walker({
    required this.walkerID,
    required this.addExperienciasAnteriores,
    required this.bairro,
    required this.cep,
    this.complemento,  
    required this.cpf,
    required this.dataNascimento,
    required this.disponibilidades,
    required this.email,
    required this.estado,
    this.extra,
    required this.foto,
    required this.localizacaoPasseios,
    required this.nomeCompleto,
    required this.numero,
    required this.rua,
    required this.telefone,
    required this.uidUser, // 🔑 novo campo
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'walkerID': walkerID,
      'add_experiencias_anteriores': addExperienciasAnteriores,
      'bairro': bairro,
      'cep': cep,
      'cpf': cpf,
      'data_nascimento': dataNascimento,
      'disponibilidades': disponibilidades,
      'email': email,
      'estado': estado,
      'extra': extra,
      'foto': foto,
      'localizacao_passeios': localizacaoPasseios,
      'nome_completo': nomeCompleto,
      'numero': numero,
      'rua': rua,
      'telefone': telefone,
      'uid_user': uidUser, // 🔑 salvar
    };

    if (complemento != null && complemento!.isNotEmpty) {
      map['complemento'] = complemento;
    }

    return map;
  }

  factory Walker.fromMap(Map<String, dynamic> map, String id) {
    return Walker(
      walkerID: id,
      addExperienciasAnteriores: map['add_experiencias_anteriores'] ?? '',
      bairro: map['bairro'] ?? '',
      cep: map['cep'] ?? '',
      complemento: map['complemento'],
      cpf: map['cpf'] ?? '',
      dataNascimento: map['data_nascimento'] ?? '',
      disponibilidades: map['disponibilidades'] ?? '',
      email: map['email'] ?? '',
      estado: map['estado'] ?? '',
      extra: map['extra'] ?? '',
      foto: map['foto'] ?? '',
      localizacaoPasseios: map['localizacao_passeios'] ?? '',
      nomeCompleto: map['nome_completo'] ?? '',
      numero: map['numero'] ?? 0,
      rua: map['rua'] ?? '',
      telefone: map['telefone'] ?? '',
      uidUser: map['uid_user'] ?? '', // 🔑 carregar
    );
  }
}
