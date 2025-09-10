import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Feedback_tutorScreen extends StatefulWidget {
  const Feedback_tutorScreen({super.key});

  @override
  State<Feedback_tutorScreen> createState() => _Feedback_tutorScreenState();
}

class _Feedback_tutorScreenState extends State<Feedback_tutorScreen> {
  final TextEditingController feedbackController = TextEditingController();
  double rating = 0;

  // Exemplo de relatórios do Dogwalker
  final List<Map<String, String>> passeios = [
    {
      "titulo": "Passeio da manhã",
      "detalhes": "O pet teve um passeio tranquilo...",
    },
    {
      "titulo": "Passeio da tarde",
      "detalhes": "O pet correu bastante e se divertiu...",
    },
    {
      "titulo": "Passeio da noite",
      "detalhes": "Passeio finalizado com sucesso...",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0), // Fundo laranja claro
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9500), // Laranja
        title: const Text(
          'Feedback',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView(
          children: [
            Text(
              'Passeio',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Campo de feedback
            TextField(
              controller: feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Escrever feedback:',
                filled: true,
                fillColor: const Color(0xFFFFF0C2), // Laranja claro
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Avaliação com estrelas
            Row(
              children: [
                const Text(
                  'Avalie o Dogwalker: ',
                  style: TextStyle(fontSize: 16),
                ),
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 28,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xFFFF9500),
                  ),
                  onRatingUpdate: (r) {
                    setState(() {
                      rating = r;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Cards expansíveis dos passeios
            ...passeios.map((passeio) {
              return Card(
                color: const Color(0xFFFFF0C2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ExpansionTile(
                  title: Text(
                    passeio["titulo"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Detalhes do passeio:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            passeio["detalhes"]!,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF9500),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              // Aqui você pode abrir outra tela ou modal com mais informações do relatório
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(passeio["titulo"]!),
                                    content: Text(passeio["detalhes"]!),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Fechar"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text("Ver Relatório"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
