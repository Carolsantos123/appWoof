import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/models/walkerModel.dart'; // importa o modelo

class PerfilDwhomeScreen extends StatefulWidget {
  const PerfilDwhomeScreen({super.key});

  @override
  State<PerfilDwhomeScreen> createState() => _PerfilDwhomeScreenState();
}

class _PerfilDwhomeScreenState extends State<PerfilDwhomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  Walker? walker;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarDadosDoFirestore();
  }

  /// 🔹 Carrega o DogWalker logado a partir do Firestore
  Future<void> carregarDadosDoFirestore() async {
    if (user == null) return;

    try {
      final query = await FirebaseFirestore.instance
          .collection('walkers')
          .where('uid_user', isEqualTo: user!.uid)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        final doc = query.docs.first;
        setState(() {
          walker = Walker.fromMap(doc.data(), doc.id);
          carregando = false;
        });
      } else {
        setState(() => carregando = false);
      }
    } catch (e) {
      print('Erro ao carregar dados do Firestore: $e');
      setState(() => carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (walker == null) {
      return const Scaffold(
        body: Center(
          child: Text('Nenhum perfil encontrado.'),
        ),
      );
    }

    // ✅ Usa o model Walker para exibir os dados
    final nome = walker!.nomeCompleto;
    final email = walker!.email.isNotEmpty
        ? walker!.email
        : user?.email ?? 'Sem e-mail';
    final telefone = walker!.telefone.isNotEmpty
        ? walker!.telefone
        : 'Não informado';
    final cpf = walker!.cpf.isNotEmpty ? walker!.cpf : 'Não informado';

    final endereco =
        '${walker!.rua}, ${walker!.numero} - ${walker!.bairro}, ${walker!.estado}, ${walker!.cep}'
        '${walker!.complemento != null && walker!.complemento!.isNotEmpty ? ' (${walker!.complemento})' : ''}';

    final experiencia = walker!.addExperienciasAnteriores.isNotEmpty
        ? walker!.addExperienciasAnteriores
        : 'Sem experiência informada';

    final disponibilidade = walker!.disponibilidades.isNotEmpty
        ? walker!.disponibilidades
        : 'Não informada';

    final regioes = walker!.localizacaoPasseios.isNotEmpty
        ? walker!.localizacaoPasseios
        : 'Nenhuma região cadastrada';

    final totalPasseios = walker!.extra?.isNotEmpty == true
        ? walker!.extra
        : '0';

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB1F3A3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF074800)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Meu perfil',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// 🔹 Foto de perfil
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: walker!.foto.isNotEmpty? CircleAvatar(
                    child: Image.network(walker!.foto)) : Icon(Icons.person),
                  ),
              ),
              const SizedBox(height: 16),

              /// 🔹 Nome
              Center(
                child: Text(
                  nome,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF074800),
                  ),
                ),
              ),

              /// 🔹 Total de passeios
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '$totalPasseios passeios concluídos',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF989898),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// 🔹 Informações
              Text(
                'Informações',
                style: GoogleFonts.interTight(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF074800),
                ),
              ),
              const SizedBox(height: 12),
              _buildInfoRow('Nome:', nome),
              _buildInfoRow('E-mail:', email),
              _buildInfoRow('Telefone:', telefone),
              _buildInfoRow('CPF:', cpf),
              _buildInfoRow('Endereço:', endereco),

              const SizedBox(height: 20),

              /// 🔹 Experiência
              Text(
                'Experiência',
                style: GoogleFonts.interTight(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF074800),
                ),
              ),
              const SizedBox(height: 12),
              _buildTextBox(experiencia),

              const SizedBox(height: 20),

              /// 🔹 Disponibilidade
              Text(
                'Disponibilidade',
                style: GoogleFonts.interTight(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF074800),
                ),
              ),
              const SizedBox(height: 12),
              _buildTextBox(disponibilidade),

              const SizedBox(height: 20),

              /// 🔹 Regiões
              Text(
                'Regiões atendidas',
                style: GoogleFonts.interTight(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF074800),
                ),
              ),
              const SizedBox(height: 12),
              _buildTextBox(regioes),

              const SizedBox(height: 40),

              /// 🔹 Botão Editar
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F5100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: Text(
                    "Editar Informações",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/editar_perfildw');
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔸 Widget auxiliar para exibir informações simples
  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFF6E6E6E),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF074800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔸 Caixa de texto para blocos maiores
  Widget _buildTextBox(String text) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFB1F3A3),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xFF074800),
        ),
      ),
    );
  }
}
