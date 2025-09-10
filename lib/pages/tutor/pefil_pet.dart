import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilPetScreen extends StatefulWidget {
  const PerfilPetScreen({super.key});

  @override
  State<PerfilPetScreen> createState() => _PerfilPetScreenState();
}

class _PerfilPetScreenState extends State<PerfilPetScreen> {
  // Lista de pets (exemplo inicial)
  List<Map<String, String>> pets = [
    {
      "nome": "Rex",
      "raca": "Pitbull",
      "idade": "5 Anos",
      "condicao": "Nenhuma",
      "porte": "Grande",
      "vacina": "Polivalente, Raiva",
      "castrado": "Não",
    },
    {
      "nome": "Luna",
      "raca": "Golden Retriever",
      "idade": "3 Anos",
      "condicao": "Alergia",
      "porte": "Médio",
      "vacina": "Pendente",
      "castrado": "Sim",
    },
  ];

  // Controladores para o formulário de edição
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController racaController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController condicaoController = TextEditingController();
  final TextEditingController porteController = TextEditingController();
  final TextEditingController castradoController = TextEditingController();

  // Vacinas como checkbox
  Map<String, bool> _vacinaseRemedios = {
    'Polivalente': false,
    'Raiva': false,
    'Leishmaniose': false,
    'Vermífugos': false,
    'Antipulgas e Carrapatos': false,
  };

  void _abrirDialog({Map<String, String>? pet, int? index}) {
    if (pet != null) {
      nomeController.text = pet["nome"] ?? "";
      racaController.text = pet["raca"] ?? "";
      idadeController.text = pet["idade"] ?? "";
      condicaoController.text = pet["condicao"] ?? "";
      porteController.text = pet["porte"] ?? "";
      castradoController.text = pet["castrado"] ?? "";

      // Preencher checkboxes de vacina
      _vacinaseRemedios.forEach((key, value) {
        _vacinaseRemedios[key] = pet["vacina"]?.contains(key) ?? false;
      });
    } else {
      nomeController.clear();
      racaController.clear();
      idadeController.clear();
      condicaoController.clear();
      porteController.clear();
      castradoController.clear();
      _vacinaseRemedios.updateAll((key, value) => false);
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              pet == null ? "Adicionar Pet" : "Editar Pet",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  _campoTexto("Nome", nomeController),
                  _campoTexto("Raça", racaController),
                  _campoTexto("Idade", idadeController),
                  _campoTexto("Condição Especial", condicaoController),
                  _campoTexto("Porte", porteController),
                  const SizedBox(height: 12),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Vacinas e Remédios',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  _campoTexto("Castrado", castradoController),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Concatenar vacinas selecionadas
                  final vacinasSelecionadas = _vacinaseRemedios.entries
                      .where((e) => e.value)
                      .map((e) => e.key)
                      .join(", ");

                  setState(() {
                    if (pet == null) {
                      pets.add({
                        "nome": nomeController.text,
                        "raca": racaController.text,
                        "idade": idadeController.text,
                        "condicao": condicaoController.text,
                        "porte": porteController.text,
                        "vacina": vacinasSelecionadas,
                        "castrado": castradoController.text,
                      });
                    } else {
                      pets[index!] = {
                        "nome": nomeController.text,
                        "raca": racaController.text,
                        "idade": idadeController.text,
                        "condicao": condicaoController.text,
                        "porte": porteController.text,
                        "vacina": vacinasSelecionadas,
                        "castrado": castradoController.text,
                      };
                    }
                  });

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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
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
                  Text(
                    "Nome: ${pet["nome"]}",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Raça: ${pet["raca"]}"),
                  Text("Idade: ${pet["idade"]}"),
                  Text("Condição Especial: ${pet["condicao"]}"),
                  Text("Porte: ${pet["porte"]}"),
                  Text("Vacinação: ${pet["vacina"]}"),
                  Text("Castrado: ${pet["castrado"]}"),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _abrirDialog(pet: pet, index: index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            pets.removeAt(index);
                          });
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
