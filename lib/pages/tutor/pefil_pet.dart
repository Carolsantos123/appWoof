import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/models/clienteModel.dart';
// ajuste conforme seu projeto

class PerfilPetScreen extends StatefulWidget {
  const PerfilPetScreen({super.key});

  @override
  State<PerfilPetScreen> createState() => _PerfilPetScreenState();
}

class _PerfilPetScreenState extends State<PerfilPetScreen> {
  final user = FirebaseAuth.instance.currentUser;
  Cliente? cliente;
  bool carregando = true;

  // Controladores de formulário
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController racaController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController condicaoController = TextEditingController();
  final TextEditingController porteController = TextEditingController();
  final TextEditingController castradoController = TextEditingController();

  Map<String, bool> _vacinaseRemedios = {
    'Polivalente': false,
    'Raiva': false,
    'Leishmaniose': false,
    'Vermífugos': false,
    'Antipulgas e Carrapatos': false,
  };

  @override
  void initState() {
    super.initState();
    carregarCliente();
  }

  Future<void> carregarCliente() async {
    try {
      final query = await FirebaseFirestore.instance
          .collection('clientes')
          .where('uid_user', isEqualTo: user!.uid)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        final data = query.docs.first;
        setState(() {
          cliente = Cliente.fromMap(data.data(), data.id);
          carregando = false;
        });
      } else {
        setState(() => carregando = false);
      }
    } catch (e) {
      debugPrint('Erro ao carregar cliente: $e');
      setState(() => carregando = false);
    }
  }

  Future<void> salvarCliente() async {
    if (cliente == null) return;
    await FirebaseFirestore.instance
        .collection('clientes')
        .doc(cliente!.clienteID)
        .update(cliente!.toMap());
  }

  void _abrirDialog({Pet? pet, int? index}) {
    // Inicializa valores
    if (pet != null) {
      nomeController.text = pet.nomePet;
      racaController.text = pet.raca;
      idadeController.text = pet.idade.toString();
      condicaoController.text = pet.condicao;
      porteController.text = pet.porte;
      castradoController.text = pet.castrado;
      _vacinaseRemedios.updateAll((key, value) => pet.vacinacao.contains(key));
    } else {
      nomeController.clear();
      racaController.clear();
      idadeController.clear();
      condicaoController.clear();
      porteController.text = 'Médio';
      castradoController.text = 'Não';
      _vacinaseRemedios.updateAll((key, value) => false);
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(
              pet == null ? "Adicionar Pet" : "Editar Pet",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  _campoTexto("Nome", nomeController),
                  _campoTexto("Raça", racaController),
                  _campoNumero("Idade", idadeController),
                  _campoTexto("Condição Especial", condicaoController),

                  // Dropdown Porte
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: porteController.text.isNotEmpty
                        ? porteController.text
                        : 'Médio',
                    decoration: const InputDecoration(
                      labelText: "Porte",
                      border: OutlineInputBorder(),
                    ),
                    items: ['Pequeno', 'Médio', 'Grande']
                        .map((porte) => DropdownMenuItem(
                              value: porte,
                              child: Text(porte),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setStateDialog(
                          () => porteController.text = value ?? 'Médio');
                    },
                  ),

                  const SizedBox(height: 12),
                  // Dropdown Castrado
                  DropdownButtonFormField<String>(
                    value: castradoController.text.isNotEmpty
                        ? castradoController.text
                        : 'Não',
                    decoration: const InputDecoration(
                      labelText: "Castrado",
                      border: OutlineInputBorder(),
                    ),
                    items: ['Sim', 'Não']
                        .map((c) => DropdownMenuItem(
                              value: c,
                              child: Text(c),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setStateDialog(
                          () => castradoController.text = value ?? 'Não');
                    },
                  ),

                  const SizedBox(height: 12),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Vacinas e Remédios',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      children: _vacinaseRemedios.keys.map((String key) {
                        return CheckboxListTile(
                          title: Text(key),
                          value: _vacinaseRemedios[key],
                          activeColor: const Color(0xFF199700),
                          onChanged: (bool? value) {
                            setStateDialog(() {
                              _vacinaseRemedios[key] = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final vacinasSelecionadas = _vacinaseRemedios.entries
                      .where((e) => e.value)
                      .map((e) => e.key)
                      .join(", ");

                  final novoPet = Pet(
                    petID: pet?.petID ??
                        DateTime.now().millisecondsSinceEpoch.toString(),
                    nomePet: nomeController.text,
                    raca: racaController.text,
                    idade: int.tryParse(idadeController.text) ?? 0,
                    condicao: condicaoController.text,
                    porte: porteController.text,
                    castrado: castradoController.text,
                    vacinacao: vacinasSelecionadas,
                    foto: '', // adicionar depois
                  );

                  setState(() {
                    if (pet == null) {
                      cliente!.pets.add(novoPet);
                    } else {
                      cliente!.pets[index!] = novoPet;
                    }
                  });

                  await salvarCliente();
                  Navigator.pop(context);
                },
                child: const Text("Atualizar"),
              ),
            ],
          ),
        );
      },
    );
  }

// Novo campo número
  Widget _campoNumero(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _campoTexto(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9500),
        elevation: 0,
        title: const Text(
          'Meus Pets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: carregando
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF199700)))
          : (cliente == null || cliente!.pets.isEmpty)
              ? const Center(child: Text("Nenhum pet cadastrado."))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cliente!.pets.length,
                  itemBuilder: (context, index) {
                    final pet = cliente!.pets[index];
                    return Card(
                      color: const Color(0xFFFFF0C2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Icon(
                                Icons.pets,
                                size: 80,
                                color: Colors.green.shade900,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text("Nome: ${pet.nomePet}",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text("Raça: ${pet.raca}"),
                            Text("Idade: ${pet.idade}"),
                            Text("Condição Especial: ${pet.condicao}"),
                            Text("Porte: ${pet.porte}"),
                            Text("Vacinação: ${pet.vacinacao}"),
                            Text("Castrado: ${pet.castrado}"),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    _abrirDialog(
                                      pet: cliente!.pets[index],
                                      index: index,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () async {
                                    final confirmar = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Confirmar exclusão"),
                                        content: const Text(
                                            "Tem certeza que deseja excluir este pet?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text("Cancelar"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            child: const Text("Excluir"),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirmar == true &&
                                        cliente != null &&
                                        cliente!.pets.isNotEmpty) {
                                      // Remove do array do cliente localmente
                                      final petRemovido =
                                          cliente!.pets.removeAt(index);

                                      setState(() {});

                                      // Atualiza no Firestore
                                      await FirebaseFirestore.instance
                                          .collection('clientes')
                                          .doc(cliente!.clienteID)
                                          .update({
                                        'pets': cliente!.pets
                                            .map((p) => p.toMap())
                                            .toList(),
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0A6C0A),
        onPressed: () => _abrirDialog(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
