import 'package:get/get.dart';
import 'package:woof/models/notificacaoModel.dart';
import 'package:woof/services/notificacaoService.dart';


class NotificacaoController extends GetxController {
  final NotificacaoService _notificacaoService = NotificacaoService();

  var notificacoes = <Notificacao>[].obs;
  var isLoading = false.obs;

  // Adicionar nova notificação
  Future<void> addNotificacao(Notificacao notificacao) async {
    try {
      isLoading.value = true;
      await _notificacaoService.addNotificacao(notificacao);
      notificacoes.add(notificacao);
    } finally {
      isLoading.value = false;
    }
  }

  // Carregar notificações por usuário
  Future<void> loadNotificacoesByUsuario(String idUsuario) async {
    try {
      isLoading.value = true;
      final data = await _notificacaoService.getNotificacoesByUsuario(idUsuario);
      notificacoes.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }

  // Marcar notificação como lida
  Future<void> marcarComoLida(String id) async {
    await _notificacaoService.marcarComoLida(id);
    final index = notificacoes.indexWhere((n) => n.notificacaoID == id);
    if (index != -1) {
      notificacoes[index].lida = true;
      notificacoes.refresh();
    }
  }

  // Atualizar notificação
  Future<void> updateNotificacao(String id, Map<String, dynamic> data) async {
    await _notificacaoService.updateNotificacao(id, data);
    final index = notificacoes.indexWhere((n) => n.notificacaoID == id);
    if (index != -1) {
      notificacoes[index] = Notificacao.fromMap(data, id);
    }
  }

  // Deletar notificação
  Future<void> deleteNotificacao(String id) async {
    await _notificacaoService.deleteNotificacao(id);
    notificacoes.removeWhere((n) => n.notificacaoID == id);
  }
}
