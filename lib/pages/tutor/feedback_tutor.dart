import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackTutorScreen extends StatefulWidget {
  const FeedbackTutorScreen({super.key});

  @override
  State<FeedbackTutorScreen> createState() => _FeedbackTutorScreenState();
}

class _FeedbackTutorScreenState extends State<FeedbackTutorScreen> {
  final TextEditingController feedbackController = TextEditingController();
  double rating = 0;

  final List<Map<String, String>> passeios = [
    {
      "data": "22/04/2025",
      "dogwalker": "Ana Carolina",
      "pet": "Rex",
      "horario": "18h30",
    },
    {
      "data": "20/04/2025",
      "dogwalker": "Bruno Silva",
      "pet": "Luna",
      "horario": "14h50",
    },
    {
      "data": "18/04/2025",
      "dogwalker": "Carla Mendes",
      "pet": "Thor",
      "horario": "09h15",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9500),
        title: Text(
          'Feedback',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            ...passeios.map((passeio) {
              return Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ${passeio["data"]}",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.person,
                              size: 18, color: Colors.orange),
                          const SizedBox(width: 6),
                          Text("Dogwalker: ${passeio["dogwalker"]}"),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.pets,
                              size: 18, color: Colors.orange),
                          const SizedBox(width: 6),
                          Text("Pet: ${passeio["pet"]}"),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.place,
                              size: 18, color: Colors.orange),
                          const SizedBox(width: 6),
                          Text("Horario: ${passeio["horario"]}"),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFFFF9500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            _abrirRelatorio(passeio);
                          },
                          icon: const Icon(Icons.feedback, size: 20),
                          label: const Text("Ver Relatório"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _abrirRelatorio(Map<String, String> passeio) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                " ${passeio["data"]}",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dogwalker: ${passeio["dogwalker"]}"),
                    Text("Pet: ${passeio["pet"]}"),
                    Text("Horário: ${passeio["horario"]}"),
                    const Divider(height: 24, thickness: 1),
                    const Text(
                      "Avalie o passeio:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color(0xFFFF9500),
                      ),
                      onRatingUpdate: (r) {
                        setStateDialog(() {
                          rating = r;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: feedbackController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Escreva seu feedback...',
                        filled: true,
                        fillColor: const Color(0xFFFFF3E0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancelar"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9500),
                  ),
                  onPressed: () {
                    print("Feedback salvo: ${feedbackController.text}");
                    print("Nota: $rating");
                    Navigator.of(context).pop();
                    feedbackController.clear();
                  },
                  child: const Text("Salvar"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
