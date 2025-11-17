import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/passeioModel.dart';

class MeusPasseiosScreen extends StatefulWidget {
  const MeusPasseiosScreen({super.key});

  @override
  State<MeusPasseiosScreen> createState() => _MeusPasseiosScreenState();
}

class _MeusPasseiosScreenState extends State<MeusPasseiosScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _idCliente;

  @override
  void initState() {
    super.initState();
    _getIdCliente();
  }

  Future<void> _getIdCliente() async {
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

  /// Função para cancelar (apagar) um passeio
  Future<void> _cancelarPasseio(String passeioId) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cancelar passeio"),
        content: const Text(
            "Tem certeza que deseja cancelar este passeio? Essa ação não poderá ser desfeita."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Voltar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Cancelar passeio"),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      await _firestore.collection('passeios').doc(passeioId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passeio cancelado com sucesso!"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Widget _buildPasseioCard(Passeio passeio, bool concluido) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: concluido ? const Color(0xFFC8F7C5) : const Color(0xFFFFEFB5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor:
                concluido ? const Color(0xFF199700) : const Color(0xFFB1F3A3),
            child: const Icon(Icons.pets, color: Color(0xFF074800), size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  passeio.nomePet,
                  style: GoogleFonts.interTight(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF074800),
                  ),
                ),
                Text(
                  '${passeio.bairro}, ${passeio.estado}',
                  style: GoogleFonts.interTight(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Data: ${passeio.data}',
                  style: GoogleFonts.interTight(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      concluido ? Icons.check_circle : Icons.access_time,
                      color: concluido
                          ? const Color(0xFF199700)
                          : const Color(0xFF8B8000),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      concluido ? 'Concluído' : 'Em andamento',
                      style: GoogleFonts.interTight(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: concluido
                            ? const Color(0xFF199700)
                            : const Color(0xFF8B8000),
                      ),
                    ),
                  ],
                ),
                if (!concluido)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => _cancelarPasseio(passeio.passeioID),
                        icon: const Icon(Icons.cancel, size: 18),
                        label: const Text("Cancelar"),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stream<List<Passeio>> _getPasseiosCliente() {
    if (_idCliente == null) return const Stream.empty();
    return _firestore
        .collection('passeios')
        .where('id_cliente', isEqualTo: _idCliente)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Passeio.fromMap(doc.data(), doc.id)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB1F3A3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF074800)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Meus Passeios',
          style: GoogleFonts.interTight(
            color: const Color(0xFF074800),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _idCliente == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<Passeio>>(
              stream: _getPasseiosCliente(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'Você ainda não solicitou nenhum passeio.',
                      style: GoogleFonts.interTight(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  );
                }

                final passeios = snapshot.data!;
                final abertos = passeios
                    .where((p) =>
                        p.idWalker.isEmpty ||
                        (p.toMap()['concluido'] ?? false) == false)
                    .toList();
                final finalizados = passeios
                    .where((p) => (p.toMap()['concluido'] ?? false) == true)
                    .toList();

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (abertos.isNotEmpty)
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20, top: 20, bottom: 8),
                          child: Text(
                            'Abertos',
                            style: GoogleFonts.interTight(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF074800),
                            ),
                          ),
                        ),
                      if (abertos.isNotEmpty)
                        ...abertos.map((p) => _buildPasseioCard(p, false)),
                      if (finalizados.isNotEmpty)
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20, top: 20, bottom: 8),
                          child: Text(
                            'Finalizados',
                            style: GoogleFonts.interTight(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF074800),
                            ),
                          ),
                        ),
                      if (finalizados.isNotEmpty)
                        ...finalizados.map((p) => _buildPasseioCard(p, true)),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
