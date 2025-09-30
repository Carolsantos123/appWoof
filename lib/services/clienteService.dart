import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/models/clienteModel.dart';

class ClienteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'clientes';

  Future<List<Cliente>> buscarClientes() async {
    final snapshot = await _firestore.collection(collectionName).get();
    return snapshot.docs
        .map((doc) => Cliente.fromMap(doc.data(), doc.id))
        .toList();
  }

  // ✅ Corrigido: agora usa o clienteID como ID do documento
  Future<void> adicionarCliente(Cliente cliente) async {
    await _firestore
        .collection(collectionName)
        .doc(cliente.clienteID) // ID fixo = uid do Auth
        .set(cliente.toMap());
  }

  Future<void> atualizarCliente(Cliente cliente) async {
    await _firestore
        .collection(collectionName)
        .doc(cliente.clienteID)
        .update(cliente.toMap());
  }

  Future<void> removerCliente(String clienteID) async {
    await _firestore.collection(collectionName).doc(clienteID).delete();
  }

  // Adiciona pet a um cliente
  Future<void> adicionarPet(String clienteID, Pet pet) async {
    final clienteDoc = _firestore.collection(collectionName).doc(clienteID);
    final clienteSnapshot = await clienteDoc.get();

    if (clienteSnapshot.exists) {
      var clienteData = clienteSnapshot.data()!;
      List pets = clienteData['pets'] ?? [];
      pets.add(pet.toMap());
      await clienteDoc.update({'pets': pets});
    }
  }

  // Remove pet de um cliente
  Future<void> removerPet(String clienteID, String petID) async {
    final clienteDoc = _firestore.collection(collectionName).doc(clienteID);
    final clienteSnapshot = await clienteDoc.get();

    if (clienteSnapshot.exists) {
      var clienteData = clienteSnapshot.data()!;
      List pets = clienteData['pets'] ?? [];
      pets.removeWhere((p) => p['petID'] == petID);
      await clienteDoc.update({'pets': pets});
    }
  }
}
