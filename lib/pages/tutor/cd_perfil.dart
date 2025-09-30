import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woof/pages/tutor/cadastro_pet.dart';

class PerfilTutorWidget extends StatefulWidget {
  const PerfilTutorWidget({super.key});

  @override
  State<PerfilTutorWidget> createState() => _PerfilTutorWidgetState();
}

class _PerfilTutorWidgetState extends State<PerfilTutorWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  File? _imageFile;
  String? _imageUrl;
  String? _nomeTutor;
  String? _clienteDocId;
  final picker = ImagePicker();

  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _checkLoginAndLoadData();
  }

  /// 1️⃣ Verifica se o usuário está logado
  Future<void> _checkLoginAndLoadData() async {
    _currentUser = FirebaseAuth.instance.currentUser;

    if (_currentUser == null) {
      // Não está logado → redireciona para a tela de login
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    // Está logado → busca dados do tutor
    await _loadTutorData(_currentUser!.uid);
  }

  /// 2️⃣ Busca dados do tutor usando uid_user
  Future<void> _loadTutorData(String uid) async {
    try {
      final query = await FirebaseFirestore.instance
          .collection('clientes')
          .where('uid_user', isEqualTo: uid)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        final data = query.docs.first.data();
        setState(() {
          _imageUrl = data['foto_perfil'];
          _nomeTutor = data['nome'] ?? "Tutor";
          _clienteDocId = query.docs.first.id;
        });
      } else {
        // Caso não encontre o tutor cadastrado, redireciona para cadastro
        Navigator.pushReplacementNamed(context, '/cadastro_tutor');
      }
    } catch (e) {
      print("Erro ao carregar dados do tutor: $e");
    }
  }

  /// Seleciona imagem da galeria
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  /// Upload da imagem e atualização no Firestore
  Future<void> _uploadImage() async {
    if (_imageFile == null || _clienteDocId == null) return;

    try {
      final storageRef =
          FirebaseStorage.instance.ref().child("perfil/${_currentUser!.uid}.jpg");
      await storageRef.putFile(_imageFile!);
      final downloadUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('clientes')
          .doc(_clienteDocId)
          .set({'foto_perfil': downloadUrl}, SetOptions(merge: true));

      setState(() {
        _imageUrl = downloadUrl;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Foto de perfil atualizada!")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Erro ao enviar imagem: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Enquanto verifica login/carrega dados, mostra loading
    if (_currentUser == null || _clienteDocId == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFFFF9E6),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Perfil',
                    style: TextStyle(color: Color(0xFF0F5100), fontSize: 40),
                  ),
                  const SizedBox(height: 20),

                  // Foto do perfil
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _imageUrl != null
                            ? NetworkImage(_imageUrl!)
                            : const NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Botão para adicionar foto
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: FilledButton(
                      onPressed: _pickImage,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0x66B1F3A3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, size: 18, color: Color(0xFF074800)),
                          SizedBox(width: 5),
                          Text('Foto', style: TextStyle(color: Color(0xFF074800), fontSize: 14)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Nome do tutor
                  Text(
                    _nomeTutor ?? "Tutor",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF074800),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Botão cadastrar pet
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      height: 95,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB1F3A3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'Cadastrar meu pet',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (_clienteDocId != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CadastroPetScreen(
                                      clienteId: _clienteDocId!,
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xFFFF9500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Botão iniciar passeios
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamed('/home_tutor'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF199700),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text(
                      'Iniciar passeios',
                      style: GoogleFonts.poppins(color: const Color(0xFFFFF9E6), fontSize: 16),
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
