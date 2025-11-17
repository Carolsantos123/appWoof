import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificacoesTutorScreen extends StatefulWidget {
  const NotificacoesTutorScreen({super.key});

  @override
  State<NotificacoesTutorScreen> createState() =>
      _NotificacoesTutorScreenState();
}

class _NotificacoesTutorScreenState extends State<NotificacoesTutorScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

  Stream<List<Map<String, dynamic>>> _getNotificacoesStream() {
    if (_idCliente == null) return const Stream.empty();

    return _firestore
        .collection('passeios')
        .where('id_cliente', isEqualTo: _idCliente)
        .where('id_walker', isNotEqualTo: '')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'nome_pet': data['nome_pet'] ?? '',
          'data': data['data'] ?? '',
          'id_walker': data['id_walker'] ?? '',
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9500),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Notificações',
          style: GoogleFonts.interTight(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _idCliente == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<Map<String, dynamic>>>(
              stream: _getNotificacoesStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhuma nova notificação.',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                final notificacoes = snapshot.data!;

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: notificacoes.length,
                        itemBuilder: (context, index) {
                          final notif = notificacoes[index];
                          return _buildNotificationCard(
                            "O passeio com ${notif['nome_pet']} foi aceito!",
                            notif['data'],
                          );
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Fim das notificações',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF989898),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Widget _buildNotificationCard(String texto, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFFFE0CC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.notifications_active,
                color: Color(0xFFFF9500),
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      texto,
                      style: GoogleFonts.interTight(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Data: $data",
                      style: GoogleFonts.interTight(
                        fontSize: 12,
                        color: Colors.black54,
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
}
