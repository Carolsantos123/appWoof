import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AvaliacoesScreen extends StatefulWidget {
  const AvaliacoesScreen({super.key});

  @override
  State<AvaliacoesScreen> createState() => _AvaliacoesScreenState();
}

class _AvaliacoesScreenState extends State<AvaliacoesScreen> {
  // A cor de fundo da tela
  final Color backgroundColor = const Color(0xFFFFFBE4);
  // A cor principal usada para textos e ícones
  final Color primaryColor = const Color(0xFF074800);
  // A cor do fundo da AppBar
  final Color appBarColor = const Color(0xFFB1F3A3);
  // A cor de fundo dos cards de feedback
  final Color feedbackCardColor = const Color(0xFFFFEFB5);
  // A cor de destaque para o texto e ícones
  final Color highlightColor = const Color(0xFF0F5100);

  double _rating = 4.0; // Valor inicial da avaliação

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Avaliações',
          style: GoogleFonts.interTight(
            color: primaryColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Icon(
                  Icons.star_half_rounded,
                  color: highlightColor,
                  size: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Suas Avaliações',
                  style: GoogleFonts.inter(
                    color: primaryColor,
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star_rounded,
                  color: Colors.black,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _rating.toStringAsFixed(1), // Exibe a avaliação com uma casa decimal
                  style: GoogleFonts.inter(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 40, 0, 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Feedbacks',
                    style: GoogleFonts.inter(
                      color: primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              _buildFeedbackCard(
                'Ótimo atendimento, super cuidadoso e atencioso, cumpre os horários e tem um carinho especial pelos cães',
              ),
              _buildFeedbackCard(
                'Muito bom, meu cãozinho adorou!',
              ),
              _buildFeedbackCard(
                'Serviço excelente, recomendo a todos.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackCard(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: feedbackCardColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                Icons.account_circle,
                color: primaryColor,
                size: 40,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
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