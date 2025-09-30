import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 // Certifique-se de criar este arquivo com as telas de destino

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _aceitouTermos = true;
  bool _isLoading = false; // Novo estado para carregamento

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  // Função para exibir mensagens de erro/informação
  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // 1. Lógica principal de login e redirecionamento
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_aceitouTermos) {
      _showSnackBar('Aceite os termos de uso para continuar.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Tenta autenticar o usuário com Email e Senha
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _senhaController.text.trim(),
      );

      final uid = userCredential.user!.uid;

      // 2. Verifica o papel do usuário no Firestore
      await _checkUserRoleAndNavigate(uid);

    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
          errorMessage = 'Email ou senha incorretos.';
          break;
        case 'invalid-email':
          errorMessage = 'O formato do email é inválido.';
          break;
        default:
          errorMessage = 'Ocorreu um erro no login. Tente novamente.';
          print('Erro de Auth: ${e.code}');
      }
      _showSnackBar(errorMessage);

    } catch (e) {
      _showSnackBar('Ocorreu um erro inesperado. Tente novamente.');
      print('Erro geral: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _checkUserRoleAndNavigate(String uid) async {
  final db = FirebaseFirestore.instance;

  // Verifica se existe um cliente com o uid_user == uid
  final clientQuery = await db
      .collection('clientes')
      .where('uid_user', isEqualTo: uid)
      .limit(1)
      .get();

  if (clientQuery.docs.isNotEmpty) {
    // Usuário é um cliente
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home_tutor');
    }
    return;
  }

  // Verifica se existe um walker com o uid_user == uid
  final walkerQuery = await db
      .collection('walkers')
      .where('uid_user', isEqualTo: uid)
      .limit(1)
      .get();

  if (walkerQuery.docs.isNotEmpty) {
    // Usuário é um walker
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
    return;
  }
    // Caso o UID exista no Auth, mas não esteja em nenhuma das coleções
    _showSnackBar('Seu perfil não foi encontrado. Contate o suporte.');
    await FirebaseAuth.instance.signOut(); // Desloga o usuário para segurança
}

 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF9E6),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/logo_woof.png',
                      width: 290,
                      height: 290,
                      fit: BoxFit.cover,
                      // Adicione um fallback caso a imagem não carregue:
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 290,
                        height: 290,
                        color: Colors.grey,
                        child: const Center(child: Text('Logo', style: TextStyle(color: Colors.white))),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Campos de texto
                  Flexible(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Email
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  filled: true,
                                  fillColor: const Color(0xFFF4C7B6),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.brown,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Digite seu email';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            // Senha
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: _senhaController,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                  hintText: 'Senha',
                                  filled: true,
                                  fillColor: const Color(0xFFF4C7B6),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.brown,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Digite sua senha';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            // Checkbox de termos
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _aceitouTermos,
                                    onChanged: (value) {
                                      setState(() {
                                        _aceitouTermos = value ?? false;
                                      });
                                    },
                                  ),
                                  const Expanded(
                                    child: Text(
                                      'Aceitar termos de uso do aplicativo',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Botão de entrar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF199700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                    onPressed: _isLoading ? null : _handleLogin, // Desabilita o botão durante o carregamento
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            'Entrar',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),

                  const SizedBox(height: 8),

                  // Link para cadastro
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/direcionamento');
                    },
                    child: const Text(
                      'Não tem conta? Cadastre-se!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF114411),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
