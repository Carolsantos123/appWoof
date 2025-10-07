import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String _apiKey = 'f85eb4be'; // substitua pela sua key
  final int _woeidArapo = 455827; // Araçatuba

  /// Retorna a temperatura atual de Araçatuba como String
  Future<String> getTemperaturaAracatuba() async {
    final url =
        Uri.parse('https://api.hgbrasil.com/weather?woeid=$_woeidArapo&key=$_apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final currentTemp = data['results']['temp'];

        if (currentTemp != null) {
          return '${currentTemp.toString()}°C';
        } else {
          return 'Temperatura não encontrada';
        }
      } else {
        return 'Temperatura não encontrada';
      }
    } catch (e) {
      print('Erro ao buscar temperatura: $e');
      return 'Temperatura não encontrada';
    }
  }

  /// Retorna o clima completo da cidade
  Future<Map<String, dynamic>?> getClimaAracatuba() async {
    final url =
        Uri.parse('https://api.hgbrasil.com/weather?woeid=$_woeidArapo&key=$_apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['results'];
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao buscar clima: $e');
      return null;
    }
  }
}
