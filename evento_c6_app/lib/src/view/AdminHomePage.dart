import 'package:evento_c6_app/src/component/BottomNavBarFlex2.dart';
import 'package:evento_c6_app/src/component/user/drawer/drawers.dart';
import 'package:evento_c6_app/src/service/authService/ApiService.dart';
import 'package:evento_c6_app/src/service/authService/ShareApiTokenService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState();
  @override
  void initState() {
    super.initState();

    // Para ocultar las superposiciones de la interfaz de usuario (por ejemplo, la barra de estado y la barra de navegación)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

    // Si deseas que las superposiciones de la interfaz de usuario sean visibles (por ejemplo, la barra de estado)
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: SystemUiOverlay.values);
  }
 @override
Widget build(BuildContext context) {
  return Scaffold(
    key: _scaffoldKey,
    appBar: AppBar(
      title: Text('Home Page admin'),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            ShareApiTokenService.logout(context);
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
      ],
    ),
    drawer: NavigationDrawerWidget(),
    backgroundColor: Colors.grey[200],
    body: Column(
      children: [
        Expanded(
          child: userProfile(),
        ),
        Container(
          height: 60.0, // Ajusta la altura deseada para el BottomNavBarFlex
          child: BottomNavBarFlex2(
            onPressedSpecialButtonItem: () {},
            onPressedSpecialButtonExel: () {},
            onPressedSpecialButtonPdf: () {},
            buttonColor: Colors.green,
          ),
        ),
      ],
    ),
  );
}


Widget userProfile() {
  return FutureBuilder<List<String>>(
    future: ApiService.getUserProfile(),
    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          final emailList = snapshot.data!;

          return ListView.builder(
            itemCount: emailList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(emailList[index], style: TextStyle(fontSize: 16)),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        }
      }

      return Center(child: CircularProgressIndicator());
    },
  );
}

}
