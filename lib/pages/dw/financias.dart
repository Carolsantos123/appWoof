import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';

class FinancasScreen extends StatefulWidget {
  const FinancasScreen({super.key});

  @override
  State<FinancasScreen> createState() =>
      _PaginaFinancasRefatoradaState();
}

class _PaginaFinancasRefatoradaState extends State<FinancasScreen> {
  // Exemplo de variáveis de estado para a página.
  String valorPorHora = 'R\$ 25,00';
  String horasTrabalhadas = '8';
  String totalDoDia = 'R\$ 200,00';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Remove o foco dos campos de texto ao tocar fora deles.
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // Adicionando a AppBar com as personalizações
        appBar: AppBar(
          backgroundColor: const Color(0xFFB1F3A3),
          // Seta de voltar (leading)
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
          // Título centralizado na AppBar
          title: const Text(
            'Adicionar finanças',
            style: TextStyle(
              color: Color(0xFF074800),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          // Remover a sombra abaixo da AppBar
          elevation: 0,
        ),
        backgroundColor: const Color(0xFFFFFBE4),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  // Cartão com o total momentâneo
                  Center(
                    child: Container(
                      width: 200,
                      height: 110,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEFB5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total momentâneo',
                            style: TextStyle(
                              color: Color(0xFF6A3917),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'R\$000,00',
                            style: TextStyle(
                              color: Color(0xFF074800),
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Títulos para os valores de horas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Valor cobrado por hora',
                        style: TextStyle(
                          color: Color(0xFF6A3917),
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        'Horas trabalhadas',
                        style: TextStyle(
                          color: Color(0xFF6A3917),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Campos de valor e horas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInputCard(valorPorHora),
                      _buildInputCard(horasTrabalhadas,
                          label: 'horas trabalhadas'),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Título para o total do dia
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total do dia de trabalho',
                        style: TextStyle(
                          color: Color(0xFF6A3917),
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        'Total do dia de trabalho',
                        style: TextStyle(
                          color: Color(0xFF6A3917),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Cartão com o total do dia
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInputCard(totalDoDia),
                      // Adicione o segundo container se necessário
                      Container(
                        width: 130,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEFB5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget reutilizável para os cartões de input
  Widget _buildInputCard(String text, {String? label}) {
    return Container(
      width: 130,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFFFEFB5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          label ?? text,
          style: TextStyle(
            color: const Color(0xFF074800),
            fontSize: label != null ? 15 : 18,
          ),
        ),
      ),
    );
  }
}