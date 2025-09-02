import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woof/pages/dw/historico_dia.dart';

class CalendarioHistoricoWidget extends StatefulWidget {
  const CalendarioHistoricoWidget({super.key});

  @override
  State<CalendarioHistoricoWidget> createState() => _CalendarioHistoricoWidgetState();
}

class _CalendarioHistoricoWidgetState extends State<CalendarioHistoricoWidget> {
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFBE4),
        appBar: AppBar(
          backgroundColor: const Color(0xFFB1F3A3),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF074800),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Histórico',
            style: GoogleFonts.interTight(
              color: const Color(0xFF074800),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFBE4),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFF074800),
                      onPrimary: Color(0xFFB1F3A3),
                      onSurface: Colors.black,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      onDateChanged: (DateTime newDate) {
                        setState(() {
                          
                        });
                        // Navega para a tela HistoricoDiaWidget quando a data é selecionada.
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HistoricodiaWidget(selectedDate: newDate),
                          ),
                        );
                      },
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

