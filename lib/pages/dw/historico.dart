import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoricodiaWidget extends StatefulWidget {
  final DateTime selectedDate;

  const HistoricodiaWidget({super.key, required this.selectedDate});

  @override
  State<HistoricodiaWidget> createState() => _HistoricodiaWidgetState();
}

class _HistoricodiaWidgetState extends State<HistoricodiaWidget> {
  final Color backgroundColor = const Color(0xFFFFFBE4);
  final Color primaryColor = const Color(0xFF074800);
  final Color appBarColor = const Color(0xFFB1F3A3);
  final Color cardColor = const Color(0xFFFFEFB5);

  bool _loading = true;
  List<Map<String, dynamic>> _passeios = [];
  late DateTime _selectedDate;
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _atualizarDataFormatada();
    _carregarPasseios();
  }

  void _atualizarDataFormatada() {
    formattedDate = "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";
  }

  Future<void> _carregarPasseios() async {
    setState(() => _loading = true);
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('passeios')
          .where('id_walker', isEqualTo: user.uid)
          .where('data', isEqualTo: formattedDate)
          .get();

      setState(() {
        _passeios = snapshot.docs.map((d) => d.data()).toList();
        _loading = false;
      });
    } catch (e) {
      debugPrint("Erro ao carregar passeios: $e");
      setState(() => _loading = false);
    }
  }

  Future<void> _selecionarNovaData() async {
    final DateTime? novaData = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF074800),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (novaData != null && novaData != _selectedDate) {
      setState(() {
        _selectedDate = novaData;
        _atualizarDataFormatada();
      });
      _carregarPasseios();
    }
  }

  Future<void> _gerarRelatorioDoDia() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (_passeios.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhum passeio encontrado para gerar relatório.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    String resumo = "📅 Relatório do dia $formattedDate\n\n";
    for (var p in _passeios) {
      resumo +=
          "🐾 Pet: ${p['nome_pet'] ?? 'N/A'}\nTipo: ${p['tipo_passeio'] ?? 'N/A'}\nTempo: ${p['tempo_passeio'] ?? 'N/A'}\nEndereço: ${p['rua'] ?? ''}, ${p['numero'] ?? ''}\n\n";
    }

    final relatorio = {
      'id_walker': user.uid,
      'data': formattedDate,
      'total_passeios': _passeios.length,
      'detalhes': resumo,
      'criado_em': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('relatorios').add(relatorio);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Relatório gerado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      debugPrint("Erro ao salvar relatório: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao gerar relatório.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
          'Histórico do Dia',
          style: GoogleFonts.interTight(
            color: primaryColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "📅 $formattedDate",
                        style: GoogleFonts.interTight(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.calendar_month, color: Color(0xFF074800)),
                        onPressed: _selecionarNovaData,
                        tooltip: 'Selecionar outra data',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _passeios.isEmpty
                      ? Center(
                          child: Text(
                            "Nenhum passeio encontrado em $formattedDate",
                            style: GoogleFonts.inter(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _passeios.length,
                          itemBuilder: (context, index) {
                            final passeio = _passeios[index];
                            return _buildPasseioCard(passeio);
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _gerarRelatorioDoDia,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A6C0A),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.description, color: Colors.white),
                      label: Text(
                        "Gerar Relatório do Dia",
                        style: GoogleFonts.interTight(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPasseioCard(Map<String, dynamic> passeio) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            passeio['nome_pet'] ?? 'Pet desconhecido',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text("Tipo: ${passeio['tipo_passeio'] ?? 'N/A'}",
              style: GoogleFonts.poppins(fontSize: 14)),
          Text("Tempo: ${passeio['tempo_passeio'] ?? 'N/A'}",
              style: GoogleFonts.poppins(fontSize: 14)),
          Text("Local: ${passeio['rua'] ?? ''}, ${passeio['numero'] ?? ''}",
              style: GoogleFonts.poppins(fontSize: 13)),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Data: ${passeio['data'] ?? ''}",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
