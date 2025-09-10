import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTutorScreen extends StatelessWidget {
  const HomeTutorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              // APP BAR CUSTOMIZADA
              Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF9500),
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
                      // Clima
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '22º C',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'nublado',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      // Data
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '20/06/2024',
                            style: GoogleFonts.interTight(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'quinta-feira',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // BOTÕES PRINCIPAIS (MODIFICADOS)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 75),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 32,
                  crossAxisSpacing: 32,
                  childAspectRatio: 1,
                  children: [
                    _buildLargeButton('Passeio', Icons.directions_walk, () {
                      Navigator.pushNamed(context, '/passeios_tutor');
                    }),
                    _buildLargeButton('Feedback', Icons.location_on, () {
                      Navigator.pushNamed(context, '/feedback_tutor');
                    }),
                    _buildLargeButton('histórico', Icons.history, () {
                      Navigator.pushNamed(context, '/historico_tutor');
                    }),
                    _buildLargeButton('Notificações', Icons.notifications, () {
                      Navigator.pushNamed(context, '/notificacoes_tutor');
                    }),
                    _buildLargeButton('Meus Pets',  Icons.pets , () {
                      Navigator.pushNamed(context, '/perfil_pet');
                    }),
                    _buildLargeButton('Perfil', Icons.account_circle, () {
                      Navigator.pushNamed(context, '/perfil_tutor');
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Barra de pesquisa
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5C2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Pesquisar dogwalker',
                      prefixIcon: Icon(Icons.search, color: Color(0xFF0F5100)),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Sugestões
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sugestões',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F5100),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF5C2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xFFD9D9D9),
                            child: Icon(Icons.account_circle, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nome do dogwalker',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Color(0xFF0F5100),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < 4 ? Icons.star : Icons.star_border,
                                      color: Colors.orange,
                                      size: 14,
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/perfildw_tutor');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F5100),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              elevation: 0,
                            ),
                            child: Text(
                              'Ver',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // BOTÕES COM TAMANHO REDUZIDO
  Widget _buildLargeButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFF9500),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40), // ícone menor
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14, // texto menor
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
