import 'package:flutter/material.dart';

class CadastroDwPage extends StatefulWidget {
  const CadastroDwPage({super.key});

  static const String routeName = 'cadastro_dw';
  static const String routePath = '/cadastroDw';

  @override
  State<CadastroDwPage> createState() => _CadastroDwPageState();
}

class _CadastroDwPageState extends State<CadastroDwPage> {
  // Controllers
  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();
  final _cpfCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _cepCtrl = TextEditingController();
  final _ruaCtrl = TextEditingController();
  final _bairroCtrl = TextEditingController();
  final _numCtrl = TextEditingController();
  final _estadoCtrl = TextEditingController();
  final _complCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscurePass = true;

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
    _cpfCtrl.dispose();
    _telCtrl.dispose();
    _cepCtrl.dispose();
    _ruaCtrl.dispose();
    _bairroCtrl.dispose();
    _numCtrl.dispose();
    _estadoCtrl.dispose();
    _complCtrl.dispose();
    super.dispose();
  }

  InputDecoration _dec(String label) {
    return InputDecoration(
      labelText: label,
      isDense: true,
      hintText: label,
      filled: true,
      fillColor: const Color(0x8DF4C7B6), // mesmo tom translúcido do FF
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _campo({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    bool obscure = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      decoration: _dec(label).copyWith(suffixIcon: suffixIcon),
      style: const TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 18,
      ),
      validator: validator,
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
            'Cadastro de DogWalker',
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
            child: Column(
              children: [
                // Imagem topo
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          'assets/images/osso_cachorros.png',
                          height: 300.0,
                          fit: BoxFit.fitWidth,
                          alignment: const Alignment(0, -1),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _campo(
                          label: 'Nome completo',
                          controller: _nomeCtrl,
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'Email',
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Informe o email';
                            final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
                            return ok ? null : 'Email inválido';
                          },
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'Senha',
                          controller: _senhaCtrl,
                          obscure: _obscurePass,
                          suffixIcon: IconButton(
                            onPressed: () => setState(() => _obscurePass = !_obscurePass),
                            icon: Icon(
                              _obscurePass ? Icons.visibility : Icons.visibility_off,
                            ),
                          ),
                          validator: (v) =>
                              (v == null || v.length < 6) ? 'Mínimo 6 caracteres' : null,
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'CPF',
                          controller: _cpfCtrl,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'Telefone',
                          controller: _telCtrl,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Endereço',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF074800),
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'CEP',
                          controller: _cepCtrl,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'Rua',
                          controller: _ruaCtrl,
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'Bairro',
                          controller: _bairroCtrl,
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'Número',
                          controller: _numCtrl,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'Estado',
                          controller: _estadoCtrl,
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'Complemento',
                          controller: _complCtrl,
                        ),
                      ],
                    ),
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