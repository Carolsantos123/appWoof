import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DirecionamentoWidget extends StatefulWidget {
  const DirecionamentoWidget({Key? key}) : super(key: key);

  static String routeName = 'direcionamento';
  static String routePath = '/direcionamento';

  @override
  State<DirecionamentoWidget> createState() => _DirecionamentoWidgetState();
}

class _DirecionamentoWidgetState extends State<DirecionamentoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFFFF9E6),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/logo_woof.png',
                          width: 280,
                          height: 270,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Selecione uma opção',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: const Color(0xFF074800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed('/cadastro_dw');
                          } ,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF7C8),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/mulher_cachorro.png'),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: const Alignment(-1, 0),
                            child: Align(
                              alignment: const Alignment(0, 1),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  'Sou dogWalker',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                         GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/cadastro_tutor');
                          },
                          child: Container(        
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF7C8),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/cachorro.png'),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: const Alignment(0, 1),
                            child:
                             Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                'Sou tutor',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                         )
                      ],
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
