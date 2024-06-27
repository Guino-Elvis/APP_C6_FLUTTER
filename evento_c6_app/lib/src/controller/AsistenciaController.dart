import 'package:android_path_provider/android_path_provider.dart';
import 'package:evento_c6_app/src/config/ConfigApi.dart';
import 'package:evento_c6_app/src/service/authService/ShareApiTokenService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AsistenciaController {
  Future<List<dynamic>> getDataListAsistencia() async {
    final url = Uri.parse(ConfigApi.buildUrl('/asistencia'));
    final response = await http.get(url);
    return json.decode(response.body);
  }

   Future<List<dynamic>> getDataAsistencia() async {
    // Obtén los detalles de autenticación del usuario
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      // Obtiene el ID del usuario que ha iniciado sesión
      final userId = authResponse.user?.id;
      if (userId != null) {
        // Construye la URL para la solicitud de asistencia
        final url = Uri.parse(ConfigApi.buildUrl('/asistencia'));
        // Realiza la solicitud HTTP sin el token de autenticación
        final response = await http.get(url);

        if (response.statusCode == 200) {
          // Decodifica la respuesta JSON
          List<dynamic> responseData = json.decode(response.body);

          // Filtra las asistencias por el ID del usuario logueado
          List<dynamic> userAsistencias = responseData
              .where((reserva) => reserva['userId'] == userId)
              .toList();

          for (var item in userAsistencias) {
            if (item['created_at'] is String) {
              item['created_at'] = DateTime.parse(item['created_at']);
            }
            if (item['updated_at'] is String) {
              item['updated_at'] = DateTime.parse(item['updated_at']);
            }
          }
          // Devuelve las asistencias filtradas por el ID del usuario logueado
          return userAsistencias;
        } else {
          print("Error al obtener datos de asistencia. Código de estado: ${response.statusCode}");
          return [];
        }
      }
    }
    return [];
  }

  Future<http.Response> crearAsistencia(
    String userIdController,
    String fechaController,
    dynamic eventoId,
    String estadoController,
  ) async {
    Map data = {
      'userId': '$userIdController',
      'fecha': '$fechaController',
      'evento': eventoId,
      'estado': '$estadoController',
    };
    var body = json.encode(data);
    print('Cuerpo de la solicitud: $body');
    var response = await http.post(
      Uri.parse(ConfigApi.buildUrl('/asistencia')),
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> editarAsistencia(
    String id,
    String userIdController,
    String fechaController,
    dynamic eventoController,
    String estadoController,
  ) async {
    int a = int.parse(id);
    Map<String, dynamic> eventoData = {
      'id': eventoController['id'],
    };
    Map data = {
      'id': '$a',
      'userId': '$userIdController',
      'fecha': '$fechaController',
      'evento': eventoData,
      'estado': '$estadoController',
    };

    var body = json.encode(data);
    var response = await http.put(
      Uri.parse(ConfigApi.buildUrl('/asistencia')),
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> removerAsistencia(
    String id,
  ) async {
    int a = int.parse(id);
    print(a);

    var url = ConfigApi.buildUrl('/asistencia/$a');

    var response = await http.delete(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print("${response.statusCode}");
    return response;
  }
}
