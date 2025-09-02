import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTutorpetWidget extends StatefulWidget {
  const HomeTutorpetWidget({super.key});

  @override
  State<HomeTutorpetWidget> createState() => _HomeTutorpetWidgetState();
}

class _HomeTutorpetWidgetState extends State<HomeTutorpetWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFFFFBE4),
        appBar: AppBar(
          backgroundColor: const Color(0xFFB1F3A3),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.account_circle, color: Color(0xFF074800)),
            onPressed: () {
              // Ação de perfil
            },
          ),
          title: Text(
            'Home',
            style: GoogleFonts.interTight(
              color: const Color(0xFF074800),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.0,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_active, color: Color(0xFF074800)),
              onPressed: () {
                // Ação de notificações
              },
            ),
          ],
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 28),
                _buildDogWalkerCard(),
                _buildDogWalkerCard(),
                _buildDogWalkerCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDogWalkerCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFFF9238),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(Icons.location_history, color: Colors.white, size: 90),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome do dogwalker',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Descrição do dogwalker',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Valor: 00,00',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          print('Botão Visualizar pressionado');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0F5100),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: Text(
                          'Visualizar',
                          style: GoogleFonts.interTight(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
