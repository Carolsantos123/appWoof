import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/controllers/walkerController.dart';
import 'package:woof/models/walkerModel.dart';

class CadastroDwPage extends StatefulWidget {
  const CadastroDwPage({super.key});

  static const String routeName = 'cadastro_dw';
  static const String routePath = '/cadastroDw';

  @override
  State<CadastroDwPage> createState() => _CadastroDwPageState();
}

class _CadastroDwPageState extends State<CadastroDwPage> {
  // Controllers para capturar os valores digitados nos campos
  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController(); // senha (só para FirebaseAuth)
  final _cpfCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _cepCtrl = TextEditingController();
  final _ruaCtrl = TextEditingController();
  final _bairroCtrl = TextEditingController();
  final _numCtrl = TextEditingController();
  final _estadoCtrl = TextEditingController();
  final _complCtrl = TextEditingController();

  // Chave para validar o formulário
  final _formKey = GlobalKey<FormState>();

  // Controla visibilidade da senha
  bool _obscurePass = true;

  // Controla estado de carregamento (para mostrar loading)
  bool _isLoading = false;

  // Controller que faz a ponte com o Service (GetX)
  final WalkerController _walkerController = Get.put(WalkerController());

  @override
  void dispose() {
    // Libera memória dos controllers quando sair da tela
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

  // Método para personalizar estilo dos campos de texto
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

  // Widget reutilizável para criar campos de formulário
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
      obscureText: obscure, // se for senha, esconde os caracteres
      decoration: _dec(label).copyWith(suffixIcon: suffixIcon),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      validator: validator, // validações (ex: email válido, campo vazio, etc.)
      cursorColor: Colors.black87,
    );
  }

  // Função que executa o fluxo de cadastro
  Future<void> _cadastrarWalker() async {
    // Valida formulário antes de enviar
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // 1. Criar usuário no FirebaseAuth (salva email e senha criptografada)
      UserCredential cred =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _senhaCtrl.text.trim(),
      );

      // 2. Pegar UID do usuário criado (identificador único)
      final uid = cred.user!.uid;

      // 3. Criar ID do documento do walker no Firestore
      final walkerId =
          FirebaseFirestore.instance.collection('walkers').doc().id;

      // 4. Criar objeto Walker (sem senha em texto!)
      final walker = Walker(
        walkerID: walkerId,
        addExperienciasAnteriores: '',
        bairro: _bairroCtrl.text,
        cep: _cepCtrl.text,
        complemento: _complCtrl.text.isEmpty ? null : _complCtrl.text,
        cpf: _cpfCtrl.text,
        dataNascimento: '',
        disponibilidades: '',
        email: _emailCtrl.text,
        estado: _estadoCtrl.text,
        extra: '',
        foto: '',
        localizacaoPasseios: '',
        nomeCompleto: _nomeCtrl.text,
        numero: int.tryParse(_numCtrl.text) ?? 0,
        rua: _ruaCtrl.text,
        telefone: _telCtrl.text,
        uidUser: uid, // vincula Walker ao usuário autenticado
      );

      // 5. Salvar walker no Firestore via Controller
      await _walkerController.createWalker(walker);

      // // 6. Exibir sucesso e ir para tela de perfil
      // Get.snackbar('Sucesso', 'DogWalker cadastrado com sucesso!');
      Navigator.of(context).pushNamed('/perfil_dw');
    } catch (e) {
      // Se algo der errado, exibe erro
      Get.snackbar('Erro', e.toString());
    } finally {
      // Finaliza carregamento
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Fecha o teclado ao tocar fora do campo
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
                // Imagem do topo
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
                // Formulário
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _campo(
                          label: 'Nome completo',
                          controller: _nomeCtrl,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Informe o nome'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'Email',
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Informe o email';
                            }
                            final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(v.trim());
                            return ok ? null : 'Email inválido';
                          },
                        ),
                        const SizedBox(height: 20),
                        _campo(
                          label: 'Senha',
                          controller: _senhaCtrl,
                          obscure: _obscurePass,
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                                () => _obscurePass = !_obscurePass),
                            icon: Icon(
                              _obscurePass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          validator: (v) => (v == null || v.length < 6)
                              ? 'Mínimo 6 caracteres'
                              : null,
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
                        const Text(
                          'Endereço',
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
                // Botão de cadastro
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
                      onPressed: _isLoading ? null : _cadastrarWalker,
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
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
