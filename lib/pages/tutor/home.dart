import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTutorpetScreen extends StatefulWidget {
  const HomeTutorpetScreen({super.key});

  @override
  State<HomeTutorpetScreen> createState() => _HomeTutorpetScreenState();
}

class _HomeTutorpetScreenState extends State<HomeTutorpetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFBE4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.person, color: Color(0xFF074800)),
          onPressed: () {
            // Ação do botão de perfil
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_rounded, color: Color(0xFF074800)),
            onPressed: () {
              // Ação do botão de notificação
            },
          ),
        ],
        title: Text(
          'Olá, Gabriel',
          style: GoogleFonts.interTight(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF074800),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Card de resumo semanal
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Resumo Semanal',
                          style: GoogleFonts.interTight(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF074800),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Passeios',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xFF989898),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '10',
                              style: GoogleFonts.interTight(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF074800),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Ganhos',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xFF989898),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'R\$ 250,00',
                              style: GoogleFonts.interTight(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF074800),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Card de agendamento de passeio
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB1F3A3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.calendar_today_rounded, color: Color(0xFF074800), size: 40),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Agende um passeio',
                                style: GoogleFonts.interTight(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF074800),
                                ),
                              ),
                              Text(
                                'Agende um passeio com o tutorpet.',
                                style: GoogleFonts.interTight(
                                  fontSize: 14,
                                  color: const Color(0xFF074800),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Ação do botão de agendar
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF44BB33),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: Text(
                            'Agendar',
                            style: GoogleFonts.interTight(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
