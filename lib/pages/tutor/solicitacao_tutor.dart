import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/models/clienteModel.dart';
import 'package:woof/models/passeioModel.dart';


class SolicitarPasseioScreen extends StatefulWidget {
  const SolicitarPasseioScreen({super.key});

  @override
  State<SolicitarPasseioScreen> createState() => _SolicitarPasseioScreenState();
}

class _SolicitarPasseioScreenState extends State<SolicitarPasseioScreen> {
  String? tipoPasseio; // fixo ou provisório
  Set<DateTime> diasSelecionados = {};
  DateTime? diaProvisorio;
  Map<DateTime, TextEditingController> horariosControllers = {};

  DateTime focusedDay = DateTime.now();

  final _enderecoController = TextEditingController();
  final _observacoesController = TextEditingController();
  String? petSelecionado;
  String? duracaoSelecionada;

  List<Pet> meusPets = [];
  Cliente? cliente;
  bool carregandoPets = true;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
    carregarPets();
  }

  Future<void> carregarPets() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final query = await FirebaseFirestore.instance
          .collection('clientes')
          .where('uid_user', isEqualTo: user.uid)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        final data = query.docs.first;
        setState(() {
          cliente = Cliente.fromMap(data.data(), data.id);
          meusPets = cliente!.pets;
          carregandoPets = false;
        });
      } else {
        setState(() => carregandoPets = false);
      }
    } catch (e) {
      debugPrint("Erro ao carregar pets: $e");
      setState(() => carregandoPets = false);
    }
  }

  Future<void> _selecionarHorario(DateTime dia) async {
    final TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (hora != null) {
      setState(() {
        final controller = horariosControllers[dia] ?? TextEditingController();
        controller.text =
            "${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}";
        horariosControllers[dia] = controller;
      });
    }
  }

  Future<void> _salvarPasseio() async {
  if (cliente == null || petSelecionado == null || duracaoSelecionada == null) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos obrigatórios")));
    return;
  }

  List<String> dias = [];
  List<String> horarios = [];

  if (tipoPasseio == "fixo") {
    dias = diasSelecionados.map((d) => "${d.day}/${d.month}/${d.year}").toList();
    horarios = diasSelecionados.map((d) => horariosControllers[d]?.text ?? "").toList();
  } else if (tipoPasseio == "provisorio" && diaProvisorio != null) {
    dias = ["${diaProvisorio!.day}/${diaProvisorio!.month}/${diaProvisorio!.year}"];
    horarios = [horariosControllers[diaProvisorio!]?.text ?? ""];
  }

  final petEscolhido = cliente!.pets.firstWhere((p) => p.nomePet == petSelecionado);

  final passeio = Passeio(
    passeioID: DateTime.now().millisecondsSinceEpoch.toString(),
    nomePet: petSelecionado!,
    bairro: cliente!.bairro,
    cep: cliente!.cep,
    data: dias.join(", "),
    diasPasseio: dias,
    estado: cliente!.estado,
    extra: '', // removido uso de cliente.extra
    horario: DateTime.now(),
    horariosPasseios: horarios,
    idCliente: cliente!.clienteID,
    idPet: petEscolhido.petID,
    idWalker: '', // opcional, selecionar walker depois
    numero: cliente!.numero,
    rua: cliente!.rua,
    servicos: '', // se houver serviço específico
    tempoPasseio: duracaoSelecionada!,
    tipoPasseio: tipoPasseio!,
  );

  try {
    await FirebaseFirestore.instance
        .collection('passeios')
        .doc(passeio.passeioID)
        .set(passeio.toMap());

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passeio solicitado com sucesso!")));
    Navigator.pop(context);
  } catch (e) {
    debugPrint("Erro ao salvar passeio: $e");
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Erro ao solicitar passeio")));
  }
}

  @override
  Widget build(BuildContext context) {
    final InputDecoration campoLaranja = InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange.shade800)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange.shade800, width: 2)),
      labelStyle: TextStyle(color: Colors.orange.shade800),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9E6),
      appBar: AppBar(
        title: Text("Passeio",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.green.shade900)),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF9E6),
        elevation: 0,
      ),
      body: carregandoPets
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: campoLaranja.copyWith(
                        labelText: "Selecione o pet que irá passear"),
                    items: meusPets
                        .map((p) =>
                            DropdownMenuItem(value: p.nomePet, child: Text(p.nomePet)))
                        .toList(),
                    value: petSelecionado,
                    onChanged: (value) => setState(() => petSelecionado = value),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: campoLaranja.copyWith(labelText: "Tipo de passeio"),
                    items: const [
                      DropdownMenuItem(value: "fixo", child: Text("Fixo")),
                      DropdownMenuItem(value: "provisorio", child: Text("Provisório")),
                    ],
                    value: tipoPasseio,
                    onChanged: (value) {
                      setState(() {
                        tipoPasseio = value;
                        diasSelecionados.clear();
                        diaProvisorio = null;
                        horariosControllers.clear();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text("Selecione o(s) dia(s):",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TableCalendar(
                    locale: 'pt_BR',
                    focusedDay: focusedDay,
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(DateTime.now().year + 1, 12, 31),
                    calendarFormat: CalendarFormat.month,
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade900),
                    ),
                    selectedDayPredicate: (day) {
                      if (tipoPasseio == "fixo") {
                        return diasSelecionados.contains(day);
                      } else {
                        return diaProvisorio != null &&
                            day.year == diaProvisorio!.year &&
                            day.month == diaProvisorio!.month &&
                            day.day == diaProvisorio!.day;
                      }
                    },
                    onDaySelected: (selected, focused) {
                      setState(() {
                        focusedDay = focused;
                        if (tipoPasseio == "fixo") {
                          if (diasSelecionados.contains(selected)) {
                            diasSelecionados.remove(selected);
                            horariosControllers.remove(selected);
                          } else {
                            diasSelecionados.add(selected);
                            horariosControllers[selected] = TextEditingController();
                          }
                        } else {
                          diaProvisorio = selected;
                          horariosControllers.clear();
                          horariosControllers[selected] = TextEditingController();
                        }
                      });
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Colors.orange.shade300, shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                          color: Colors.orange.shade800, shape: BoxShape.circle),
                      defaultDecoration: BoxDecoration(
                          color: Colors.orange.shade100, shape: BoxShape.circle),
                      weekendDecoration: BoxDecoration(
                          color: Colors.orange.shade200, shape: BoxShape.circle),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (tipoPasseio == "fixo")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: diasSelecionados.map((dia) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: TextField(
                            controller: horariosControllers[dia],
                            readOnly: true,
                            decoration: campoLaranja.copyWith(
                                labelText:
                                    "Horário do dia ${dia.day}/${dia.month}/${dia.year}",
                                suffixIcon: const Icon(Icons.access_time,
                                    color: Colors.orange)),
                            onTap: () => _selecionarHorario(dia),
                          ),
                        );
                      }).toList(),
                    ),
                  if (tipoPasseio == "provisorio" && diaProvisorio != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TextField(
                        controller: horariosControllers[diaProvisorio],
                        readOnly: true,
                        decoration: campoLaranja.copyWith(
                            labelText:
                                "Horário do dia ${diaProvisorio!.day}/${diaProvisorio!.month}/${diaProvisorio!.year}",
                            suffixIcon:
                                const Icon(Icons.access_time, color: Colors.orange)),
                        onTap: () => _selecionarHorario(diaProvisorio!),
                      ),
                    ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: campoLaranja.copyWith(labelText: "Duração do passeio"),
                    items: const [
                      DropdownMenuItem(value: "30min", child: Text("30 minutos")),
                      DropdownMenuItem(value: "60min", child: Text("1 hora")),
                      DropdownMenuItem(value: "90min", child: Text("1 hora e 30 minutos")),
                    ],
                    value: duracaoSelecionada,
                    onChanged: (value) => setState(() => duracaoSelecionada = value),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _enderecoController,
                    decoration: campoLaranja.copyWith(labelText: "Endereço do passeio"),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _observacoesController,
                    maxLines: 2,
                    decoration:
                        campoLaranja.copyWith(labelText: "Observações adicionais"),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _salvarPasseio,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade800,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text("Solicitar Passeio"),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
