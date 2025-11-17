import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:woof/firebase_options.dart';
import 'package:woof/pages/dw/agenda.dart';
import 'package:woof/pages/dw/avaliacoes.dart';
import 'package:woof/pages/dw/cadastro_dw.dart';
import 'package:woof/direcionamento.dart';
import 'package:woof/pages/dw/calendario.dart';
import 'package:woof/pages/dw/editar_perfildw.dart';
import 'package:woof/pages/dw/experiencias.dart';
import 'package:woof/pages/dw/financias.dart';
import 'package:woof/pages/dw/historico.dart';
import 'package:woof/pages/dw/home.dart';
import 'package:woof/pages/dw/notificacoes.dart';
import 'package:woof/pages/dw/perfil_dw.dart';
import 'package:woof/pages/dw/perfildw_home.dart';
import 'package:woof/pages/dw/solicitacoes.dart';
import 'package:woof/pages/login.dart';
import 'package:woof/pages/tutor/cadastro_tutor.dart';
import 'package:woof/pages/tutor/cd_perfil.dart';
import 'package:woof/pages/tutor/editar_perfil.dart';
import 'package:woof/pages/tutor/feedback_tutor.dart';
import 'package:woof/pages/tutor/historico_tutor.dart';
import 'package:woof/pages/tutor/home.dart';
import 'package:woof/pages/tutor/notificacao_tutor.dart';
import 'package:woof/pages/tutor/pefil_pet.dart';
import 'package:woof/pages/tutor/perfil_dw.dart';
import 'package:woof/pages/tutor/perfil_tutor.dart';
import 'package:woof/pages/tutor/solicitacao_tutor.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      '/perfildw_home': (context) => PerfilDwhomeScreen(),
      '/solicitacoes': (context) => SolicitacoesScreen(),
      '/calendario': (context) => CalendarioScreen(),
      '/agenda': (context) => AgendaDWWidget(),
      '/avaliacoes': (context) => AvaliacoesScreen(),
      '/financas': (context) => FinancasScreen(),
      '/planos': (context) => PlanosScreen(),
      '/historico_calendario': (context) => HistoricodiaWidget(
  selectedDate: DateTime.now(), // data padrão (ex: hoje)
),
      '/editar_perfildw': (context) => EditarPerfildwScreen(),
      '/cadastro_tutor': (context) => Cadastro_tutorPage(),
      '/perfil_tutor': (context) => PerfilTutorScreen(),
      '/editar_perfiltutor': (context) => EditarPerfilScreen(),
      '/visor_perfiltutor': (context) => PerfilTutorWidget(),
      '/home_tutor': (context) => HomeTutorScreen(),
      '/perfildw_tutor': (context) => PerfilDw_tutorScreen(),
      '/notificacoes_tutor': (context) => NotificacoesTutorScreen(),
      '/perfil_pet': (context) => PerfilPetScreen(),
      '/feedback_tutor': (context) => FeedbackTutorScreen(),
      '/historico_tutor': (context) => MeusPasseiosScreen(),
      '/passeios_tutor': (context) => SolicitarPasseioScreen(),
          },
  ));
}
