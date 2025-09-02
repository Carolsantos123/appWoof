import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HistoricodiaWidget extends StatefulWidget {

  final DateTime selectedDate;

  const HistoricodiaWidget({super.key, required this.selectedDate});

  @override
  State<HistoricodiaWidget> createState() => _HistoricodiaWidgetState();
}

class _HistoricodiaWidgetState extends State<HistoricodiaWidget> {
  // Estado para controlar a expansão do card
  bool _isExpanded = false;
  

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat("d 'de' MMMM 'de' y", 'pt_BR').format(widget.selectedDate);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB1F3A3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF074800),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Historico',
          style: GoogleFonts.interTight(
            color: const Color(0xFF074800),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  formattedDate,
                  style: GoogleFonts.interTight(
                    color: const Color(0xFF074800),
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEFB5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      'https://picsum.photos/seed/144/600',
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Nome do dog: xxxxxxxxx',
                                  style: GoogleFonts.interTight(
                                    color: const Color(0xFF074800),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (_isExpanded)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        'Raça: Pitbull',
                                        style: GoogleFonts.interTight(
                                          color: const Color(0xFF074800),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Idade: 5 Anos',
                                        style: GoogleFonts.interTight(
                                          color: const Color(0xFF074800),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Alguma condição especial: sim, xxxxxxx',
                                        style: GoogleFonts.interTight(
                                          color: const Color(0xFF074800),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Porte do dog: Grande',
                                        style: GoogleFonts.interTight(
                                          color: const Color(0xFF074800),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Carteira de vacinação em dia',
                                        style: GoogleFonts.interTight(
                                          color: const Color(0xFF074800),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Não castrado',
                                        style: GoogleFonts.interTight(
                                          color: const Color(0xFF074800),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Horario 00:00',
                                        style: GoogleFonts.interTight(
                                          color: const Color(0xFF074800),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Endereço: xxxxxxxxxxxxx-xxxxxx',
                                        style: GoogleFonts.interTight(
                                          color: const Color(0xFF074800),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Adicione a lógica de navegação para a tela de relatório aqui
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF199700),
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                          child: Text(
                                            'Ver Relatório',
                                            style: GoogleFonts.interTight(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
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