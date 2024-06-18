import 'dart:convert';

RegisterResponseModel registerResponseModel(String str) =>
RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  RegisterResponseModel({
    required this.message,
    required this.user,

  });
  late final  String message;
  late final  User? user;

 

  // AuthModel.dart({this.email, this.password});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
  if (json.containsKey('message')) {
    message = json['message'];
  } else {
    message = 'Mensaje no encontrado'; // Puedes proporcionar un valor predeterminado
  }
  user = json.containsKey('user') ? User.fromJson(json['user']) : null;
}


  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['user'] = user!.toJson();
    return _data;
  }
}

class User {
	int? id;
	// Null? role;
	// Null? name;
	String? email;
	String? password;
	String? confirmPassword;

	User({this.id, this.email, this.password, this.confirmPassword});

	User.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		// role = json['role'];
		// name = json['name'];
		email = json['email'];
		password = json['password'];
		confirmPassword = json['confirmPassword'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		// data['role'] = this.role;
		// data['name'] = this.name;
		data['email'] = this.email;
		data['password'] = this.password;
		data['confirmPassword'] = this.confirmPassword;
		return data;
	}
}