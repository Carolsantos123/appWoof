import 'package:get/get.dart';
import 'package:woof/models/feedbackModel.dart';
import 'package:woof/services/feedbackService.dart';


class FeedbackController extends GetxController {
  final FeedbackService _feedbackService = FeedbackService();

  var feedbacks = <FeedbackPasseio>[].obs;
  var isLoading = false.obs;

  // Adicionar feedback
  Future<void> addFeedback(FeedbackPasseio feedback) async {
    try {
      isLoading.value = true;
      await _feedbackService.addFeedback(feedback);
      feedbacks.add(feedback);
    } finally {
      isLoading.value = false;
    }
  }

  // Carregar feedbacks de um walker
  Future<void> loadFeedbacksByWalker(String walkerID) async {
    try {
      isLoading.value = true;
      final data = await _feedbackService.getFeedbacksByWalker(walkerID);
      feedbacks.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }

  // Carregar feedbacks de um cliente
  Future<void> loadFeedbacksByCliente(String clienteID) async {
    try {
      isLoading.value = true;
      final data = await _feedbackService.getFeedbacksByCliente(clienteID);
      feedbacks.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }

  // Atualizar feedback
  Future<void> updateFeedback(String id, Map<String, dynamic> data) async {
    await _feedbackService.updateFeedback(id, data);
    final index = feedbacks.indexWhere((f) => f.feedbackID == id);
    if (index != -1) {
      feedbacks[index] = FeedbackPasseio.fromMap(data, id);
    }
  }

  // Deletar feedback
  Future<void> deleteFeedback(String id) async {
    await _feedbackService.deleteFeedback(id);
    feedbacks.removeWhere((f) => f.feedbackID == id);
  }
}
