import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilTutorScreen extends StatelessWidget {
  const PerfilTutorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB1F3A3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF074800)),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'Gabriel',
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
                    '3 passeios',
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
                _buildInfoRow('Nome:', 'Gabriel'),
                _buildInfoRow('E-mail:', 'gabriel@email.com'),
                _buildInfoRow('Endereço:', 'Rua Saudade, 120, casa 5'),
                _buildInfoRow('Telefone:', '(11) 91234-5678'),
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
                _buildPetCard(
                  name: 'Bruce',
                  breed: 'Cachorro',
                  onTap: () {
                    // Ação de navegar para o perfil do pet
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Ação do botão
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF199700),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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

  Widget _buildPetCard({required String name, required String breed, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
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
              const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFF989898)),
            ],
          ),
        ),
      ),
    );
  }
}
