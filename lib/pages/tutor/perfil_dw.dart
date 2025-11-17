import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/models/walkerModel.dart';
import 'package:woof/pages/tutor/solicitacao_tutor.dart';


class PerfilDw_tutorScreen extends StatefulWidget {
  const PerfilDw_tutorScreen({super.key});

  @override
  State<PerfilDw_tutorScreen> createState() => _PerfilDw_tutorScreenState();
}

class _PerfilDw_tutorScreenState extends State<PerfilDw_tutorScreen> {
  Walker? walker;
  bool carregando = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final walkerID = ModalRoute.of(context)?.settings.arguments as String?;
    if (walkerID != null) {
      carregarWalker(walkerID);
    } else {
      setState(() => carregando = false);
    }
  }

  Future<void> carregarWalker(String walkerID) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('walkers').doc(walkerID).get();

      if (doc.exists) {
        setState(() {
          walker = Walker.fromMap(doc.data()!, doc.id);
          carregando = false;
        });
      } else {
        setState(() => carregando = false);
      }
    } catch (e) {
      debugPrint('Erro ao carregar DogWalker: $e');
      setState(() => carregando = false);
    }
  }

  Widget _campoVisualizacao(String titulo, String texto) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEECFC2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.brown.shade800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            texto.isNotEmpty ? texto : "Não informado",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Scaffold(
        backgroundColor: Color(0xFFFFFBE4),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFFF9500)),
        ),
      );
    }

    if (walker == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFFFFBE4),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF9500),
          elevation: 0,
          title: const Text(
            'DogWalker não encontrado',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Não foi possível carregar os dados do DogWalker.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFFF9500),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        walker!.foto.isNotEmpty ? NetworkImage(walker!.foto) : null,
                    child: walker!.foto.isEmpty
                        ? const Icon(Icons.person,
                            size: 40, color: Color(0xFFFF8C3E))
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    walker!.nomeCompleto,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _infoBox("12", "Passeios"), // depois será dinâmico
                      _infoBox("4.8 ★", "Avaliação"),
                      _infoBox("6", "Meses"),
                    ],
                  )
                ],
              ),
            ),

            // CORPO COM DADOS
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  children: [
                    _campoVisualizacao(
                        "Experiência", walker!.addExperienciasAnteriores),
                    _campoVisualizacao(
                        "Disponibilidade", walker!.disponibilidades),
                    _campoVisualizacao(
                        "Regiões de passeio", walker!.localizacaoPasseios),
                    _campoVisualizacao("Bairro", walker!.bairro),
                    _campoVisualizacao("Rua", walker!.rua),
                    _campoVisualizacao("Telefone", walker!.telefone),
                    _campoVisualizacao("Informações extras", walker!.extra ?? ""),
                  ],
                ),
              ),
            ),

            // BOTÃO SOLICITAR PASSEIO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SolicitarPasseioScreen(),
                        settings: RouteSettings(arguments: walker!.walkerID),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A6C0A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Solicitar passeio",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
