// controllers/cliente_controller.dart
import 'package:get/get.dart';
import 'package:woof/models/clienteModel.dart';
import 'package:woof/services/clienteService.dart';


class ClienteController extends GetxController {
  final ClienteService service;

  ClienteController({required this.service});

  var clientes = <Cliente>[].obs;
  var carregando = false.obs;

  void carregarClientes() async {
    try {
      carregando.value = true;
      var lista = await service.buscarClientes();
      clientes.assignAll(lista);
    } finally {
      carregando.value = false;
    }
  }

  void adicionarCliente(Cliente cliente) async {
    await service.adicionarCliente(cliente);
    clientes.add(cliente);
  }

  void atualizarCliente(Cliente cliente) async {
    await service.atualizarCliente(cliente);
    int index = clientes.indexWhere((c) => c.clienteID == cliente.clienteID);
    if (index != -1) {
      clientes[index] = cliente;
      clientes.refresh();
    }
  }

  void removerCliente(String clienteID) async {
    await service.removerCliente(clienteID);
    clientes.removeWhere((c) => c.clienteID == clienteID);
  }

  void adicionarPet(String clienteID, Pet pet) async {
    await service.adicionarPet(clienteID, pet);
    carregarClientes(); // Atualiza a lista
  }

  void removerPet(String clienteID, String petID) async {
    await service.removerPet(clienteID, petID);
    carregarClientes(); // Atualiza a lista
  }
}
