import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/models/agendamentoModel.dart';

class AgendamentoService {
  final CollectionReference agendamentosCollection =
      FirebaseFirestore.instance.collection('agendamentos');

  // Criar novo agendamento
  Future<void> createAgendamento(Agendamento agendamento) async {
    await agendamentosCollection
        .doc(agendamento.agendamentoID)
        .set(agendamento.toMap());
  }

  // Buscar agendamento por ID
  Future<Agendamento?> getAgendamentoById(String agendamentoId) async {
    DocumentSnapshot doc = await agendamentosCollection.doc(agendamentoId).get();

    if (doc.exists) {
      return Agendamento.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // Atualizar agendamento
  Future<void> updateAgendamento(Agendamento agendamento) async {
    await agendamentosCollection
        .doc(agendamento.agendamentoID)
        .update(agendamento.toMap());
  }

  // Deletar agendamento
  Future<void> deleteAgendamento(String agendamentoId) async {
    await agendamentosCollection.doc(agendamentoId).delete();
  }

  // Buscar todos os agendamentos
  Future<List<Agendamento>> getAllAgendamentos() async {
    QuerySnapshot snapshot = await agendamentosCollection.get();
    return snapshot.docs
        .map((doc) =>
            Agendamento.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Buscar agendamentos por cliente
  Future<List<Agendamento>> getAgendamentosByCliente(String clienteId) async {
    QuerySnapshot snapshot = await agendamentosCollection
        .where('id_cliente', isEqualTo: clienteId)
        .get();

    return snapshot.docs
        .map((doc) =>
            Agendamento.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Buscar agendamentos por walker
  Future<List<Agendamento>> getAgendamentosByWalker(String walkerId) async {
    QuerySnapshot snapshot = await agendamentosCollection
        .where('id_walker', isEqualTo: walkerId)
        .get();

    return snapshot.docs
        .map((doc) =>
            Agendamento.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
