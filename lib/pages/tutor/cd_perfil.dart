import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilTutorWidget extends StatefulWidget {
  const PerfilTutorWidget({super.key});

  @override
  State<PerfilTutorWidget> createState() => _PerfilTutorWidgetState();
}

class _PerfilTutorWidgetState extends State<PerfilTutorWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFFFF9E6),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Perfil',
                        style: TextStyle(
                          color: Color(0xFF0F5100),
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1506863530036-1efeddceb993?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxM3x8cGVyZmlsfGVufDB8fHx8MTc1NDMyNjAyNnww&ixlib=rb-4.1.0&q=80&w=1080',
                        ),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2,
                          color: Color(0x32000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    alignment: const AlignmentDirectional(0, 0),
                  ),
                ),
                // Botão para adicionar foto, mantendo a consistência de estilo
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 100,
                    height: 35,
                    child: FilledButton(
                      onPressed: () {
                        // TODO: Adicionar lógica para selecionar foto
                        print('Adicionar foto pressionado...');
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0x66B1F3A3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, size: 18, color: Color(0xFF074800)),
                          SizedBox(width: 5),
                          Text(
                            'Foto',
                            style: TextStyle(
                              color: Color(0xFF074800),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: const AlignmentDirectional(0, -1),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Nome do tutor',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: Container(
                    width: 400,
                    height: 95,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB1F3A3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: Text(
                              'Cadastrar meu pet',
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/cadastro_pet');
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 24,
                            color: Color(0xFFFF9500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: Container(
                    width: 400,
                    height: 95,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB1F3A3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: Text(
                              'Editar minhas informações',
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/editar_perfil');
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 24,
                            color: Color(0xFFFF9500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/home_tutor1');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF199700),
                    elevation: 0,
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: Text(
                    'Iniciar passeios',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFFF9E6),
                      fontSize: 16,
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