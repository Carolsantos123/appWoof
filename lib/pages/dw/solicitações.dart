import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SolicitacoesScreen extends StatefulWidget {
  const SolicitacoesScreen({super.key});

  @override
  State<SolicitacoesScreen> createState() => _SolicitacoesScreenState();
}

class _SolicitacoesScreenState extends State<SolicitacoesScreen> {
  // Dados de exemplo para as solicitações.
  // Adicionado mais campos para corresponder à tela de visualização.
  final List<Map<String, String>> solicitacoes = [
    {
      'name': 'Raquel',
      'request': 'Raquel solicitou um passeio',
      'image': 'https://picsum.photos/seed/398/600',
      'date': '10/08/2025',
      'time': '10:00am',
      'duration': '30 minutos',
      'address': 'Rua Emilia Santos, bairro Alvorada, número 300',
      'petName': 'Luck',
    },
    {
      'name': 'Lucas',
      'request': 'Lucas solicitou um passeio',
      'image': 'https://picsum.photos/seed/399/600',
      'date': '12/08/2025',
      'time': '14:00pm',
      'duration': '45 minutos',
      'address': 'Avenida Brasil, 1500, centro',
      'petName': 'Rex',
    },
    {
      'name': 'Isabela',
      'request': 'Isabela solicitou um passeio',
      'image': 'https://picsum.photos/seed/400/600',
      'date': '15/08/2025',
      'time': '09:30am',
      'duration': '60 minutos',
      'address': 'Rua Sete de Setembro, 200, Vila Mariana',
      'petName': 'Molly',
    },
  ];

  /// Função para exibir o AlertDialog com os detalhes da solicitação.
  void _showSolicitacaoDialog(BuildContext context, Map<String, String> solicitacao) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFBE4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(24),
          title: Center(
            child: Text(
              'Visualização',
              style: GoogleFonts.interTight(
                color: const Color(0xFF074800),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dia: ${solicitacao['date']}',
                style: GoogleFonts.interTight(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Horário: ${solicitacao['time']}',
                style: GoogleFonts.interTight(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Tempo: ${solicitacao['duration']}',
                style: GoogleFonts.interTight(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Endereço: ${solicitacao['address']}',
                style: GoogleFonts.interTight(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Nome do pet: ${solicitacao['petName']}',
                style: GoogleFonts.interTight(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para excluir
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B0000), // Cor marrom
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Excluir'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para marcar
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF199700), // Cor verde
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Marcar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
          title: const Text(
            'Solicitações',
            style: TextStyle(
              color: Color(0xFF074800),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              itemCount: solicitacoes.length,
              itemBuilder: (context, index) {
                final solicitacao = solicitacoes[index];
                return _buildSolicitacaoCard(solicitacao);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSolicitacaoCard(Map<String, String> solicitacao) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEFB5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 50,
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                solicitacao['image']!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.account_circle,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    solicitacao['name']!,
                    style: GoogleFonts.interTight(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    solicitacao['request']!,
                    style: GoogleFonts.interTight(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              // Ao pressionar o botão, a função _showSolicitacaoDialog é chamada.
              // Ela recebe o mapa da solicitação correspondente como argumento.
              onPressed: () {
                _showSolicitacaoDialog(context, solicitacao);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF199700),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
                minimumSize: const Size(0, 30),
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
