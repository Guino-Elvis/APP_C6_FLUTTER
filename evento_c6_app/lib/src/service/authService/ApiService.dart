import 'dart:convert';


import 'package:evento_c6_app/src/config/ConfigApi.dart';
import 'package:evento_c6_app/src/model/auth/AuthRequestModel.dart';
import 'package:evento_c6_app/src/model/auth/AuthResponseModel.dart';
import 'package:evento_c6_app/src/model/auth/RegisterRequestModel.dart';
import 'package:evento_c6_app/src/model/auth/RegisterResponseModel.dart';
import 'package:evento_c6_app/src/service/authService/ShareApiTokenService.dart';
import 'package:http/http.dart' as http;

class ApiService {
  
  static var client = http.Client();
  
  static Future<bool> login(AuthRequestModel model) async {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
  };

  var url = Uri.http(ConfigApi.apiURL, ConfigApi.loginAPI);

  var response = await client.post(
    url,
    headers: requestHeaders,
    body: jsonEncode(model.toJson()),
  );
  if (response.statusCode == 200) {
    final authResponse = authResponseJson(response.body);

    // Agrega esta línea para imprimir el token en la consola
    print('Token obtenido en el inicio de sesión: ${authResponse.token}');
        // Convierte el objeto del usuario en una representación de cadena y luego imprímelo
    final userAsString = authResponse.user != null
        ? authResponse.user!.toJson().toString()
        : "Usuario no disponible";
    print('Usuario obtenido en el inicio de sesión: $userAsString');
    await ShareApiTokenService.setLoginDetails(authResponse);

    return true;
  } else {
    return false;
  }
}


static Future<RegisterResponseModel> register(RegisterRequestModel model) async {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
  };

  var url = Uri.http(ConfigApi.apiURL, ConfigApi.registerAPI);

  try {
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseModel(response.body);
  } catch (error) {
    // En caso de error, lanzar una excepción con el mensaje de error.
    throw Exception("Error en el registro: $error");
  }
}
  static Future<List<String>> getUserProfile() async {
  var loginDetails = await ShareApiTokenService.loginDetails();
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Basic ${loginDetails!.token}',
  };

  var url = Uri.http(ConfigApi.apiURL, ConfigApi.listUserAPI);

  var response = await client.get(
    url,
    headers: requestHeaders,
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    final List<String> emails = jsonData.map((dynamic item) {
      return item["email"].toString(); // Ajusta la extracción al campo "email"
    }).toList();

    return emails;
  } else {
    return [];
  }
}

}