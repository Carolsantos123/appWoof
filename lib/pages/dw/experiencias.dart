import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExperienciasScreen extends StatefulWidget {
  const ExperienciasScreen({super.key});

  @override
  State<ExperienciasScreen> createState() => _ExperienciasScreenState();
}

class _ExperienciasScreenState extends State<ExperienciasScreen> {
  // Inicialização dos controladores para os campos de texto
  final TextEditingController textController1 = TextEditingController(); // Experiências
  final TextEditingController textController2 = TextEditingController(); // Disponibilidade
  final TextEditingController textController3 = TextEditingController(); // Regiões
  final TextEditingController textController4 = TextEditingController(); // Extras

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Estado de carregamento

  @override
  void dispose() {
    // É crucial descartar os controladores para liberar a memória
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    textController4.dispose();
    super.dispose();
  }

  // Método auxiliar para exibir SnackBar
  void _showSnackBar(String message, {bool isError = false}) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red.shade800 : const Color(0xFF199700),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  // Função principal para salvar os dados no Firestore
  Future<void> _saveExperiences() async {
    // 1. Validação (Pode ser mais robusta, mas vamos manter simples por enquanto)
    if (!_formKey.currentState!.validate()) {
      _showSnackBar('Preencha todos os campos obrigatórios.', isError: true);
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showSnackBar('Erro: Você não está logado. Tente fazer login novamente.', isError: true);
      // Redireciona para login ou trata erro de autenticação
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Dados a serem atualizados
    Map<String, dynamic> updateData = {
      // Usamos os nomes dos campos conforme seu documento de exemplo do Firestore
      'add_experiencias_anteriores': textController1.text.trim(),
      'disponibilidades': textController2.text.trim(),
      'localizacao_passeios': textController3.text.trim(),
      'extra': textController4.text.trim(),
    };

    try {
      // 2. Referência ao documento do Walker (assumimos que o UID do Auth é o Doc ID)
      await FirebaseFirestore.instance
          .collection('walkers')
          .doc(user.uid)
          .update(updateData);

      _showSnackBar('Experiências cadastradas com sucesso!');
      
      // Navega para a próxima tela após o sucesso
      if (mounted) {
         Navigator.of(context).pushNamed('/perfil_dw');
      }
      
    } on FirebaseException catch (e) {
      _showSnackBar('Erro ao salvar no Firestore: ${e.message}', isError: true);
      print('Erro de Firestore: $e');
    } catch (e) {
      _showSnackBar('Ocorreu um erro inesperado. $e', isError: true);
      print('Erro geral: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  // Método auxiliar para criar a decoração dos campos de texto
  InputDecoration _dec(String label) {
    return InputDecoration(
      labelText: label,
      isDense: true,
      hintText: 'Digite aqui a sua experiência...',
      filled: true,
      fillColor: const Color(0x8DF4C7B6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      labelStyle: const TextStyle(color: Color(0xFF074800)), // Cor mais escura para o label
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
      maxLines: maxLines ?? 3, // Padrão de 3 linhas para descrições longas
      decoration: _dec(label),
      style: const TextStyle(
        color: Color(0xFF333333), // Alterado para uma cor mais legível
        fontSize: 16,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo é obrigatório para o cadastro.';
        }
        return null;
      },
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
            child: Form(
              key: _formKey, // Adição da chave do formulário
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
                      label: 'Informações extras (ex. especializações, técnicas de adestramento):',
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
                        // Chama a nova função de salvar
                        onPressed: _isLoading ? null : _saveExperiences,
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
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
      ),
    );
  }
}
