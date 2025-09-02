import 'package:flutter/material.dart';

class notificacoesScreen extends StatefulWidget {
  const notificacoesScreen({super.key});

  @override
  State<notificacoesScreen> createState() =>
      _NotificacoesDogwalkerWidgetState();
}

class _NotificacoesDogwalkerWidgetState
    extends State<notificacoesScreen> {
  // Dados de exemplo para as notificações
  final List<String> notificacoes = [
    'Silvia aceitou o remarco do passeio!',
    'Márcia aceitou o remarco passeio!',
    'Julia quer remarcar passeio!',
    'Você recebeu uma nova avaliação!',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFBE4),
        // Utilizando AppBar para o cabeçalho
        appBar: AppBar(
          backgroundColor: const Color(0xFFB1F3A3), // Cor da outra AppBar
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF074800),
            ),
            onPressed: () {
              // Navega de volta para a tela anterior
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Notificações',
            style: TextStyle(
              color: Color(0xFF074800),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Usando Expanded para que a lista ocupe o espaço disponível
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: notificacoes.length,
                  itemBuilder: (context, index) {
                    return _buildNotificationCard(notificacoes[index]);
                  },
                ),
              ),
              // Texto no final da tela
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
          ),
        ),
      ),
    );
  }

  // Widget reutilizável para o card de notificação
  Widget _buildNotificationCard(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Reduzi o espaçamento vertical
      child: Container(
        height: 60, // Reduzi a altura do container
        decoration: BoxDecoration(
          color: const Color(0xFFB1F3A3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0), // Reduzi o padding horizontal
          child: Row(
            children: [
              const Icon(
                Icons.location_history,
                color: Colors.black,
                size: 30, // Reduzi o tamanho do ícone
              ),
              const SizedBox(width: 8), // Reduzi o espaço entre o ícone e o texto
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14, // Reduzi o tamanho da fonte
                    fontWeight: FontWeight.w600,
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
