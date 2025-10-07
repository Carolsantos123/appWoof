import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/models/walkerModel.dart'; // ✅ Importa seu model

class EditarPerfildwScreen extends StatefulWidget {
  const EditarPerfildwScreen({super.key});

  @override
  State<EditarPerfildwScreen> createState() => _EditarPerfildwScreenState();
}

class _EditarPerfildwScreenState extends State<EditarPerfildwScreen> {
  final _formKey = GlobalKey<FormState>();
  final User? user = FirebaseAuth.instance.currentUser;

  bool carregando = true;
  Walker? walker;

  // Controladores
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();
  final telefoneController = TextEditingController();
  final cepController = TextEditingController();
  final ruaController = TextEditingController();
  final bairroController = TextEditingController();
  final numeroController = TextEditingController();
  final estadoController = TextEditingController();
  final complementoController = TextEditingController();
  final experienciaController = TextEditingController();
  final disponibilidadeController = TextEditingController();
  final regioesController = TextEditingController();
  final extraController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarWalker();
  }

  Future<void> carregarWalker() async {
    if (user == null) return;

    final query = await FirebaseFirestore.instance
        .collection('walkers')
        .where('uid_user', isEqualTo: user!.uid)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      setState(() {
        walker = Walker.fromMap(doc.data(), doc.id);
        preencherCampos(walker!);
        carregando = false;
      });
    } else {
      setState(() => carregando = false);
    }
  }

  void preencherCampos(Walker w) {
    nomeController.text = w.nomeCompleto;
    emailController.text = w.email;
    cpfController.text = w.cpf;
    telefoneController.text = w.telefone;
    cepController.text = w.cep;
    ruaController.text = w.rua;
    bairroController.text = w.bairro;
    numeroController.text = w.numero.toString();
    estadoController.text = w.estado;
    complementoController.text = w.complemento ?? '';
    experienciaController.text = w.addExperienciasAnteriores;
    disponibilidadeController.text = w.disponibilidades;
    regioesController.text = w.localizacaoPasseios;
    extraController.text = w.extra ?? '';
  }

  Future<void> salvarAlteracoes() async {
    if (walker == null || user == null) return;

    // Atualiza o objeto local
    walker = Walker(
      walkerID: walker!.walkerID,
      addExperienciasAnteriores: experienciaController.text.trim(),
      bairro: bairroController.text.trim(),
      cep: cepController.text.trim(),
      complemento: complementoController.text.trim(),
      cpf: cpfController.text.trim(),
      dataNascimento: walker!.dataNascimento, // Mantém o existente
      disponibilidades: disponibilidadeController.text.trim(),
      email: emailController.text.trim(),
      estado: estadoController.text.trim(),
      extra: extraController.text.trim(),
      foto: walker!.foto,
      localizacaoPasseios: regioesController.text.trim(),
      nomeCompleto: nomeController.text.trim(),
      numero: int.tryParse(numeroController.text.trim()) ?? 0,
      rua: ruaController.text.trim(),
      telefone: telefoneController.text.trim(),
      uidUser: walker!.uidUser,
    );

    try {
      await FirebaseFirestore.instance
          .collection('walkers')
          .doc(walker!.walkerID)
          .update(walker!.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );

      Navigator.pushReplacementNamed(context, '/perfildw_home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF9E6),
        appBar: AppBar(
          backgroundColor: const Color(0xFFB1F3A3),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF074800)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Editar Perfil',
            style: GoogleFonts.interTight(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF074800),
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Icon(Icons.person, size: 60, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildTextField('Nome', nomeController),
                  _buildTextField('E-mail', emailController),
                  _buildTextField('CPF', cpfController),
                  _buildTextField('Telefone', telefoneController),
                  _buildTextField('CEP', cepController),
                  _buildTextField('Rua', ruaController),
                  _buildTextField('Bairro', bairroController),
                  _buildTextField('Número', numeroController),
                  _buildTextField('Estado', estadoController),
                  _buildTextField('Complemento', complementoController),

                  const SizedBox(height: 20),

                  _buildTextField('Experiências anteriores', experienciaController),
                  _buildTextField('Disponibilidades', disponibilidadeController),
                  _buildTextField('Regiões de passeio', regioesController),
                  _buildTextField('Informações extras', extraController),

                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: salvarAlteracoes,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF199700),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        minimumSize: const Size(double.infinity, 40),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Salvar Alterações',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF074800))),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: const BorderSide(color: Color(0xFF199700), width: 1.0),
              ),
            ),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF074800),
            ),
          ),
        ],
      ),
    );
  }
}
