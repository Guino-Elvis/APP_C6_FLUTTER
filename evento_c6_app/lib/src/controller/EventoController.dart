// ignore_for_file: file_names
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:evento_c6_app/src/config/ConfigApi.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EventoController {

   Future<List<dynamic>> getDataEvento({String tipo = '', String seccion = ''}) async {
      final response = await http.get(Uri.parse(ConfigApi.buildUrl('/evento')));
      if (response.statusCode == 200) {
        final List<dynamic> eventos = json.decode(response.body);

        // Filtrar eventos por tipo si se proporciona el parámetro
        if (tipo.isNotEmpty) {
          eventos.retainWhere((evento) => evento['tipo'] == tipo);
        }

        // Filtrar eventos por sección si se proporciona el parámetro
        if (seccion.isNotEmpty) {
          eventos.retainWhere((evento) => evento['seccion'] == seccion);
        }

        return eventos;
      } else {
        throw Exception('Failed to load events');
      }
    }


    Future<List<dynamic>> getData() async {
      final response =
          await http.get(Uri.parse(ConfigApi.buildUrl('/evento')));
      return json.decode(response.body);
    }

Future<http.Response> crearEvento(
  String userId,
  String nombre,
  String seccion,
  String tipo,
  String fecha_inicio,
  String fecha_fin,
  String foto,
) async {
  Map<String, dynamic> data = {
    'userId': userId,
    'nombre': nombre,
    'seccion': seccion,
    'tipo': tipo,
    'fecha_inicio': fecha_inicio,
    'fecha_fin': fecha_fin,
    'foto': foto,
  };

  var body = json.encode(data);
  var response = await http.post(
    Uri.parse(ConfigApi.buildUrl('/evento')),
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  print("${response.statusCode}");
  print("${response.body}");

  return response;
}

  //function for update or put
  Future<http.Response> editarEvento({
   required String id,
   required String userId,
   required String nombre,
   required String seccion,
   required String tipo,
   required String fecha_inicio,
   required String fecha_fin,
   required String foto,
  }) async {
    int a = int.parse(id);
    print(a);

     Map<String, dynamic> data = {
      'id': '$a',
      'userId': userId,
      'nombre': nombre,
      'seccion': seccion,
      'tipo': tipo,
      'fecha_inicio': fecha_inicio,
      'fecha_fin': fecha_fin,
      'foto': foto,

    };

    // Codifica el Map en JSON
    var body = json.encode(data);

    var response = await http.put(
      Uri.parse(ConfigApi.buildUrl('/evento')),
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> removerEvento(String id, String fotoURL) async {
    int a = int.parse(id);
    print(a);

    var url = ConfigApi.buildUrl('/evento/$a');

    // Verifica si la fotoURL no es nula ni vacía antes de intentar eliminarla
    if (fotoURL != null && fotoURL.isNotEmpty) {
      // Elimina la foto de Firebase Storage
      await FirebaseStorage.instance.refFromURL(fotoURL).delete();
    }

    var response = await http.delete(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    print("${response.statusCode}");
    return response;
  }



}
