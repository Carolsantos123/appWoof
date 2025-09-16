import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/models/passeioModel.dart';

class PasseioService {
  final CollectionReference passeioRef =
      FirebaseFirestore.instance.collection('passeios');

  // Criar novo passeio
  Future<void> addPasseio(Passeio passeio) async {
    await passeioRef.doc(passeio.passeioID).set(passeio.toMap());
  }

  // Buscar passeio por ID
  Future<Passeio?> getPasseioById(String id) async {
    final doc = await passeioRef.doc(id).get();
    if (doc.exists) {
      return Passeio.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // Buscar passeios por cliente
  Future<List<Passeio>> getPasseiosByCliente(String idCliente) async {
    final snapshot =
        await passeioRef.where('id_cliente', isEqualTo: idCliente).get();
    return snapshot.docs
        .map((doc) =>
            Passeio.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Buscar passeios por walker
  Future<List<Passeio>> getPasseiosByWalker(String idWalker) async {
    final snapshot =
        await passeioRef.where('id_walker', isEqualTo: idWalker).get();
    return snapshot.docs
        .map((doc) =>
            Passeio.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Atualizar passeio
  Future<void> updatePasseio(String id, Map<String, dynamic> data) async {
    await passeioRef.doc(id).update(data);
  }

  // Deletar passeio
  Future<void> deletePasseio(String id) async {
    await passeioRef.doc(id).delete();
  }
}
