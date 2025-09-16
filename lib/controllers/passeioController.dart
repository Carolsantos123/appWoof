import 'package:get/get.dart';
import 'package:woof/models/passeioModel.dart';
import 'package:woof/services/passeioService.dart';


class PasseioController extends GetxController {
  final PasseioService _passeioService = PasseioService();

  var passeios = <Passeio>[].obs;
  var isLoading = false.obs;

  // Adicionar novo passeio
  Future<void> addPasseio(Passeio passeio) async {
    try {
      isLoading.value = true;
      await _passeioService.addPasseio(passeio);
      passeios.add(passeio);
    } finally {
      isLoading.value = false;
    }
  }

  // Carregar passeios de um cliente
  Future<void> loadPasseiosByCliente(String idCliente) async {
    try {
      isLoading.value = true;
      final data = await _passeioService.getPasseiosByCliente(idCliente);
      passeios.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }

  // Carregar passeios de um walker
  Future<void> loadPasseiosByWalker(String idWalker) async {
    try {
      isLoading.value = true;
      final data = await _passeioService.getPasseiosByWalker(idWalker);
      passeios.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }

  // Atualizar passeio
  Future<void> updatePasseio(String id, Map<String, dynamic> data) async {
    await _passeioService.updatePasseio(id, data);
    final index = passeios.indexWhere((p) => p.passeioID == id);
    if (index != -1) {
      passeios[index] = Passeio.fromMap(data, id);
      passeios.refresh();
    }
  }

  // Deletar passeio
  Future<void> deletePasseio(String id) async {
    await _passeioService.deletePasseio(id);
    passeios.removeWhere((p) => p.passeioID == id);
  }
}
