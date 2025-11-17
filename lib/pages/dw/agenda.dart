import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/passeioModel.dart'; // ajuste o caminho conforme seu projeto

class AgendaDWWidget extends StatefulWidget {
  const AgendaDWWidget({super.key});

  @override
  State<AgendaDWWidget> createState() => _AgendaDWWidgetState();
}

class _AgendaDWWidgetState extends State<AgendaDWWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int? _expandedIndex;
  final TextEditingController _reportController = TextEditingController();

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  Future<String?> _showReportDialog(BuildContext context) async {
    _reportController.clear();

    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFBE4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(
            'Relatório do Passeio',
            textAlign: TextAlign.center,
            style: GoogleFonts.interTight(
              color: const Color(0xFF074800),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Descreva como foi o passeio:',
                style: GoogleFonts.inter(
                  color: const Color(0xFFB06F3A),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _reportController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Ex: O pet se comportou bem, brincou bastante...',
                  hintStyle: GoogleFonts.inter(color: Colors.grey[600]),
                  filled: true,
                  fillColor: const Color(0xFFFFF7C8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Color(0xFFDED7AD), width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_reportController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF388E3C),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Salvar'),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Salva o relatório no nó `relatorios` e marca o passeio como concluído
  Future<void> _salvarRelatorio(Passeio passeio, String relatorio) async {
    final relatorioRef = _firestore.collection('relatorios').doc();

    await relatorioRef.set({
      'relatorioID': relatorioRef.id,
      'id_passeio': passeio.passeioID,
      'id_walker': passeio.idWalker,
      'relatorio': relatorio,
      'data': DateTime.now().toIso8601String(),
    });

    // Atualiza o campo 'concluido' do passeio
    await _firestore.collection('passeios').doc(passeio.passeioID).update({
      'concluido': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    if (user == null) {
      return const Center(child: Text('Usuário não autenticado.'));
    }

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
          'Agenda',
          style: GoogleFonts.interTight(
            color: const Color(0xFF074800),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('passeios')
            .where('id_walker', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'Nenhum passeio agendado.',
                style:
                    GoogleFonts.interTight(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          final docs = snapshot.data!.docs;
          final passeios = docs
              .map((doc) =>
                  Passeio.fromMap(doc.data() as Map<String, dynamic>, doc.id))
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: passeios.length,
            itemBuilder: (context, index) {
              final passeio = passeios[index];
              final isExpanded = _expandedIndex == index;
              return _buildAgendaItem(passeio, isExpanded, index);
            },
          );
        },
      ),
    );
  }

  Widget _buildAgendaItem(Passeio passeio, bool isExpanded, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _expandedIndex = (_expandedIndex == index) ? null : index;
        });
      },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7C8),
            border: Border.all(color: const Color(0xFFDED7AD)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      color: const Color(0xFFDED7AD),
                      child: Center(
                        child: Text(
                          passeio.data,
                          style: GoogleFonts.interTight(
                            color: const Color(0xFF074800),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pet: ${passeio.nomePet}',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xFF074800),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Endereço: ${passeio.rua}, ${passeio.numero}',
                              style: GoogleFonts.inter(fontSize: 12),
                            ),
                            Text(
                              'Horário: ${passeio.horario.hour}:${passeio.horario.minute.toString().padLeft(2, '0')}',
                              style: GoogleFonts.inter(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: const Color(0xFF074800),
                    ),
                  ],
                ),
              ),
              if (isExpanded)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tipo: ${passeio.tipoPasseio}',
                          style: GoogleFonts.interTight(fontSize: 13)),
                      Text('Tempo: ${passeio.tempoPasseio}',
                          style: GoogleFonts.interTight(fontSize: 13)),
                      Text('Serviço: ${passeio.servicos}',
                          style: GoogleFonts.interTight(fontSize: 13)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Concluído:',
                              style: GoogleFonts.interTight(fontSize: 13)),
                          Checkbox(
                            value: passeio.concluido,
                            activeColor: const Color(0xFF074800),
                            onChanged: passeio.concluido
                                ? null // desativa se já foi concluído
                                : (value) async {
                                    final report =
                                        await _showReportDialog(context);
                                    if (report != null &&
                                        report.trim().isNotEmpty) {
                                      await _salvarRelatorio(passeio, report);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Relatório salvo e passeio concluído!'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    }
                                  },
                          ),
                        ],
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
