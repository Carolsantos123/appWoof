import 'package:get/get.dart';
import 'package:woof/models/agendamentoModel.dart' show Agendamento;
import 'package:woof/services/agendamentoService.dart';


class AgendamentoController extends GetxController {
  final AgendamentoService _agendamentoService = AgendamentoService();

  // Estado reativo de um único agendamento
  Rx<Agendamento?> agendamento = Rx<Agendamento?>(null);

  // Lista de agendamentos (ex: histórico)
  RxList<Agendamento> agendamentos = <Agendamento>[].obs;

  // Criar agendamento
  Future<void> createAgendamento(Agendamento newAgendamento) async {
    await _agendamentoService.createAgendamento(newAgendamento);
    agendamentos.add(newAgendamento);
    agendamento.value = newAgendamento;
  }

  // Buscar agendamento por ID
  Future<void> fetchAgendamentoById(String agendamentoId) async {
    Agendamento? result =
        await _agendamentoService.getAgendamentoById(agendamentoId);
    agendamento.value = result;
  }

  // Atualizar agendamento
  Future<void> updateAgendamento(Agendamento updatedAgendamento) async {
    await _agendamentoService.updateAgendamento(updatedAgendamento);
    agendamento.value = updatedAgendamento;

    int index = agendamentos.indexWhere(
        (element) => element.agendamentoID == updatedAgendamento.agendamentoID);
    if (index != -1) {
      agendamentos[index] = updatedAgendamento;
    }
  }

  // Deletar agendamento
  Future<void> deleteAgendamento(String agendamentoId) async {
    await _agendamentoService.deleteAgendamento(agendamentoId);
    agendamentos.removeWhere((a) => a.agendamentoID == agendamentoId);

    if (agendamento.value?.agendamentoID == agendamentoId) {
      agendamento.value = null;
    }
  }

  // Buscar todos os agendamentos
  Future<void> fetchAllAgendamentos() async {
    agendamentos.value = await _agendamentoService.getAllAgendamentos();
  }

  // Buscar agendamentos de um cliente
  Future<void> fetchAgendamentosByCliente(String clienteId) async {
    agendamentos.value =
        await _agendamentoService.getAgendamentosByCliente(clienteId);
  }

  // Buscar agendamentos de um walker
  Future<void> fetchAgendamentosByWalker(String walkerId) async {
    agendamentos.value =
        await _agendamentoService.getAgendamentosByWalker(walkerId);
  }
}
