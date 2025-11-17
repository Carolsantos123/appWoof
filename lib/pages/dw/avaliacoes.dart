import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:woof/models/feedbackModel.dart';

class AvaliacoesScreen extends StatefulWidget {
  const AvaliacoesScreen({super.key});

  @override
  State<AvaliacoesScreen> createState() => _AvaliacoesScreenState();
}

class _AvaliacoesScreenState extends State<AvaliacoesScreen> {
  final Color backgroundColor = const Color(0xFFFFFBE4);
  final Color primaryColor = const Color(0xFF074800);
  final Color appBarColor = const Color.fromARGB(255, 177, 243, 163);
  final Color feedbackCardColor = const Color(0xFFFFEFB5);
  final Color highlightColor = const Color(0xFF0F5100);

  double _mediaAvaliacoes = 0.0;
  List<FeedbackPasseio> _feedbacks = [];

  @override
  void initState() {
    super.initState();
    _carregarFeedbacks();
  }

  Future<void> _carregarFeedbacks() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('feedback')
        .where('id_walker', isEqualTo: user.uid)
        .get();

    final feedbacks = snapshot.docs
        .map((doc) => FeedbackPasseio.fromMap(doc.data(), doc.id))
        .toList();

    double soma = 0.0;
    for (var f in feedbacks) {
      soma += f.avaliacao;
    }

    setState(() {
      _feedbacks = feedbacks;
      _mediaAvaliacoes = feedbacks.isEmpty ? 0.0 : soma / feedbacks.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Avaliações',
          style: GoogleFonts.interTight(
            color: primaryColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _feedbacks.isEmpty
            ? const Center(
                child: Text("Você ainda não recebeu avaliações."),
              )
            : SingleChildScrollView(
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
                        'Sua média de avaliações',
                        style: GoogleFonts.inter(
                          color: primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    RatingBarIndicator(
                      rating: _mediaAvaliacoes,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 35,
                    ),
                    Text(
                      _mediaAvaliacoes.toStringAsFixed(1),
                      style: GoogleFonts.inter(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Feedbacks recebidos',
                          style: GoogleFonts.inter(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    ..._feedbacks.map((fb) => _buildFeedbackCard(fb)).toList(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildFeedbackCard(FeedbackPasseio fb) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: feedbackCardColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.account_circle, size: 40, color: Colors.black54),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBarIndicator(
                    rating: fb.avaliacao,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 18,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    fb.comentario.isNotEmpty
                        ? fb.comentario
                        : 'Sem comentário...',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      fb.data,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
