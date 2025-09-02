import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditarPerfilScreen extends StatelessWidget {
  const EditarPerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF9E6),
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
                  _buildTextField(label: 'Nome', hint: 'Gabriel'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'E-mail', hint: 'gabriel@email.com'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Endereço', hint: 'Rua Saudade, 120, casa 5'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Telefone', hint: '(11) 91234-5678'),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Ação para salvar as alterações
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF199700),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        minimumSize: const Size(double.infinity, 40),
                        elevation: 0,
                      ),
                      child: Text(
                        'Salvar Alterações',
                        style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
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

  Widget _buildTextField({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF074800),
            ),
            filled: true,
            fillColor: Colors.white, // Padronizado com PerfilTutorWidget
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(color: Color(0xFF199700), width: 1.0),
            ),
          ),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ],
    );
  }
}
