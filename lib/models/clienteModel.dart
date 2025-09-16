class Pet {
  String petID;
  String castrado;
  String condicao;
  String foto;
  int idade;
  String nomePet;
  String porte;
  String raca;
  String vacinacao;

  Pet({
    required this.petID,
    required this.castrado,
    required this.condicao,
    required this.foto,
    required this.idade,
    required this.nomePet,
    required this.porte,
    required this.raca,
    required this.vacinacao,
  });

  // Converte Pet para Map
  Map<String, dynamic> toMap() {
    return {
      'petID': petID,
      'castrado': castrado,
      'condicao': condicao,
      'foto': foto,
      'idade': idade,
      'nome_pet': nomePet,
      'porte': porte,
      'raca': raca,
      'vacinacao': vacinacao,
    };
  }

  // Converte Map do Firebase para Pet
  factory Pet.fromMap(Map<String, dynamic> map, String id) {
    return Pet(
      petID: id,
      castrado: map['castrado'] ?? '',
      condicao: map['condicao'] ?? '',
      foto: map['foto'] ?? '',
      idade: map['idade'] ?? 0,
      nomePet: map['nome_pet'] ?? '',
      porte: map['porte'] ?? '',
      raca: map['raca'] ?? '',
      vacinacao: map['vacinacao'] ?? '',
    );
  }
}

class Cliente {
  String clienteID;
  String bairro;
  String cep;
  String? complemento;
  String email;
  String estado;
  String foto;
  String nomeCompleto;
  int numero;
  String rua;
  String senha;
  int telefone;
  String uidUser;

  // Lista de Pets
  List<Pet> pets;

  Cliente({
    required this.clienteID,
    required this.bairro,
    required this.cep,
    this.complemento,
    required this.email,
    required this.estado,
    required this.foto,
    required this.nomeCompleto,
    required this.numero,
    required this.rua,
    required this.senha,
    required this.telefone,
    required this.uidUser,
    this.pets = const [],
  });

  // Converte Cliente para Map, incluindo pets
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'clienteID': clienteID,
      'bairro': bairro,
      'cep': cep,
      'email': email,
      'estado': estado,
      'foto': foto,
      'nome_completo': nomeCompleto,
      'numero': numero,
      'rua': rua,
      'senha': senha,
      'telefone': telefone,
      'uid_user': uidUser,
      'pets': pets.map((pet) => pet.toMap()).toList(), // converte pets
    };

    if (complemento != null && complemento!.isNotEmpty) {
      map['complemento'] = complemento;
    }

    return map;
  }

  // Converte Map do Firebase para Cliente, incluindo pets
  factory Cliente.fromMap(Map<String, dynamic> map, String id) {
    return Cliente(
      clienteID: id,
      bairro: map['bairro'] ?? '',
      cep: map['cep'] ?? '',
      complemento: map['complemento'],
      email: map['email'] ?? '',
      estado: map['estado'] ?? '',
      foto: map['foto'] ?? '',
      nomeCompleto: map['nome_completo'] ?? '',
      numero: map['numero'] ?? 0,
      rua: map['rua'] ?? '',
      senha: map['senha'] ?? '',
      telefone: map['telefone'] ?? 0,
      uidUser: map['uid_user'] ?? '',
      pets: map['pets'] != null
          ? List<Map<String, dynamic>>.from(map['pets'])
              .map((petMap) => Pet.fromMap(petMap, petMap['petID']))
              .toList()
          : [],
    );
  }
}
