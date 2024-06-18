// ignore_for_file: file_names
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:evento_c6_app/src/config/ConfigApi.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UsuarioController {

    Future<List<dynamic>> getData() async {
      final response =
          await http.get(Uri.parse(ConfigApi.buildUrl('/auth/list')));
      return json.decode(response.body);
    }

  Future<http.Response> CrearUsuario(
    String nameController,
    String roleController,
    String emailController,
    String passwordController,
    String confirmPasswordController,
    String apellido_pController,
    String apellido_mController,
    String dniController,
    String codigoController,
    String fotoController,

  ) async {
    Map data = {
      'name': '$nameController',
      'role': '$roleController',
      'email': '$emailController',
      'password': '$passwordController',
      'confirmPassword': '$confirmPasswordController',
      'apellido_p': '$apellido_pController',
      'apellido_m': '$apellido_mController',
      'dni': '$dniController',
      'codigo': '$codigoController',
      'foto': '$fotoController',

    };

    var body = json.encode(data);
    var response =
        await http.post(Uri.parse(ConfigApi.buildUrl('/auth/create')),
            // var response = await http.post(Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  //function for update or put
  Future<http.Response> editarUsuario(
    String id,
    String nameController,
    String apellido_pController,
    String apellido_mController,
    String dniController,
    String codigoController,
    String roleController,
    String emailController,
    String passwordController,
     String fotoController,
  ) async {
    int a = int.parse(id);
    print(a);

    Map data = {
      'id': '$a',
      'name': '$nameController',
      'apellido_p': '$apellido_pController',
      'apellido_m': '$apellido_mController',
      'dni': '$dniController',
      'codigo': '$codigoController',
      'role': '$roleController',
      'email': '$emailController',
      'password': '$passwordController',
      'foto': '$fotoController',

    };

    // Codifica el Map en JSON
    var body = json.encode(data);

    var response = await http.put(
      Uri.parse(ConfigApi.buildUrl('/auth')),
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> removerUsuario(String id, String fotoURL) async {
    int a = int.parse(id);
    print(a);

    var url = ConfigApi.buildUrl('/auth/delete/$a');

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
