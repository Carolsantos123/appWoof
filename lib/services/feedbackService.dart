import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/models/feedbackModel.dart';


class FeedbackService {
  final CollectionReference feedbackRef =
      FirebaseFirestore.instance.collection('feedbacks');

  // Criar novo feedback
  Future<void> addFeedback(FeedbackPasseio feedback) async {
    await feedbackRef.doc(feedback.feedbackID).set(feedback.toMap());
  }

  // Buscar feedback por ID
  Future<FeedbackPasseio?> getFeedbackById(String id) async {
    final doc = await feedbackRef.doc(id).get();
    if (doc.exists) {
      return FeedbackPasseio.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // Buscar feedbacks por Walker
  Future<List<FeedbackPasseio>> getFeedbacksByWalker(String walkerID) async {
    final snapshot =
        await feedbackRef.where('id_walker', isEqualTo: walkerID).get();
    return snapshot.docs
        .map((doc) =>
            FeedbackPasseio.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Buscar feedbacks por Cliente
  Future<List<FeedbackPasseio>> getFeedbacksByCliente(String clienteID) async {
    final snapshot =
        await feedbackRef.where('id_cliente', isEqualTo: clienteID).get();
    return snapshot.docs
        .map((doc) =>
            FeedbackPasseio.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Atualizar feedback
  Future<void> updateFeedback(String id, Map<String, dynamic> data) async {
    await feedbackRef.doc(id).update(data);
  }

  // Deletar feedback
  Future<void> deleteFeedback(String id) async {
    await feedbackRef.doc(id).delete();
  }
}
