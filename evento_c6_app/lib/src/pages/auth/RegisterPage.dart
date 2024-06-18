import 'package:evento_c6_app/src/config/ConfigApi.dart';
import 'package:evento_c6_app/src/model/auth/RegisterRequestModel.dart';
import 'package:evento_c6_app/src/service/authService/ApiService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAPIcallProcess = false;
  bool hidenPassword = true;
  GlobalKey<FormState> globalFormkey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? confirmPassword;

   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // Fondo de imagen
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fondo45.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Color encima
            Container(
               color: HexColor("#0f4a42").withOpacity(0.8),
            ),
            // Contenido de la página
            ProgressHUD(
              child: Form(
                key: globalFormkey,
                child: _registerUI(context),
              ),
              inAsyncCall: isAPIcallProcess,
              opacity: 0.3,
              key: UniqueKey(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            height: MediaQuery.of(context).size.height /
                5, // Ajusta la altura aqui de la parte blanca
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/logosss2.png",
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 30,
              top: 50,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8), // Ajusta el espacio a la derecha del ícono
                  child: Icon(
                    Icons.person, // Ícono que deseas usar
                    color: Colors.white, // Color del ícono
                  ),
                ),
                Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 1.0), // Espacio vertical alrededor del campo
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 1),
                      child: Icon(
                        Icons.email, // Ícono de correo electrónico
                        color: Colors.white, // Color del ícono
                      ),
                    ),
                    Expanded(
                      child: FormHelper.inputFieldWidget(
                        context,
                        "email",
                        "@Email",
                        (onValidateVal) {
                          if (onValidateVal.isEmpty) {
                            return "Email can't be empty.";
                          }
                          return null;
                        },
                        (onSavedVal) {
                          email = onSavedVal;
                        },
                        borderErrorColor: Colors.white,
                        prefixIconColor: Colors.white,
                        borderColor: Colors.white,
                        textColor: Colors.white,
                        hintColor: Colors.white.withOpacity(0.7),
                        borderRadius: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0), // Espacio vertical alrededor del campo
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 1),
                      child: Icon(
                        Icons.lock, // Ícono del candado
                        color: Colors.white, // Color del ícono
                      ),
                    ),
                    Expanded(
                      child: FormHelper.inputFieldWidget(
                        context,
                        "password",
                        "* Password",
                        (onValidateVal) {
                          if (onValidateVal.isEmpty) {
                            return "Password can't be empty.";
                          }
                          return null;
                        },
                        (onSavedVal) {
                          password = onSavedVal;
                        },
                        borderErrorColor: Colors.white,
                        prefixIconColor: Colors.white,
                        borderColor: Colors.white,
                        textColor: Colors.white,
                        hintColor: Colors.white.withOpacity(0.7),
                        borderRadius: 10,
                        obscureText: hidenPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidenPassword = !hidenPassword;
                            });
                          },
                          color: Colors.white.withOpacity(0.7),
                          icon: Icon(
                            hidenPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 1.0), // Espacio vertical alrededor del campo
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20,
                          bottom: 1),
                          
                      child: Icon(
                        Icons.lock, // Ícono del candado
                        color: Colors.white, // Color del ícono
                      ),
                      
                    ),
                    Expanded(
                      child: FormHelper.inputFieldWidget(
                        context,
                        "confirmPassword",
                        "* Confirm Password",
                        (onValidateVal) {
                          if (onValidateVal.isEmpty) {
                            return "Confirm Password can't be empty.";
                          }
                          return null;
                        },
                        (onSavedVal) {
                          confirmPassword = onSavedVal;
                        },
                        borderErrorColor: Colors.white,
                        prefixIconColor: Colors.white,
                        borderColor: Colors.white,
                        textColor: Colors.white,
                        hintColor: Colors.white.withOpacity(0.7),
                        borderRadius: 10,
                        obscureText: hidenPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidenPassword = !hidenPassword;
                            });
                          },
                          color: Colors.white.withOpacity(0.7),
                          icon: Icon(
                            hidenPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Registrar",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });

                  RegisterRequestModel model = RegisterRequestModel(
                    email: email,
                    password: password,
                    confirmPassword: confirmPassword,
                  );

                  ApiService.register(model).then((response) {
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    if (response.user != null) {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        ConfigApi.appName,
                        "Te registraste correctamente. Ahora puedes logearte",
                        "OK",
                        () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        },
                      );
                    } else {
                      // En caso de error, mostrar un diálogo de error
                      showErrorDialog(context, response.message);
                    }
                  }).catchError((error) {
                    // Manejar errores aquí, por ejemplo, mostrar un diálogo de error
                    showErrorDialog(context, error.toString());
                  });
                }
              },
              btnColor: HexColor("#0f4a42").withOpacity(0.8),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
              top: 10,
            ),
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Do you already have an account?"),
                    TextSpan(
                      text: 'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, "/login");
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Redirigir al usuario de nuevo a la página de registro
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
