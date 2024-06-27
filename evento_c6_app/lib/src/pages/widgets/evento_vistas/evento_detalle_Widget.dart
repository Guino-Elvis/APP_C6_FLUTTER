import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:evento_c6_app/src/config/theme.dart';
import 'package:evento_c6_app/src/pages/widgets/evento_vistas/evento_Widget2.dart';
import 'package:evento_c6_app/src/pages/widgets/navbar/evento_nav.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';


class EventoDetalleWidget extends StatefulWidget {
  final dynamic evento;
  // const EventoDetalleWidget({super.key});
  const EventoDetalleWidget({Key? key, required this.evento}) : super(key: key);
  @override
  State<EventoDetalleWidget> createState() => _EventoDetalleWidgetState();
}

class _EventoDetalleWidgetState extends State<EventoDetalleWidget> {
  @override
  Widget build(BuildContext context) {
    final dynamic evento = widget.evento;
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Stack(
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
              color: Colors.black.withOpacity(0.5), // Color encima de la imagen
            ),
          ),
        Scaffold(
          backgroundColor:
              themeProvider.isDiurno ? HexColor("#0e1b4d") : Colors.transparent,
          body: ListView(
            children: [
              EventoNav(),
              Padding(
                padding: EdgeInsets.all(2),
                child: Container(
                  margin: EdgeInsets.only(left: 80, right: 80, top: 20),
                  // padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        spreadRadius: 0,
                        // blurRadius: 10,
                        offset: Offset(5, 6),
                      )
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: evento.containsKey('foto')
                        ? evento['foto'].toString()
                        : 'assets/nofoto.jpg',
                    placeholder: (context, url) => Container(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/nofoto.jpg',
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Arc(
                edge: Edge.TOP,
                arcType: ArcType.CONVEY,
                height: 30,
                child: Container(
                  width: double.infinity,
                  color: themeProvider.isDiurno ? Colors.white : Colors.black45,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 50,
                            bottom: 20,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 350,
                                child: Text(
                                  evento['nombre']?.toString() ??
                                      'no se encontró la categoria',
                                  // evento.containsKey('titulo') ? evento['titulo'] : 'evento sin título',
                                  style: TextStyle(
                                      color: themeProvider.isDiurno
                                          ? HexColor("#0e1b4d")
                                          : Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBar.builder(
                                initialRating: 4,
                                maxRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 20,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 5),
                                itemBuilder: (context, _) => Icon(
                                  Icons.favorite,
                                  color: themeProvider.isDiurno
                                      ? HexColor("#F82249")
                                      : Colors.white,
                                  size: 20,
                                ),
                                onRatingUpdate: (index) {},
                              ),
                              Row(
                                children: [
                                  if (evento['tipo']?.toString() == 'privado')
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: themeProvider.isDiurno
                                            ? HexColor("#F82249")
                                            : themeColors[0],
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 10,
                                            offset: Offset(0, 3),
                                          )
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.download,
                                        color: Colors.white,
                                      ),
                                    ),
                                  if (evento['tipo']?.toString() == 'publico')
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => Reservaevento(
                                        //       evento: evento,
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                          color: themeProvider.isDiurno
                                              ? HexColor("#F82249")
                                              : themeColors[0],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: Offset(0, 3),
                                            )
                                          ],
                                        ),
                                        child: Text('Asistir',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: ExpandableText(
                            "Este código creará un texto expandible que mostrará  al principio y, cuando el usuario haga clic en él, se expandirá para mostrar el texto completo. También mostrará  para que el usuario pueda volver a contraer el texto si lo desea. Puedes ajustar el número de líneas maxLines según tus preferencias. ",
                            expandText: 'Leer más',
                            linkColor: themeProvider.isDiurno
                                ? HexColor("#F82249")
                                : Colors.white,
                            //linkColor: HexColor('#F82249'),
                            collapseText: 'Leer menos',
                            maxLines:
                                2, // Número de líneas a mostrar antes de mostrar "Leer más".
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Publico:',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: themeProvider.isDiurno
                                          ? HexColor("#0e1b4d")
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 6,
                                            bottom: 6),
                                        alignment: Alignment.center,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: themeProvider.isDiurno
                                                ? HexColor("#F82249")
                                                : themeColors[0],
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                color: themeProvider.isDiurno
                                                    ? Colors.grey
                                                        .withOpacity(0.5)
                                                    : Colors.transparent,
                                                spreadRadius: 2,
                                                blurRadius: 8,
                                              )
                                            ]),
                                        child: Text(
                                          evento['tipo']
                                                      ?.toString()
                                                      .isNotEmpty ??
                                                  false
                                              ? evento['tipo'].toString() ==
                                                      'publico'
                                                  ? 'Sí'
                                                  : 'No'
                                              : 'No se encontró el formato',
                                          // evento['formato']?.toString() ??'no se encontro el formato',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20), // Espacio entre los dos Row
                              Row(
                                children: [
                                  Text(
                                    'Category:',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: themeProvider.isDiurno
                                          ? HexColor("#0e1b4d")
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 6,
                                            bottom: 6),
                                        alignment: Alignment.center,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: themeProvider.isDiurno
                                                ? HexColor("#F82249")
                                                : themeColors[0],
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                color: themeProvider.isDiurno
                                                    ? Colors.grey
                                                        .withOpacity(0.5)
                                                    : Colors.transparent,
                                                spreadRadius: 2,
                                                blurRadius: 8,
                                              )
                                            ]),
                                        child: Text(
                                          // evento['categorialib']['titulo']
                                          //         ?.toString() ??
                                          //     'no se encontró la categoria',
                                          evento.containsKey('nombre') ? evento['nombre'] : 'evento sin título',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (evento['formato']?.toString() == 'fisico')
                          Container(
                            height: 60,
                            color: themeProvider.isDiurno ? Colors.white : Colors.transparent,
                          )
                      ],
                    ),
                  ),
                ),
              ),
              if (evento['formato']?.toString() == 'online')
                Column(
                  children: [
                    Container(
                      color:
                          themeProvider.isDiurno ? Colors.white : Colors.black,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: Text(
                              "Best Stilling",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: themeProvider.isDiurno
                                    ? HexColor("#0e1b4d")
                                    : Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            child: EventoWidget2(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
