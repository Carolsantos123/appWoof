import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilDwhomeScreen extends StatelessWidget {
  const PerfilDwhomeScreen({super.key});

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
                    'Mariana Silva',
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
                    '12 passeios concluídos',
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
                _buildInfoRow('Nome:', 'Mariana Silva'),
                _buildInfoRow('E-mail:', 'mariana.dw@email.com'),
                _buildInfoRow('Telefone:', '(11) 98765-4321'),
                _buildInfoRow('CPF:', '123.456.789-00'),
                _buildInfoRow('Endereço:', 'Av. Central, 300 - Apto 12'),
                const SizedBox(height: 20),
                Text(
                  'Experiência',
                  style: GoogleFonts.interTight(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF074800),
                  ),
                ),
                const SizedBox(height: 12),
                _buildTextBox(
                  '2 anos de experiência com passeios e cuidados de cães de pequeno e médio porte. '
                  'Treinamento básico e primeiros socorros para pets.',
                ),
                const SizedBox(height: 20),
                Text(
                  'Disponibilidade',
                  style: GoogleFonts.interTight(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF074800),
                  ),
                ),
                const SizedBox(height: 12),
                _buildTextBox('Segunda a sexta - manhã e tarde'),
                const SizedBox(height: 20),
                Text(
                  'Regiões atendidas',
                  style: GoogleFonts.interTight(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF074800),
                  ),
                ),
                const SizedBox(height: 12),
                _buildTextBox('Zona Oeste e Zona Sul de São Paulo'),
                const SizedBox(height: 40),

                /// 🔹 Botão de Editar Informações
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F5100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
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
