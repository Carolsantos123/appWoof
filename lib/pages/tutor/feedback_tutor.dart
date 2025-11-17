import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/feedbackModel.dart';
import '../../models/passeioModel.dart';

class FeedbackTutorScreen extends StatefulWidget {
  const FeedbackTutorScreen({super.key});

  @override
  State<FeedbackTutorScreen> createState() => _FeedbackTutorScreenState();
}

class _FeedbackTutorScreenState extends State<FeedbackTutorScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController feedbackController = TextEditingController();
  double rating = 0;

  String? _idCliente;

  @override
  void initState() {
    super.initState();
    _buscarIdCliente();
  }

  Future<void> _buscarIdCliente() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    final snapshot = await _firestore
        .collection('clientes')
        .where('uid_user', isEqualTo: uid)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      setState(() {
        _idCliente = snapshot.docs.first.id;
      });
    }
  }

  /// Busca todos os passeios concluídos que ainda não têm feedback
  Stream<List<Passeio>> _getPasseiosConcluidosSemFeedback() {
    if (_idCliente == null) return const Stream.empty();

    return _firestore
        .collection('passeios')
        .where('id_cliente', isEqualTo: _idCliente)
        .where('concluido', isEqualTo: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final allPasseios = snapshot.docs
          .map((doc) => Passeio.fromMap(doc.data(), doc.id))
          .toList();

      final feedbacks = await _firestore
          .collection('feedback')
          .where('id_cliente', isEqualTo: _idCliente)
          .get();

      final feedbackIds =
          feedbacks.docs.map((doc) => doc['id_passeio'] as String).toSet();

      // Retorna apenas os que não têm feedback ainda
      return allPasseios
          .where((p) => !feedbackIds.contains(p.passeioID))
          .toList();
    });
  }

  void _abrirFeedbackDialog(Passeio passeio) {
    showDialog(
      context: context,
      builder: (context) {
        double localRating = 0;
        final localController = TextEditingController();

        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: const Color(0xFFFFFBE4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Avaliar Passeio',
                style: GoogleFonts.interTight(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF074800)),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pet: ${passeio.nomePet}'),
                    Text('Data: ${passeio.data}'),
                    const SizedBox(height: 12),
                    const Text(
                      'Avalie o passeio:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color(0xFFFF9500),
                      ),
                      onRatingUpdate: (r) {
                        setStateDialog(() {
                          localRating = r;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: localController,
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
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9500),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (localRating == 0 || localController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Preencha a nota e o comentário!'),
                        backgroundColor: Colors.redAccent,
                      ));
                      return;
                    }

                    final feedback = FeedbackPasseio(
                      feedbackID: _firestore.collection('feedback').doc().id,
                      avaliacao: localRating,
                      comentario: localController.text,
                      data: DateTime.now().toString().split(' ')[0],
                      idCliente: _idCliente!,
                      idPasseio: passeio.passeioID,
                      idWalker: passeio.idWalker,
                    );

                    await _firestore
                        .collection('feedback')
                        .doc(feedback.feedbackID)
                        .set(feedback.toMap());

                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Feedback enviado com sucesso!'),
                      backgroundColor: Colors.green,
                    ));
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCard(Passeio passeio) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              passeio.data,
              style: GoogleFonts.interTight(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.pets, size: 18, color: Colors.orange),
                const SizedBox(width: 6),
                Text("Pet: ${passeio.nomePet}"),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.place, size: 18, color: Colors.orange),
                const SizedBox(width: 6),
                Text("Bairro: ${passeio.bairro}"),
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
                onPressed: () => _abrirFeedbackDialog(passeio),
                icon: const Icon(Icons.feedback, size: 20),
                label: const Text("Dar feedback"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9500),
        title: Text(
          'Feedback dos Passeios',
          style: GoogleFonts.interTight(
            color: const Color(0xFFFFFBE4),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: _idCliente == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<Passeio>>(
              stream: _getPasseiosConcluidosSemFeedback(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'Nenhum passeio concluído pendente de feedback.',
                      style: GoogleFonts.interTight(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final passeios = snapshot.data!;
                return ListView.builder(
                  itemCount: passeios.length,
                  itemBuilder: (context, index) {
                    return _buildCard(passeios[index]);
                  },
                );
              },
            ),
    );
  }
}
