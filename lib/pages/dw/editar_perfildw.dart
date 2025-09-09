import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditarPerfildwScreen extends StatelessWidget {
  const EditarPerfildwScreen({super.key});

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
                      child: const Icon(Icons.person, size: 60, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Campos principais
                  _buildTextField(label: 'Nome', hint: 'Gabriel'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'E-mail', hint: 'gabriel@email.com'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Senha', hint: '********'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'CPF', hint: '123.456.789-00'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Telefone', hint: '(11) 91234-5678'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'CEP', hint: '01234-567'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Rua', hint: 'Rua Saudade'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Bairro', hint: 'Centro'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Número', hint: '120'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Estado', hint: 'SP'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Complemento', hint: 'Casa 5'),

                  const SizedBox(height: 20),

                  // Campos adicionais
                  _buildTextField(label: 'Descrever experiências anteriores com pets', hint: 'Tenho experiência com cães de pequeno e médio porte'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Adicione seus dias e horários disponíveis', hint: 'Seg a Sex - 14h às 18h'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Regiões onde pode fazer passeios', hint: 'Zona Oeste de São Paulo'),
                  const SizedBox(height: 12),
                  _buildTextField(label: 'Informações extras (ex: especializações, técnicas de adestramento)', hint: 'Adestramento positivo, primeiros socorros para pets'),

                  const SizedBox(height: 20),
                  Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Salvar alterações e voltar para a tela de perfil
                          Navigator.pushReplacementNamed(context, '/perfildw_home');
                        },
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

  Widget _buildTextField({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF074800),
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
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
