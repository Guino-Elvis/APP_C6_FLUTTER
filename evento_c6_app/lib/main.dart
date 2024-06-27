import 'package:evento_c6_app/src/component/Actualizar.dart';
import 'package:evento_c6_app/src/config/theme.dart';
import 'package:evento_c6_app/src/pages/admin/asistencia_admin.dart';
import 'package:evento_c6_app/src/pages/auth/LoginPage.dart';
import 'package:evento_c6_app/src/pages/auth/RegisterPage.dart';
import 'package:evento_c6_app/src/pages/cruds/evento/EventoList.dart';
import 'package:evento_c6_app/src/pages/cruds/usuario/UsuarioList.dart';
import 'package:evento_c6_app/src/pages/inicio_asistencia.dart';
import 'package:evento_c6_app/src/pages/inicio_evento.dart';
import 'package:evento_c6_app/src/service/authService/ShareApiTokenService.dart';
import 'package:evento_c6_app/src/view/AdminHomePage.dart';
import 'package:evento_c6_app/src/view/HomePage.dart';
import 'package:evento_c6_app/src/view/UserHomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  await Firebase.initializeApp(
    // ignore: prefer_const_constructors
    options: FirebaseOptions(
        apiKey: "AIzaSyBUim5muksPcpnoBh3L2YNDXkrTEt-GoyQ",
        authDomain: "proyectoc6-3a55f.firebaseapp.com",
        projectId: "proyectoc6-3a55f",
        storageBucket: "proyectoc6-3a55f.appspot.com",
        messagingSenderId: "22302206294",
        appId: "1:22302206294:web:9d354738cfc51149844ef7",
        measurementId: "G-QY2HP7VFLR"
        
        ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  bool _result = await ShareApiTokenService.isLoggedIn();
  if (_result) {
    _defaultHome = HomePage();
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Actualizar>(create: (_) => Actualizar()),
        ChangeNotifierProvider.value(
            value: themeProvider),
     
      ],
      // ignore: prefer_const_constructors
      child: MyApp(),
    ),
  );
  // MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Ocultar los botones de navegación y hacer que la barra de notificaciones sea transparente
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,overlays: []);
    // Ocultar los botones de navegación después de 1 o 2 segundos
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    return MaterialApp(
      title: ' APIS APLICACION',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => _defaultHome,
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => HomePage(),
         //CRUDS ADMIN
        '/admin_home': (context) => AdminHomePage(),
        '/user_home': (context) => UserHomePage(),
        '/usuario': (context) => const UsuarioList(),
        '/evento': (context) => const EventoList(),
        '/asistencia': (context) => const AsistenciaAdmin(),
        //VISTA_ALUMNO
        '/evento-alumno': (context) =>  InicioEvento(),
        '/evento-alumno-asistencias': (context) =>  InicioAsistenciaAlumno(),

      },
      // home: CategoriaList(),
    );
  }
}
