import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:woof/pages/dw/agenda.dart';
import 'package:woof/pages/dw/avaliacoes.dart';
import 'package:woof/pages/dw/cadastro_dw.dart';
import 'package:woof/direcionamento.dart';
import 'package:woof/pages/dw/calendario.dart';
import 'package:woof/pages/dw/experiencias.dart';
import 'package:woof/pages/dw/financias.dart';
import 'package:woof/pages/dw/historico.dart';
import 'package:woof/pages/dw/home.dart';
// import 'package:woof/pages/dw/historico_dia.dart';
import 'package:woof/pages/dw/notificacoes.dart';
import 'package:woof/pages/dw/perfil_dw.dart';
import 'package:woof/pages/dw/solicita%C3%A7%C3%B5es.dart';
import 'package:woof/pages/login.dart';
import 'package:woof/pages/tutor/cadastro_pet.dart';
import 'package:woof/pages/tutor/cadastro_tutor.dart';
import 'package:woof/pages/tutor/cd_perfil.dart';
import 'package:woof/pages/tutor/editar_perfil.dart';
import 'package:woof/pages/tutor/home.dart';
import 'package:woof/pages/tutor/perfil_tutor.dart';

void main() async {
  runApp(MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', ''), // Inglês
      const Locale('pt', ''), // Português
    ],
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => LoginScreen(),
      '/cadastro_dw': (context) => CadastroDwPage(),
      '/direcionamento': (context) => DirecionamentoWidget(),
      '/perfil_dw': (context) => PerfilDwScreen(),
      '/experiencias': (context) => ExperienciasScreen(),
      '/home': (context) => HomeScreen(),
      '/solicitacoes': (context) => SolicitacoesScreen(),
      '/calendario': (context) => CalendarioScreen(),
      '/agenda': (context) => AgendaDWWidget(),
      '/avaliacoes': (context) => AvaliacoesScreen(),
      '/financas': (context) => FinancasScreen(),
      '/notificacoes': (context) => notificacoesScreen(),
      '/historico_calendario': (context) => CalendarioHistoricoWidget(),
      '/cadastro_tutor': (context) => Cadastro_tutorPage(),
      '/cadastro_pet': (context) => CadastroPetScreen (),
      '/perfil_tutor': (context) => PerfilTutorScreen (),
      '/editar_perfil': (context) => EditarPerfilScreen(),
      '/home_tutor': (context) => HomeTutorpetScreen (),
      '/perfil': (context) => PerfilTutorWidget (),
                },
  ));
}
