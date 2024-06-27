import 'package:animate_do/animate_do.dart';
import 'package:evento_c6_app/src/component/user/drawer/drawers.dart';
import 'package:evento_c6_app/src/config/theme.dart';
import 'package:evento_c6_app/src/pages/widgets/evento_vistas/evento_Widget.dart';
import 'package:evento_c6_app/src/pages/widgets/evento_vistas/evento_Widget2.dart';
import 'package:evento_c6_app/src/pages/widgets/navBarInicio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class InicioEvento extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          if (!themeProvider
              .isDiurno) // Condición para mostrar la imagen y el color encima
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fondonegro1.jfif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (!themeProvider
              .isDiurno) // Condición para mostrar el color encima de la imagen
            Positioned.fill(
              child: Container(
                color:
                    Colors.black.withOpacity(0.5), // Color encima de la imagen
              ),
            ),
          ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: themeProvider.isDiurno
                        ? AssetImage('assets/libdia.jfif')
                        : AssetImage('assets/libnoche2.jfif'),
                    // image: AssetImage('assets/lib2.jfif'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 280,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: themeProvider.isDiurno
                            ? HexColor("#0e1b4d").withOpacity(0.8)
                            : Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: 25, left: 25, bottom: 25),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                                child: Icon(
                                  Icons.sort,
                                  color: themeProvider.isDiurno
                                      ? Colors.white
                                      : themeColors[7],
                                  // color: HexColor("#0e1b4d"),
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                padding: EdgeInsets.symmetric(horizontal: 14),
                                height: 35,
                                decoration: BoxDecoration(
                                  color: themeProvider.isDiurno
                                      ? Colors.white
                                      : themeColors[9],
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.search,
                                        color: themeProvider.isDiurno
                                            ? Colors.black
                                            : Colors.white),
                                    SizedBox(
                                        width:
                                            5), // Espacio entre el icono y el campo de texto
                                    Container(
                                      width: 220,
                                      padding: EdgeInsets.only(top: 14),
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: themeProvider.isDiurno
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Busca lo que quieras...",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            
                            ],
                          ),
                        ),
                        NavBarInicio(),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: themeProvider.isDiurno ? HexColor("#F82249"): themeColors[0],
                height: 88,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: FadeInDown(
                  duration: Duration(milliseconds: 500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '¡Explora Los Eventos Privados!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              'Descubre nuestros exclusivos eventos privados y vive momentos únicos e inolvidables.',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 15,),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/librofisico");
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 22,right: 22,top: 8,bottom: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Explorar",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: themeProvider.isDiurno ? Colors.white : themeColors[8],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    EventoWidget(),

                    //seccion2 categoria
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: Text(
                        "Evento Importante",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDiurno
                              ? HexColor("#0e1b4d")
                              : themeColors[7],
                        ),
                      ),
                    ),
                    EventoWidget2(),
                   
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: NavigationDrawerWidget(),
    );
  }
}