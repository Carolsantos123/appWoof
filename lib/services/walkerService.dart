import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/models/walkerModel.dart';


class WalkerService {
  final CollectionReference walkersCollection =
      FirebaseFirestore.instance.collection('walkers');

  // Criar novo walker
  Future<void> createWalker(Walker walker) async {
    await walkersCollection.doc(walker.walkerID).set(walker.toMap());
  }

  // Buscar walker por ID
  Future<Walker?> getWalkerById(String walkerId) async {
    DocumentSnapshot doc = await walkersCollection.doc(walkerId).get();

    if (doc.exists) {
      return Walker.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // Atualizar walker
  Future<void> updateWalker(Walker walker) async {
    await walkersCollection.doc(walker.walkerID).update(walker.toMap());
  }

  // Deletar walker
  Future<void> deleteWalker(String walkerId) async {
    await walkersCollection.doc(walkerId).delete();
  }

  // Buscar todos os walkers
  Future<List<Walker>> getAllWalkers() async {
    QuerySnapshot snapshot = await walkersCollection.get();
    return snapshot.docs
        .map((doc) => Walker.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
