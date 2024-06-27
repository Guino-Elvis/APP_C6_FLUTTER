import 'package:cached_network_image/cached_network_image.dart';
import 'package:evento_c6_app/src/config/theme.dart';
import 'package:evento_c6_app/src/controller/AsistenciaController.dart';
import 'package:evento_c6_app/src/pages/inicio_asistencia_detalle.dart';
import 'package:evento_c6_app/src/pages/inicio_evento.dart';
import 'package:evento_c6_app/src/pages/widgets/evento_vistas/evento_asistencia_detalle_Widget.dart';
import 'package:evento_c6_app/src/pages/widgets/evento_vistas/evento_detalle_Widget.dart';
import 'package:evento_c6_app/src/service/authService/ShareApiTokenService.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class InicioAsistenciaAlumno extends StatefulWidget {

  @override
  State<InicioAsistenciaAlumno> createState() => _InicioAsistenciaAlumnoState();
}

class _InicioAsistenciaAlumnoState extends State<InicioAsistenciaAlumno> {
 
  late ThemeProvider themeProvider;
  late List<Color> themeColors;

 

  //end traendo ususario
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Accede a los valores de Provider en didChangeDependencies
    themeProvider = Provider.of<ThemeProvider>(context);
    themeColors = themeProvider.getThemeColors();
  }

 

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
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
                height: 370,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: themeProvider.isDiurno
                        ? AssetImage('assets/sideral2.jpg')
                        : AssetImage('assets/fondonegro1.jfif'),
                    // image: AssetImage('assets/lib2.jfif'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: themeProvider.isDiurno
                            ? HexColor("#0e1b4d").withOpacity(0.8)
                            : Colors.black.withOpacity(0.5),
                        // color: HexColor("#0e1b4d").withOpacity(0.8),
                        //  color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(23),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                Navigator.of(context).pushNamed('/evento-alumno');
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: themeProvider.isDiurno
                                      ? HexColor('#F82249')
                                      : Colors.white,
                                  size: 30,
                                ),
                              ),
                              Spacer(),
                              PopupMenuButton<int>(
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/favoritos");
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.bookmark,
                                            color: themeProvider.isDiurno
                                                ? HexColor('#F82249')
                                                : Colors.white,
                                          ),
                                          const SizedBox(width: 8),
                                          Text('Mis Asistencias'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Puedes agregar más elementos del menú aquí si es necesario
                                ],
                                child: Icon(
                                  Icons.more_vert,
                                  size: 25,
                                  color: themeProvider.isDiurno
                                      ? HexColor('#F82249')
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Text(
                                'Asistencias',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      
                      ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(40)),
                        child: Container(
                          padding: EdgeInsets.only(top: 15),
                          color: themeProvider.isDiurno
                              ? Colors.white
                              : Colors.white10,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              _nota(),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(230, 70),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2,
                              0.004) // Establecer un valor para la perspectiva
                          ..rotateY(0.3), // Girar en el eje Y
                        alignment: FractionalOffset.center,
                        child: Container(
                          width: 130,
                          height: 180,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                          child: Container(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                
                  Container(
                    color:
                        themeProvider.isDiurno ? Colors.white : Colors.white10,
                    //formulario
                    child: _crudAsistencia(),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _textCenter({required String nombre}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            nombre,
            style: TextStyle(
              color:
                  themeProvider.isDiurno ? HexColor("#0e1b4d") : Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              wordSpacing: 2,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            width: 70.0,
            color: themeProvider.isDiurno ? HexColor('#F82249') : Colors.white,
            height: 3.0,
          ),
        ],
      ),
    );
  }

  Widget _crudAsistencia() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _textCenter(
            nombre: 'asistencias',
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 15),
              child: InicioAsistenciaAlumnoDetalle( )),
        ],
      ),
    );
  }

  Widget _nota() {
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.isDiurno ? HexColor("#F82249") : themeColors[0],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 85,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¡Recuerda!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 300,
                child: Text(
                  'Recuerda que las asistencias son personales',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
