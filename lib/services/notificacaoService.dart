import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/models/notificacaoModel.dart';

class NotificacaoService {
  final CollectionReference notificacaoRef =
      FirebaseFirestore.instance.collection('notificacoes');

  // Criar nova notificação
  Future<void> addNotificacao(Notificacao notificacao) async {
    await notificacaoRef.doc(notificacao.notificacaoID).set(notificacao.toMap());
  }

  // Buscar notificação por ID
  Future<Notificacao?> getNotificacaoById(String id) async {
    final doc = await notificacaoRef.doc(id).get();
    if (doc.exists) {
      return Notificacao.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // Buscar notificações de um usuário
  Future<List<Notificacao>> getNotificacoesByUsuario(String idUsuario) async {
    final snapshot =
        await notificacaoRef.where('id_usuario', isEqualTo: idUsuario).get();
    return snapshot.docs
        .map((doc) =>
            Notificacao.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Marcar como lida
  Future<void> marcarComoLida(String id) async {
    await notificacaoRef.doc(id).update({'lida': true});
  }

  // Atualizar notificação
  Future<void> updateNotificacao(String id, Map<String, dynamic> data) async {
    await notificacaoRef.doc(id).update(data);
  }

  // Deletar notificação
  Future<void> deleteNotificacao(String id) async {
    await notificacaoRef.doc(id).delete();
  }
}
