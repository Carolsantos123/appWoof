import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/passeioModel.dart';

class SolicitacoesScreen extends StatefulWidget {
  const SolicitacoesScreen({super.key});

  @override
  State<SolicitacoesScreen> createState() => _SolicitacoesScreenState();
}

class _SolicitacoesScreenState extends State<SolicitacoesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Função para aceitar o passeio (verifica tipo e marca como não concluído)
  Future<void> _aceitarPasseio(String passeioID, String tipoPasseio) async {
    final user = _auth.currentUser;

    if (user != null) {
      // Verifica se o tipo de passeio foi definido
      if (tipoPasseio.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selecione o tipo de passeio antes de aceitar.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      await _firestore.collection('passeios').doc(passeioID).update({
        'id_walker': user.uid,
        'concluido': false,
      });

      Navigator.of(context).pop(); // fecha o diálogo

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passeio aceito com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  /// Exibe o AlertDialog com os detalhes da solicitação
  void _showSolicitacaoDialog(Passeio passeio) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFBE4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Center(
            child: Text(
              'Detalhes do Passeio',
              style: GoogleFonts.interTight(
                color: const Color(0xFF074800),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoLine('Pet', passeio.nomePet),
                _infoLine('Rua', passeio.rua),
                _infoLine('Número', passeio.numero.toString()),
                _infoLine('Bairro', passeio.bairro),
                _infoLine('CEP', passeio.cep),
                _infoLine('Estado', passeio.estado),
                _infoLine('Data', passeio.data),
                _infoLine('Tempo de passeio', passeio.tempoPasseio),
                _infoLine('Tipo de passeio', passeio.tipoPasseio.isNotEmpty
                    ? passeio.tipoPasseio
                    : 'Não informado'),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B0000),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          _aceitarPasseio(passeio.passeioID, passeio.tipoPasseio),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF199700),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Aceitar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoLine(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        '$title: $value',
        style: GoogleFonts.interTight(
          fontSize: 16,
          color: const Color(0xFF074800),
        ),
      ),
    );
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Solicitações',
          style: GoogleFonts.interTight(
            color: const Color(0xFF074800),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('passeios')
            .where('id_walker', isEqualTo: '') // só passeios ainda não aceitos
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'Nenhuma solicitação disponível no momento.',
                style: GoogleFonts.interTight(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final passeio = Passeio.fromMap(data, docs[index].id);

              return _buildSolicitacaoCard(passeio);
            },
          );
        },
      ),
    );
  }

  Widget _buildSolicitacaoCard(Passeio passeio) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEFB5),
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
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Color(0xFFB1F3A3),
              child: Icon(Icons.pets, color: Color(0xFF074800), size: 30),
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
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Passeio em ${passeio.bairro}',
                    style: GoogleFonts.interTight(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _showSolicitacaoDialog(passeio),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF199700),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
                minimumSize: const Size(0, 36),
              ),
              child: Text(
                'Visualizar',
                style: GoogleFonts.interTight(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
