import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Tela principal para cadastrar um tutor
class CadastroTutorPage extends StatefulWidget {
  const CadastroTutorPage({super.key});

  @override
  State<CadastroTutorPage> createState() => _CadastroTutorPageState();
}

class _CadastroTutorPageState extends State<CadastroTutorPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  /// Função que cadastra o tutor no Firestore
  Future<void> _cadastrarTutor() async {
    try {
      // Dados do tutor
      final tutorData = {
        "nome": _nomeController.text,
        "telefone": _telefoneController.text,
        "dataCadastro": DateTime.now(),
      };

      // Salva na coleção "clientes" e pega o ID do documento
      final docRef =
          await FirebaseFirestore.instance.collection("clientes").add(tutorData);

      final clienteId = docRef.id; // <-- Aqui temos o ID do tutor

      // Depois de cadastrar, abrimos a tela de cadastro de pet
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CadastroPetScreen(clienteId: clienteId),
        ),
      );
    } catch (e) {
      // Mostra erro caso não consiga salvar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao cadastrar tutor: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro de Tutor")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: "Nome do Tutor"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _telefoneController,
              decoration: const InputDecoration(labelText: "Telefone"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cadastrarTutor,
              child: const Text("Cadastrar Tutor"),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tela de cadastro do Pet
class CadastroPetScreen extends StatefulWidget {
  final String clienteId; // 🔗 ID do tutor recebido da tela anterior

  const CadastroPetScreen({super.key, required this.clienteId});

  @override
  State<CadastroPetScreen> createState() => _CadastroPetScreenState();
}

class _CadastroPetScreenState extends State<CadastroPetScreen> {
  final TextEditingController _nomePetController = TextEditingController();
  final TextEditingController _racaController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();

  /// Função que cadastra o pet no Firestore, dentro do tutor
  Future<void> _cadastrarPet() async {
    try {
      // Dados do pet
      final petData = {
        "nome_pet": _nomePetController.text,
        "raca": _racaController.text,
        "idade": int.tryParse(_idadeController.text) ?? 0,
        "dataCadastro": DateTime.now(),
        "clienteId": widget.clienteId, // 🔗 referência do tutor
      };

      // Salva dentro da subcoleção do tutor
      await FirebaseFirestore.instance
          .collection("clientes")
          .doc(widget.clienteId)
          .collection("pets")
          .add(petData);

      // Volta para a tela anterior
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pet cadastrado com sucesso!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao cadastrar pet: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro de Pet")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomePetController,
              decoration: const InputDecoration(labelText: "Nome do Pet"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _racaController,
              decoration: const InputDecoration(labelText: "Raça"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _idadeController,
              decoration: const InputDecoration(labelText: "Idade"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cadastrarPet,
              child: const Text("Cadastrar Pet"),
            ),
          ],
        ),
      ),
    );
  }
}
