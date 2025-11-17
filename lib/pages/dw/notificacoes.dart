import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanosScreen extends StatelessWidget {
  const PlanosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA9EFA5),
        elevation: 0,
        title: Text(
          "Planos",
          style: GoogleFonts.poppins(
            color: Colors.green.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildPlanoDestaque(),
              const SizedBox(height: 20),
              _buildPlano(
                titulo: "Plano de 6 meses",
                beneficios: [
                  "Maior visibilidade",
                  "Controle básico de finanças",
                  "Relatórios simples de desempenho",
                  "Prioridade em suporte",
                ],
                valor: "R\$ 200",
              ),
              _buildPlano(
                titulo: "Plano Anual",
                beneficios: [
                  "Maior visibilidade",
                  "Controle básico de finanças",
                  "Relatórios completos",
                  "Suporte preferencial",
                  "Badge de profissional verificado",
                  "Mais chances de ser contratado",
                ],
                valor: "R\$ 410",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // PLANO DE 1 MÊS (DESTAQUE)
  Widget _buildPlanoDestaque() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFA9EFA5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade700, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Plano de 1 mês",
            style: GoogleFonts.poppins(
              color: Colors.green.shade900,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _itemBeneficio("Maior visibilidade"),
          _itemBeneficio("Controle básico de finanças"),
          _itemBeneficio("Acesso ao suporte"),
          const SizedBox(height: 12),
          Text(
            "R\$ 35",
            style: GoogleFonts.poppins(
              color: Colors.green.shade900,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              minimumSize: const Size(double.infinity, 45),
            ),
            child: const Text(
              "Assinar",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  // OUTROS PLANOS
  Widget _buildPlano({
    required String titulo,
    required List<String> beneficios,
    required String valor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFA9EFA5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: GoogleFonts.poppins(
              color: Colors.green.shade900,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          ...beneficios.map((b) => _itemBeneficio(b)).toList(),
          const SizedBox(height: 10),
          Text(
            valor,
            style: GoogleFonts.poppins(
              color: Colors.green.shade900,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              minimumSize: const Size(double.infinity, 45),
            ),
            child: const Text(
              "Assinar",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  Widget _itemBeneficio(String texto) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: Colors.green.shade800, size: 20),
        const SizedBox(width: 8),
        Text(
          texto,
          style: GoogleFonts.poppins(
            color: Colors.green.shade900,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
