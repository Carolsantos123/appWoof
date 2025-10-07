import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/clienteModel.dart'; // ajuste o caminho conforme seu projeto

class PerfilTutorScreen extends StatefulWidget {
  const PerfilTutorScreen({super.key});

  @override
  State<PerfilTutorScreen> createState() => _PerfilTutorScreenState();
}

class _PerfilTutorScreenState extends State<PerfilTutorScreen> {
  final user = FirebaseAuth.instance.currentUser;
  Cliente? cliente;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarDadosCliente();
  }

  Future<void> carregarDadosCliente() async {
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
      setState(() => carregando = false);
      debugPrint('Erro ao carregar cliente: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'Perfil Tutor',
          style: GoogleFonts.interTight(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF074800),
          ),
        ),
        centerTitle: true,
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF199700)))
          : cliente == null
              ? const Center(child: Text('Nenhum cliente encontrado.'))
              : SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              image: cliente!.foto.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(cliente!.foto),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: cliente!.foto.isEmpty
                                ? const Icon(Icons.person, size: 60, color: Colors.white)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            cliente!.nomeCompleto,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF074800),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            '${cliente!.pets.length} pets cadastrados',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xFF989898),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Informações',
                          style: GoogleFonts.interTight(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF074800),
                          ),
                        ),
                        const SizedBox(height: 12),

                        _buildInfoRow('Nome:', cliente!.nomeCompleto),
                        _buildInfoRow('E-mail:', cliente!.email),
                        _buildInfoRow(
                          'Endereço:',
                          '${cliente!.rua}, ${cliente!.numero}, ${cliente!.bairro}, ${cliente!.estado}',
                        ),
                        _buildInfoRow('CEP:', cliente!.cep),
                        _buildInfoRow(
                          'Telefone:',
                          cliente!.telefone.toString(),
                        ),
                        if (cliente!.complemento != null &&
                            cliente!.complemento!.isNotEmpty)
                          _buildInfoRow('Complemento:', cliente!.complemento!),

                        const SizedBox(height: 20),
                        Text(
                          'Pets',
                          style: GoogleFonts.interTight(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF074800),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Lista dinâmica de pets
                        if (cliente!.pets.isEmpty)
                          Text(
                            'Nenhum pet cadastrado ainda.',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xFF6E6E6E),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cliente!.pets.length,
                            itemBuilder: (context, index) {
                              final pet = cliente!.pets[index];
                              return _buildPetCard(
                                name: pet.nomePet,
                                breed: pet.raca,
                                onTap: () {
                                  // ação ao clicar no pet
                                },
                              );
                            },
                          ),

                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Exemplo de ação
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF199700),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              minimumSize: const Size(double.infinity, 40),
                              elevation: 0,
                            ),
                            child: Text(
                              'Iniciar passeios',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
    );
  }

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

  Widget _buildPetCard({
    required String name,
    required String breed,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFB1F3A3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.interTight(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF074800),
                    ),
                  ),
                  Text(
                    breed,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFF6E6E6E),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios,
                  size: 18, color: Color(0xFF989898)),
            ],
          ),
        ),
      ),
    );
  }
}
