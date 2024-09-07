import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../environment/environment.dart';
import '../models/proyecto_models.dart';
import '../models/response_api.dart';
import 'package:http/http.dart' as http;


class ProyectoProviders extends GetConnect {
  String url = Environment.API_URL + 'api/proyecto';

  Future<ResponseApi> create(Proyecto proyecto) async {
    final dateFormat = DateFormat('yyyy-MM-dd');

    if (proyecto.nombre == null || proyecto.fecha_inicio == null || proyecto.fecha_fin == null) {
      return ResponseApi(
        success: false,
        message: 'Datos incompletos. Todos los campos deben estar llenos.',
      );
    }

    try {
      final formattedStartDate = dateFormat.format(proyecto.fecha_inicio!);
      final formattedEndDate = dateFormat.format(proyecto.fecha_fin!);

      final Map<String, dynamic> proyectoJson = {
        'nombre': proyecto.nombre,
        'fecha_inicio': formattedStartDate,
        'fecha_fin': formattedEndDate,
      };

      print('JSON a enviar: ${jsonEncode(proyectoJson)}');

      final response = await http.post(
        Uri.parse('$url/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(proyectoJson),
      );

      if (response.statusCode != 201) {
        print('Error de conexión: ${response.reasonPhrase}');
        return ResponseApi(
          success: false,
          message: 'Error de conexión: ${response.reasonPhrase}',
        );
      }

      final responseJson = jsonDecode(response.body);
      ResponseApi responseApi = ResponseApi.fromJson(responseJson);
      return responseApi;

    } catch (e) {
      // Manejo de excepciones
      return ResponseApi(
        success: false,
        message: 'Ocurrió un error inesperado: $e',
      );
    }
  }


  Future<ResponseApi> getAll() async {
    try {
      final response = await get('$url/list');

      if (response.status.hasError) {
        print('Error de conexión: ${response.statusText}');
        print('Código de estado: ${response.statusCode}');
        print('Respuesta: ${response.bodyString}');
        return ResponseApi(
          success: false,
          message: 'Error de conexión: ${response.statusText}',
        );
      }

      final responseBody = response.body;
      List<dynamic> proyectosJson;

      if (responseBody is Map<String, dynamic>) {
        proyectosJson = responseBody['data'] as List<dynamic>;
      } else if (responseBody is List) {
        proyectosJson = responseBody;
      } else {
        throw Exception('El formato de la respuesta no es compatible.');
      }

      final List<Proyecto> proyectos = proyectosJson.map((json) => Proyecto.fromJson(json)).toList();

      return ResponseApi(
        success: true,
        data: proyectos,
      );
    } catch (e) {
      print('Excepción capturada: $e');
      return ResponseApi(
        success: false,
        message: 'Ocurrió un error inesperado: $e',
      );
    }
  }

}
