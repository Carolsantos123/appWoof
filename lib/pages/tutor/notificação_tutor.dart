import 'package:flutter/material.dart';

class Notificacoes_tutorScreen extends StatefulWidget {
  const Notificacoes_tutorScreen({super.key});

  @override
  State<Notificacoes_tutorScreen> createState() => _NotificacoesScreenState();
}

class _NotificacoesScreenState extends State<Notificacoes_tutorScreen> {
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
        // AppBar com padrão laranja da Home
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF9500), // laranja
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Notificações',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Lista de notificações
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

  // Card de notificação no padrão laranja da Home
  Widget _buildNotificationCard(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: const Color(0xFFFFE0CC), // laranja claro
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              const Icon(
                Icons.notifications,
                color: Color(0xFFFF9500), // ícone laranja
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
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
