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
                height: 170,
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
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'nublado',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
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
                            '20',
                            style: GoogleFonts.interTight(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '04',
                            style: GoogleFonts.interTight(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // BOTÕES PRINCIPAIS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 75),
                child: GridView.count(
                  shrinkWrap: true, // ajusta altura do GridView para caber no Column
                  physics: const NeverScrollableScrollPhysics(), // remove rolagem do Grid
                  crossAxisCount: 3, // 3 botões por linha
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 1, // botões quadrados
                  children: [
                    _buildLargeButton('Notificações', Icons.notifications, () {
                      Navigator.pushNamed(context, '/notificacoes');
                    }),
                    _buildLargeButton('Perfil', Icons.account_circle, () {
                      Navigator.pushNamed(context, '/perfil');
                    }),
                    _buildLargeButton('Feedback', Icons.location_on, () {
                      Navigator.pushNamed(context, '/feedback');
                    }),
                    _buildLargeButton('Meus Pets', Icons.pets, () {
                      Navigator.pushNamed(context, '/meus_pets');
                    }),
                    _buildLargeButton('Passeio', Icons.directions_walk, () {
                      Navigator.pushNamed(context, '/passeios');
                    }),
                    _buildLargeButton('Histórico', Icons.history, () {
                      Navigator.pushNamed(context, '/historico');
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
                                    color: const Color(0xFF0F5100),
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
                              Navigator.pushNamed(context, '/perfil_dw');
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

  Widget _buildLargeButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFF9500),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 50),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
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
