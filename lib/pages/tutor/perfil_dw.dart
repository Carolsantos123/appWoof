import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilDw_tutorScreen extends StatelessWidget {
  const PerfilDw_tutorScreen({super.key});

  // Widget para mostrar informações já existentes
  Widget _campoVisualizacao(String texto) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFEECFC2), // mesma cor do print
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        texto,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER LARANJA
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFFF9500),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  // Linha com botão voltar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context); // volta para a tela anterior
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFFFF8C3E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Nome do dogwalker",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _infoBox("0", "Passeios"),
                      _infoBox("0.00 ★", "Avaliações"),
                      _infoBox("0", "meses"),
                    ],
                  )
                ],
              ),
            ),

            // INFORMAÇÕES DO PERFIL
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  children: [
                    _campoVisualizacao("Experiências anteriores..."),
                    _campoVisualizacao("Agenda disponível..."),
                    _campoVisualizacao("Regiões onde pode fazer passeios..."),
                    _campoVisualizacao("Informações extras..."),
                  ],
                ),
              ),
            ),

            // BOTÃO VERDE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // ação ao clicar
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A6C0A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Solicitar passeio",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para caixinhas de info no header
  Widget _infoBox(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}