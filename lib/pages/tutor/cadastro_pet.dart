import 'package:flutter/material.dart';

class CadastroPetScreen extends StatefulWidget {
  const CadastroPetScreen({super.key});

  @override
  State<CadastroPetScreen> createState() => _CadastroPetScreenState();
}

class _CadastroPetScreenState extends State<CadastroPetScreen> {
  final TextEditingController _nomePetController = TextEditingController();
  final TextEditingController _racaController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _especieController = TextEditingController();
  final TextEditingController _temperamentoController = TextEditingController();
  final TextEditingController _informacoesController = TextEditingController();

  String? _porte;
  final List<String> _portes = ['Pequeno', 'Médio', 'Grande'];

  final Map<String, bool> _vacinaseRemedios = {
    'Polivalente': false,
    'Raiva': false,
    'Leishmaniose': false,
    'Vermífugos': false,
    'Antipulgas e Carrapatos': false,
  };

  @override
  void dispose() {
    _nomePetController.dispose();
    _racaController.dispose();
    _idadeController.dispose();
    _especieController.dispose();
    _temperamentoController.dispose();
    _informacoesController.dispose();
    super.dispose();
  }

  InputDecoration _dec(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint ?? label,
      isDense: true,
      filled: true,
      fillColor: const Color(0x8DF4C7B6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _campo({
    required String label,
    required TextEditingController controller,
    String? hint,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: _dec(label, hint: hint),
      style: const TextStyle(
        color: Colors.black,
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
          backgroundColor: const Color(0xFFFFF9E6),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Color(0xFF0F5100)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Cadastro Pet',
            style: TextStyle(
              color: Color(0xFF0F5100),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 44.2,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF199700),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        elevation: 0,
                      ),
                      onPressed: () {
                        // Ação para adicionar foto
                      },
                      icon: const Icon(Icons.add_a_photo, color: Colors.white),
                      label: const Text(
                        'Adicionar Foto',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _campo(label: 'Nome do Pet', controller: _nomePetController),
                  const SizedBox(height: 20),
                  _campo(label: 'Raça', controller: _racaController),
                  const SizedBox(height: 20),
                  _campo(
                    label: 'Idade',
                    controller: _idadeController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  _campo(label: 'Espécie', controller: _especieController),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _porte,
                    decoration: _dec('Porte'),
                    items: _portes.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _porte = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _campo(label: 'Temperamento', controller: _temperamentoController),
                  const SizedBox(height: 20),
                  _campo(
                    label: 'Informações Importantes',
                    controller: _informacoesController,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Vacinas e Remédios',
                    style: TextStyle(
                      color: Color(0xFF074800),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0x8DF4C7B6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: _vacinaseRemedios.keys.map((String key) {
                        return CheckboxListTile(
                          title: Text(
                            key,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          value: _vacinaseRemedios[key],
                          activeColor: const Color(0xFF199700),
                          checkColor: Colors.white,
                          onChanged: (bool? value) {
                            setState(() {
                              _vacinaseRemedios[key] = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Botão Cadastrar
                  SizedBox(
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
                        // Ação para cadastrar pet
                      },
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Botão Adicionar Outro Pet
                  SizedBox(
                    height: 44.2,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF074800),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        elevation: 0,
                      ),
                      onPressed: () {
                        // Ação para adicionar outro pet (pode limpar os campos ou abrir nova tela)
                      },
                      child: const Text(
                        'Adicionar Outro Pet',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
