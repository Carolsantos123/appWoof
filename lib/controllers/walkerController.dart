import 'package:get/get.dart';
import 'package:woof/models/walkerModel.dart';
import 'package:woof/services/walkerService.dart';


class WalkerController extends GetxController {
  final WalkerService _walkerService = WalkerService();

  // Estado reativo do walker atual
  Rx<Walker?> walker = Rx<Walker?>(null);

  // Estado com lista de walkers (ex: listagem)
  RxList<Walker> walkers = <Walker>[].obs;

  // Criar walker
  Future<void> createWalker(Walker newWalker) async {
    await _walkerService.createWalker(newWalker);
    walker.value = newWalker;
    walkers.add(newWalker);
  }

  // Buscar walker por ID
  Future<void> fetchWalkerById(String walkerId) async {
    Walker? result = await _walkerService.getWalkerById(walkerId);
    walker.value = result;
  }

  // Atualizar walker
  Future<void> updateWalker(Walker updatedWalker) async {
    await _walkerService.updateWalker(updatedWalker);
    walker.value = updatedWalker;

    // Atualiza também na lista
    int index =
        walkers.indexWhere((element) => element.walkerID == updatedWalker.walkerID);
    if (index != -1) {
      walkers[index] = updatedWalker;
    }
  }

  // Deletar walker
  Future<void> deleteWalker(String walkerId) async {
    await _walkerService.deleteWalker(walkerId);
    walkers.removeWhere((w) => w.walkerID == walkerId);

    if (walker.value?.walkerID == walkerId) {
      walker.value = null;
    }
  }

  // Buscar todos os walkers
  Future<void> fetchAllWalkers() async {
    walkers.value = await _walkerService.getAllWalkers();
  }
}
