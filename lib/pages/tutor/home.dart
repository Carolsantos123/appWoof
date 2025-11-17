import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/models/walkerModel.dart';
import 'package:intl/intl.dart';
import 'package:woof/pages/tutor/pefil_pet.dart';
import 'package:woof/services/weather_service.dart';


class HomeTutorScreen extends StatefulWidget {
  const HomeTutorScreen({super.key});

  @override
  State<HomeTutorScreen> createState() => _HomeTutorScreenState();
}

class _HomeTutorScreenState extends State<HomeTutorScreen> {
  List<Walker> dogWalkers = [];
  List<Walker> dogWalkersFiltrados = [];
  bool carregando = true;
  final TextEditingController pesquisaController = TextEditingController();

  // Weather
  final WeatherService _weatherService = WeatherService();
  String temperatura = 'Carregando...';
  String descricaoClima = '';

  @override
  void initState() {
    super.initState();
    carregarDogWalkers();
    pesquisaController.addListener(_filtrarDogWalkers);
    _carregarClima();
  }

  @override
  void dispose() {
    pesquisaController.dispose();
    super.dispose();
  }

  Future<void> carregarDogWalkers() async {
    try {
      final query = await FirebaseFirestore.instance.collection('walkers').get();
      final walkers = query.docs.map((doc) => Walker.fromMap(doc.data(), doc.id)).toList();

      setState(() {
        dogWalkers = walkers;
        dogWalkersFiltrados = walkers;
        carregando = false;
      });
    } catch (e) {
      debugPrint('Erro ao carregar DWs: $e');
      setState(() => carregando = false);
    }
  }

  void _filtrarDogWalkers() {
    final query = pesquisaController.text.toLowerCase();
    setState(() {
      dogWalkersFiltrados = dogWalkers.where((dw) {
        return dw.nomeCompleto.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _carregarClima() async {
    final clima = await _weatherService.getClimaAracatuba();
    setState(() {
      if (clima != null) {
        temperatura = clima['temp'] != null ? '${clima['temp']}°C' : 'Temperatura não encontrada';
        descricaoClima = clima['description'] ?? '';
      } else {
        temperatura = 'TN';
        descricaoClima = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dataFormatada = DateFormat('dd/MM/yyyy').format(now);
    final diaSemana = DateFormat('EEEE', 'pt_BR').format(now);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              // AppBar customizada
              Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF9500),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Temperatura e clima
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            temperatura,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            descricaoClima,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      // Data
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            dataFormatada,
                            style: GoogleFonts.interTight(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            diaSemana,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Botões principais
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 75),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 32,
                  crossAxisSpacing: 32,
                  childAspectRatio: 1,
                  children: [
                    _buildLargeButton('Passeio', Icons.directions_walk, () { Navigator.pushNamed(context, '/passeios_tutor'); }),
                    _buildLargeButton('Feedback', Icons.location_on, () { Navigator.pushNamed(context, '/feedback_tutor'); }),
                    _buildLargeButton('Histórico', Icons.history, () { Navigator.pushNamed(context, '/historico_tutor'); }),
                    _buildLargeButton('Notificações', Icons.notifications, () { Navigator.pushNamed(context, '/notificacoes_tutor'); }),
                    _buildLargeButton('Meus Pets', Icons.pets, () { 
                      
                          Navigator.of(context).push(
                           MaterialPageRoute(builder: (_)=> PerfilPetScreen())
                          );
                     }),
                    _buildLargeButton('Perfil', Icons.account_circle, () { Navigator.pushNamed(context, '/perfil_tutor'); }),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Barra de pesquisa
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5C2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: pesquisaController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Pesquisar dogwalker',
                      prefixIcon: Icon(Icons.search, color: Color(0xFF0F5100)),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Lista de DWs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DogWalkers cadastrados',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F5100),
                      ),
                    ),
                    const SizedBox(height: 12),
                    carregando
                        ? const Center(child: CircularProgressIndicator(color: Color(0xFF199700)))
                        : dogWalkersFiltrados.isEmpty
                            ? const Center(child: Text("Nenhum dogwalker encontrado."))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: dogWalkersFiltrados.length,
                                itemBuilder: (context, index) {
                                  final dw = dogWalkersFiltrados[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF5C2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Color(0xFFD9D9D9),
                                          child: Icon(Icons.account_circle, color: Colors.white),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            dw.nomeCompleto,
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: const Color(0xFF0F5100),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () { Navigator.pushNamed(context, '/perfildw_tutor', arguments: dw.walkerID); },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF0F5100),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                            elevation: 0,
                                          ),
                                          child: Text('Ver', style: GoogleFonts.inter(fontSize: 14, color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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

  Widget _buildLargeButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFF9500),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
