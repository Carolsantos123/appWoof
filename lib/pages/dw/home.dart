import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              height: 170,
              decoration: const BoxDecoration(
                color: Color(0xFFB1F3A3),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Coluna da esquerda: Temperatura, Nublado e Ícone de Perfil
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '22º C',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0F5100),
                            fontSize: 28,
                          ),
                        ),
                        Text(
                          'nublado',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0F5100),
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        IconButton(
                          icon: const Icon(
                            Icons.account_circle,
                            color: Color(0xFF0F5100),
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/perfildw_home');
                          },
                        ),
                      ],
                    ),
                    // Coluna da direita: Data
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '20',
                          style: GoogleFonts.interTight(
                            color: const Color(0xFF0F5100),
                            fontSize: 45,
                          ),
                        ),
                        Text(
                          '04',
                          style: GoogleFonts.interTight(
                            color: const Color(0xFF0F5100),
                            fontSize: 45,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // BOTÕES COM ROLAGEM VERTICAL E 2 COLUNAS
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildButton(Icons.calendar_month_sharp, 'Agenda', onTap: () {
                      Navigator.pushNamed(context, '/agenda');
                    }),
                    _buildButton(Icons.doorbell_rounded, 'Notificação', onTap: () {
                      Navigator.pushNamed(context, '/notificacoes');
                    }),
                    _buildButton(Icons.star_half, 'Avaliação', onTap: () {
                      Navigator.pushNamed(context, '/avaliacoes');
                    }),
                    _buildButton(Icons.grading_sharp, 'Finanças', onTap: () {
                      Navigator.pushNamed(context, '/financas');
                    }),
                    _buildButton(Icons.person_add, 'Solicitações', onTap: () {
                      Navigator.pushNamed(context, '/solicitacoes');
                    }),
                    _buildButton(Icons.location_on_sharp, 'Histórico', onTap: () {
                      Navigator.pushNamed(context, '/historico_calendario');
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Botão estilizado
  Widget _buildButton(IconData icon, String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: (MediaQuery.of(context).size.width - 48) / 2,
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFB1F3A3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF0F5100),
              size: 78,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 18,
                color: const Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
