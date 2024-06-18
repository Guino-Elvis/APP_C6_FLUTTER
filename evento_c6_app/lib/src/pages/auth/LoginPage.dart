import 'package:evento_c6_app/src/config/ConfigApi.dart';
import 'package:evento_c6_app/src/model/auth/AuthRequestModel.dart';
import 'package:evento_c6_app/src/service/authService/ApiService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPIcallProcess = false;
  bool hidenPassword = true;
  GlobalKey<FormState> globalFormkey = GlobalKey<FormState>();

  String? email;
  String? password;
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
                child: _loginUI(context),
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

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            height: MediaQuery.of(context).size.height /5, 

            decoration: const BoxDecoration(
              
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/logosss2.png",
                    width: 160,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
         
          Column(
            children: [
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
                        color: Colors.green, // Color del ícono
                      ),
                    ),
                    Text(
                      "Universidad Sideral Carrion",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Icon(
                      Icons.email, // Ícono de correo electrónico
                      color: Colors.white, // Color del ícono
                    ),
                  ),
                  // Espacio entre el ícono y el campo de correo electrónico
                  Expanded(
                    child: FormHelper.inputFieldWidget(
                      context,
                      "email",
                      "  Email",
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
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20), // Agrega espacio a la izquierda del ícono
                    child: Icon(
                      Icons.lock, // Ícono que deseas usar
                      color: Colors.white, // Color del ícono
                    ),
                  ),
                  // SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FormHelper.inputFieldWidget(
                        context,
                        "password",
                        "  Password",
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
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
              top: 10,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Olvidó su contraseña? ',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Olvidó su contraseña");
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Login",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });

                  AuthRequestModel model =
                      AuthRequestModel(email: email, password: password);

                  ApiService.login(model).then((response) {
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    if (response) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        //  MaterialPageRoute(builder: (context) => HomePage()),
                        '/home',
                        (route) => false,
                      );
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        ConfigApi.appName,
                        "user invalido/ o contraseña incorrecta !",
                        "OK",
                        () {
                          Navigator.pop(context);
                        },
                      );
                    }
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
                    TextSpan(text: "Don'n have an account? "),
                    TextSpan(
                      text: 'Sign up ',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, "/register");
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
}
