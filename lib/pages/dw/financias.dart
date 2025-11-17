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
  String valorPorHora = 'R\$ 25,00';
  String horasTrabalhadas = '8';
  String totalDoDia = 'R\$ 200,00';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      _mostrarAvisoPagamento();
    });
  }

  void _mostrarAvisoPagamento() {
    showDialog(
      context: context,
      barrierDismissible: false, // Impede fechar clicando fora
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFBE4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Acesso restrito",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF074800),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Para acessar o controle financeiro, é necessário ter um plano ativo.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6A3917),
              fontSize: 16,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF074800),
                padding: const EdgeInsets.symmetric(
                    horizontal: 35, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/planos");
              },
              child: const Text(
                "Ver planos",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFB1F3A3),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF074800),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Adicionar finanças',
            style: TextStyle(
              color: Color(0xFF074800),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: const Color(0xFFFFFBE4),
        body: AbsorbPointer(
          absorbing: true, // Bloqueia interação enquanto não pagar
          child: Opacity(
            opacity: 0.3, // Deixa a tela desfocada
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildConteudo(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConteudo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
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

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Valor cobrado por hora',
              style: TextStyle(color: Color(0xFF6A3917), fontSize: 15),
            ),
            Text(
              'Horas trabalhadas',
              style: TextStyle(color: Color(0xFF6A3917), fontSize: 15),
            ),
          ],
        ),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInputCard(valorPorHora),
            _buildInputCard(horasTrabalhadas),
          ],
        ),

        const SizedBox(height: 40),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Total do dia de trabalho',
              style: TextStyle(color: Color(0xFF6A3917), fontSize: 15),
            ),
            Text(
              'Total do dia de trabalho',
              style: TextStyle(color: Color(0xFF6A3917), fontSize: 15),
            ),
          ],
        ),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInputCard(totalDoDia),
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
    );
  }

  Widget _buildInputCard(String text) {
    return Container(
      width: 130,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFFFEFB5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF074800),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
