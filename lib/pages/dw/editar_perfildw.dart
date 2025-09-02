import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditarPerfilDwScreen extends StatelessWidget {
  const EditarPerfilDwScreen({super.key});

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
            'Editar Perfil DogWalker',
            style: GoogleFonts.interTight(
              fontSize: 24,
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
                      child: const Icon(Icons.add_a_photo, size: 36, color: Color(0xFF074800)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(label: 'Nome completo', hint: 'Ana Carolina Santos'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'E-mail', hint: 'ana@email.com'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Telefone', hint: '(11) 98765-4321'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Endereço', hint: 'Rua dos Animais, 45, Apt 12'),
                  const SizedBox(height: 20),
                  const Text(
                    'Experiências e Informações',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF074800),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Experiências com pets', hint: 'Cuidados com cães e gatos, passeios diários', maxLines: 3),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Dias e horários disponíveis', hint: 'Seg a Sex, 8h às 18h', maxLines: 2),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Regiões que atende', hint: 'Zona Sul e Centro', maxLines: 2),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Valor do passeio por hora', hint: 'R\$ 40', maxLines: 1),
                  const SizedBox(height: 12),
                  _buildTextField(
                      label: 'Informações extras',
                      hint: 'Possuo treinamento em adestramento básico e primeiros socorros para pets',
                      maxLines: 3),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF199700),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        minimumSize: const Size(double.infinity, 40),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Salvar Alterações',
                        style: TextStyle(
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

  Widget _buildTextField({required String label, required String hint, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF074800),
            ),
            filled: true,
            fillColor: Colors.white,
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
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF074800),
          ),
        ),
      ],
    );
  }
}
