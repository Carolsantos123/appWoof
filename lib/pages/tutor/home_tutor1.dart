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
      backgroundColor: const Color(0xFFFFFBE4), // fundo claro
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
          'Olá, Ana ',
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
              const SizedBox(height: 16),
              // Card de agendamento de passeio
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9238), // laranja vibrante
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.calendar_today_rounded, color: Colors.white, size: 40),
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
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Agende um passeio com o tutorpet.',
                                style: GoogleFonts.interTight(
                                  fontSize: 14,
                                  color: Colors.white,
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
                            backgroundColor: const Color(0xFFFFA74D), // laranja claro
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
              const SizedBox(height: 16),
              // Card de dogwalker (exemplo)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB366), // laranja médio
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.pets, color: Colors.white, size: 50),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nome do Dogwalker',
                                style: GoogleFonts.interTight(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Descrição breve do dogwalker.',
                                style: GoogleFonts.interTight(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Valor: R\$ 50,00',
                                style: GoogleFonts.interTight(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Ação do botão de visualizar
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF9238),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: Text(
                            'Visualizar',
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
              const SizedBox(height: 16),
              // Você pode adicionar mais cards ou widgets em tom laranja abaixo
            ],
          ),
        ),
      ),
    );
  }
}
