import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:woof/controllers/clienteController.dart';
import 'package:woof/models/clienteModel.dart';
import 'package:woof/pages/tutor/cd_perfil.dart';
import 'package:woof/services/clienteService.dart';
import 'perfil_tutor.dart'; // 👈 importa o perfil

class Cadastro_tutorPage extends StatefulWidget {
  const Cadastro_tutorPage({super.key});

  static const String routeName = 'cadastro_tutor';
  static const String routePath = '/cadastro_tutor';

  @override
  State<Cadastro_tutorPage> createState() => _Cadastro_tutorPageState();
}

class _Cadastro_tutorPageState extends State<Cadastro_tutorPage> {
  // Controllers de formulário
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
  bool _isLoading = false;

  final ClienteController _clienteController =
      ClienteController(service: ClienteService());

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

  Future<void> _cadastrarCliente() async {
    setState(() => _isLoading = true);

    try {
      // 1. Criar usuário no FirebaseAuth
      UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _senhaCtrl.text.trim(),
      );

      final uid = cred.user!.uid;
      final clienteId = uid; // vamos usar o próprio UID como ID do cliente

      // 2. Criar objeto Cliente
      final cliente = Cliente(
        clienteID: clienteId,
        bairro: _bairroCtrl.text,
        cep: _cepCtrl.text,
        complemento: _complCtrl.text.isEmpty ? null : _complCtrl.text,
        email: _emailCtrl.text,
        estado: _estadoCtrl.text,
        foto: '',
        nomeCompleto: _nomeCtrl.text,
        numero: int.tryParse(_numCtrl.text) ?? 0,
        rua: _ruaCtrl.text,
        senha: '',
        telefone: int.tryParse(_telCtrl.text) ?? 0,
        uidUser: uid,
        pets: [],
      );

      // 3. Salvar cliente no Firestore
      await _clienteController.service.adicionarCliente(cliente);

      // 4. Atualizar lista local
      _clienteController.clientes.add(cliente);

      // 5. Navegar para perfil passando o clienteId
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => PerfilTutorWidget(clienteDocId: clienteId),
        ),
      );
    } catch (e) {
      Get.snackbar('Erro', e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
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
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: Color(0xFF0F5100)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Cadastro tutor',
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
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'Email',
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
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
                        _campo(label: 'Rua', controller: _ruaCtrl),
                        const SizedBox(height: 20),
                        _campo(label: 'Bairro', controller: _bairroCtrl),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'Número',
                          controller: _numCtrl,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        _campo(label: 'Estado', controller: _estadoCtrl),
                        const SizedBox(height: 20),
                        _campo(label: 'Complemento', controller: _complCtrl),
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
                      onPressed: _isLoading ? null : _cadastrarCliente,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
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
