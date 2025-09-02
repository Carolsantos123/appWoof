import 'package:flutter/material.dart';

class ExperienciasScreen extends StatefulWidget {
  const ExperienciasScreen({super.key});

  @override
  State<ExperienciasScreen> createState() => _ExperienciasScreenState();
}

class _ExperienciasScreenState extends State<ExperienciasScreen> {
  // Inicialização dos controladores para os campos de texto
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  final TextEditingController textController3 = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController textController4 = TextEditingController();

  @override
  void dispose() {
    // É crucial descartar os controladores para liberar a memória
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    priceController.dispose();
    textController4.dispose();
    super.dispose();
  }

  // Método auxiliar para criar a decoração dos campos de texto,
  // replicando o estilo do formulário de cadastro.
  InputDecoration _dec(String label) {
    return InputDecoration(
      labelText: label,
      isDense: true,
      hintText: label,
      filled: true,
      fillColor: const Color(0x8DF4C7B6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
  }

  // Método auxiliar para criar cada campo de texto com o estilo desejado
  Widget _campo({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: _dec(label),
      style: const TextStyle(
        color: Color(0xFFFFAB00),
        fontSize: 18,
      ),
      cursorColor: Colors.black87,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF9E6),
        appBar: AppBar(
          backgroundColor: const Color(0xFFB1F3A3),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF074800),
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Experiências',
            style: TextStyle(
              color: Color(0xFF074800),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: _campo(
                    label: 'Descrever experiências anteriores com pets:',
                    controller: textController1,
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: _campo(
                    label: 'Adicione seus dias e horários disponíveis:',
                    controller: textController2,
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: _campo(
                    label: 'Regiões onde pode fazer passeios:',
                    controller: textController3,
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: _campo(
                    label: 'Valor do passeio por hora (R\$):',
                    controller: priceController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: _campo(
                    label: 'Informações extras (ex especializações, tecnicas de adestramento)',
                    controller: textController4,
                    maxLines: null,
                  ),
                ),
                            Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: SizedBox(
                    height: 44.2,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF199700),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        elevation: 0,
                      ),
                      onPressed: () {
      
                          Navigator.of(context).pushNamed('/perfil_dw');
                        
                      },
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
