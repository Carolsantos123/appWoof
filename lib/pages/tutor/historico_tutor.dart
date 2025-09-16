import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ajuste o import para o nome correto do arquivo/classe
import 'package:woof/pages/tutor/hitoricodia_tutor.dart';

class CalendarioHistorico extends StatefulWidget {
  const CalendarioHistorico({super.key});

  @override
  State<CalendarioHistorico> createState() => _CalendarioHistoricoState();
}

class _CalendarioHistoricoState extends State<CalendarioHistorico> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFBE4),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF9500),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFFFFBE4)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Histórico',
            style: GoogleFonts.interTight(
              color: const Color(0xFFFFFBE4),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              color: const Color(0xFFFFFBE4),
              padding: const EdgeInsets.all(16),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: const Color(0xFFFFB74D), // 🔥 cor do fundo do dia selecionado
                    onPrimary: const Color(0xFFFFB74D), // 🔥 número em laranja claro
                    onSurface: Colors.black, // números normais
                  ),
                ),
                child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate:
                      DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  onDateChanged: (DateTime newDate) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Historicodia_tutorWidget(
                          selectedDate: newDate,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
}
