import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgendaDWWidget extends StatefulWidget {
  const AgendaDWWidget({super.key});

  @override
  State<AgendaDWWidget> createState() => _AgendaDWWidgetState();
}

class _AgendaDWWidgetState extends State<AgendaDWWidget> {
  final List<Map<String, dynamic>> agendaItems = [
    {
      'day': 'Domingo',
      'date': '20',
      'title': 'Passeio',
      'time': '14:30',
      'address': 'rua Saudade, 120',
      'owner': 'Lúcia',
      'petName': 'Bruce',
      'petImage': 'https://picsum.photos/seed/144/600',
      'petBreed': 'Pitbull',
      'petAge': '5 Anos',
      'petSpecialCondition': 'sim, xxxxxxx',
      'petSize': 'Grande',
      'isNeutered': false,
      'isVaccinated': true,
      'isChecked': true,
    },
    {
      'day': 'Segunda-feira',
      'date': '21',
      'title': 'Passeio',
      'time': '14:00',
      'address': 'rua Brasil, 30',
      'owner': 'Márcia',
      'petName': 'Luck',
      'petImage': 'https://picsum.photos/seed/200/600',
      'petBreed': 'Golden Retriever',
      'petAge': '2 Anos',
      'petSpecialCondition': 'não',
      'petSize': 'Médio',
      'isNeutered': true,
      'isVaccinated': true,
      'isChecked': true,
    },
    {
      'day': 'Terça-feira',
      'date': '22',
      'title': 'Passeio',
      'time': '15:00',
      'address': 'rua Av.Araças, 1190',
      'owner': 'Luiza',
      'petName': 'Snoop',
      'petImage': 'https://picsum.photos/seed/300/600',
      'petBreed': 'Poodle',
      'petAge': '7 Anos',
      'petSpecialCondition': 'não',
      'petSize': 'Pequeno',
      'isNeutered': true,
      'isVaccinated': true,
      'isChecked': false,
    },
    {
      'day': 'Quarta-feira',
      'date': '23',
      'title': 'Passeio',
      'time': '15:40',
      'address': 'rua Marcilios Dias, 128',
      'owner': 'Otávio',
      'petName': 'Toddy',
      'petImage': 'https://picsum.photos/seed/400/600',
      'petBreed': 'Vira-lata',
      'petAge': '3 Anos',
      'petSpecialCondition': 'sim, xxxxx',
      'petSize': 'Grande',
      'isNeutered': false,
      'isVaccinated': true,
      'isChecked': false,
    },
  ];

  int? _expandedIndex;
  final TextEditingController _reportController = TextEditingController();

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB1F3A3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF074800),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(
                Icons.add_sharp,
                color: Color(0xFF074800),
                size: 28,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/calendario');
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Abril',
                  style: GoogleFonts.interTight(
                    color: const Color(0xFF074800),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xFFFFFBE4),
                child: ListView.builder(
                  itemCount: agendaItems.length,
                  itemBuilder: (context, index) {
                    final item = agendaItems[index];
                    final isExpanded = _expandedIndex == index;
                    return _buildAgendaItem(item, isExpanded, index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Exibe um diálogo para adicionar um relatório.
  Future<String?> _showReportDialog(BuildContext context) async {
    _reportController.clear(); // Limpa o texto a cada vez que o diálogo é aberto

    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFBE4), // Cor de fundo do AlertDialog
          contentPadding: EdgeInsets.zero, // Remove o padding padrão do conteúdo
          insetPadding: const EdgeInsets.all(20.0), // Padding do AlertDialog em relação às bordas da tela
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFFDED7AD), width: 1), // Borda do AlertDialog
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Ocupa o mínimo de espaço vertical possível
            children: [
              // Cabeçalho do diálogo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFB1F3A3), // Cor do cabeçalho
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Text(
                  'Relatório',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.interTight(
                    color: const Color(0xFF074800),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Corpo do diálogo com o TextField
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adicionar informações de como ocorreu o passeio:',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFB06F3A), // Cor do texto da label
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7C8), // Cor de fundo do TextField
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFDED7AD), width: 1), // Borda do TextField
                      ),
                      child: TextField(
                        controller: _reportController,
                        maxLines: 5, // Permite múltiplas linhas
                        decoration: InputDecoration(
                          hintText: '', // Remove o hintText padrão
                          border: InputBorder.none, // Remove a borda padrão do TextField
                          contentPadding: const EdgeInsets.all(12),
                          isDense: true, // Reduz o espaço interno do TextField
                        ),
                        style: GoogleFonts.inter(
                          color: const Color(0xFF074800), // Cor do texto digitado
                          fontSize: 14,
                        ),
                        cursorColor: const Color(0xFF074800), // Cor do cursor
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Retorna o texto do TextField quando o botão é pressionado
                          Navigator.of(context).pop(_reportController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF388E3C), // Cor de fundo do botão "Adicionar"
                          foregroundColor: Colors.white, // Cor do texto do botão
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 3,
                        ),
                        child: Text(
                          'Adicionar',
                          style: GoogleFonts.interTight(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAgendaItem(Map<String, dynamic> item, bool isExpanded, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_expandedIndex == index) {
            _expandedIndex = null;
          } else {
            _expandedIndex = index;
          }
        });
      },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7C8),
            border: Border.all(
              color: const Color(0xFFDED7AD),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: double.infinity,
                      color: const Color(0xFFFFF7C8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['day']!,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF074800),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            item['date']!,
                            style: GoogleFonts.interTight(
                              color: const Color(0xFF074800),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDED7AD),
                          border: Border.all(
                            color: const Color(0xFFB06F3A),
                            width: 0.25,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    '${item['title']}\n${item['time']}, ${item['address']}\ndona: ${item['owner']}\npet: ${item['petName']}',
                                    style: GoogleFonts.inter(fontSize: 12),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Theme(
                                  data: ThemeData(
                                    checkboxTheme: CheckboxThemeData(
                                      visualDensity: VisualDensity.compact,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    unselectedWidgetColor: const Color(0xFFFFFBE4),
                                  ),
                                  child: Checkbox(
                                    value: item['isChecked']!,
                                    onChanged: (newValue) async {
                                      if (newValue == true) {
                                        final String? report = await _showReportDialog(context);

                                        if (report != null && report.isNotEmpty) {
                                          setState(() {
                                            agendaItems[index]['isChecked'] = true;
                                            // Você pode armazenar o relatório em algum lugar aqui,
                                            // talvez adicionando uma nova chave ao mapa agendaItems.
                                            // Por exemplo: agendaItems[index]['report'] = report;
                                            print('Relatório adicionado: $report');
                                          });
                                        } else if (report == null) {
                                          // Se o usuário cancelou o diálogo (clicou fora ou popou),
                                          // o checkbox não deve ser marcado.
                                          // Não faz nada aqui, o estado do checkbox permanece inalterado.
                                        } else {
                                          // Se o relatório estiver vazio, você pode mostrar um aviso
                                          // ou impedir que o checkbox seja marcado.
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Por favor, adicione um relatório.')),
                                          );
                                        }
                                      } else {
                                        setState(() {
                                          agendaItems[index]['isChecked'] = false;
                                          // Opcional: Remover o relatório se a tarefa for desmarcada
                                          // agendaItems[index].remove('report');
                                        });
                                      }
                                    },
                                    side: const BorderSide(
                                      width: 2,
                                      color: Color(0xFFFFFBE4),
                                    ),
                                    activeColor: const Color(0xFF074800),
                                    checkColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: const Color(0xFF074800),
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              if (isExpanded)
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item['petImage']!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Nome do pet: ${item['petName']!}',
                          style: GoogleFonts.interTight(color: const Color(0xFF074800), fontSize: 12),
                        ),
                        Text(
                          'Raça: ${item['petBreed']!}',
                          style: GoogleFonts.interTight(color: const Color(0xFF074800), fontSize: 12),
                        ),
                        Text(
                          'Idade: ${item['petAge']!}',
                          style: GoogleFonts.interTight(color: const Color(0xFF074800), fontSize: 12),
                        ),
                        Text(
                          'Condição especial: ${item['petSpecialCondition']!}',
                          style: GoogleFonts.interTight(color: const Color(0xFF074800), fontSize: 12),
                        ),
                        Text(
                          'Porte: ${item['petSize']!}',
                          style: GoogleFonts.interTight(color: const Color(0xFF074800), fontSize: 12),
                        ),
                        Text(
                          'Castrado: ${item['isNeutered']! ? 'Sim' : 'Não'}',
                          style: GoogleFonts.interTight(color: const Color(0xFF074800), fontSize: 12),
                        ),
                        Text(
                          'Carteira de vacinação em dia: ${item['isVaccinated']! ? 'Sim' : 'Não'}',
                          style: GoogleFonts.interTight(color: const Color(0xFF074800), fontSize: 12),
                        ),
                        // Exibir o relatório se existir
                        if (item.containsKey('report') && item['report']!.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Text(
                            'Relatório do passeio: ${item['report']}',
                            style: GoogleFonts.interTight(
                                color: const Color(0xFF074800),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}