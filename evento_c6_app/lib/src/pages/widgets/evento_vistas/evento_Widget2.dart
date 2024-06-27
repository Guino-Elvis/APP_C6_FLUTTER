import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:evento_c6_app/src/config/theme.dart';
import 'package:evento_c6_app/src/controller/EventoController.dart';
import 'package:evento_c6_app/src/pages/widgets/evento_vistas/evento_detalle_Widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class EventoWidget2 extends StatefulWidget {
  const EventoWidget2({super.key});

  @override
  State<EventoWidget2> createState() => _EventoWidget2State();
}

class _EventoWidget2State extends State<EventoWidget2> {
  List<dynamic> item = []; // Lista para almacenar los eventos
  EventoController eventoController = EventoController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }

  Future<void> _getData() async {
    try {
        final eventosData = await eventoController.getDataEvento(tipo: 'publico',seccion: '2');
      setState(() {
        item = eventosData;
      });
    } catch (error) {
     
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return BounceInUp(
      duration: Duration(milliseconds: 900),
      child: GridView.count(
        childAspectRatio: 0.58,
        crossAxisCount: 2,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: item.map<Widget>((items) {
          return Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              // color: Colors.white,
              color: themeProvider.isDiurno ? Colors.white : themeColors[9],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: themeProvider.isDiurno
                            ? HexColor("#F82249")
                            : themeColors[0],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        "Online",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: themeProvider.isDiurno
                          ? HexColor("#F82249")
                          : themeColors[7],
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventoDetalleWidget(evento: items),
                    ),
                  );
                },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: CachedNetworkImage(
                      imageUrl: items.containsKey('foto')
                          ? items['foto'].toString()
                          : 'assets/nofoto.jpg',
                      placeholder: (context, url) => Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/nofoto.jpg',
                        width: 220,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                      fit: BoxFit.cover,
                      width: 180,
                      height: 200,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    truncateText(
                        items['nombre']?.toString() ?? 'no se encontro el nombre',
                        35),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDiurno
                          ? HexColor("#0e1b4d")
                          : themeColors[7],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Evento :',style: TextStyle(
                          color: themeProvider.isDiurno
                          ? HexColor("#0e1b4d")
                          : themeColors[7],
                        ),),
                        SizedBox(width: 5,),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: themeProvider.isDiurno
                                ? HexColor("#F82249")
                                : themeColors[0],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: themeProvider.isDiurno
                                    ? Colors.black.withOpacity(0.5)
                                    : themeColors[0],
                                // color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Text(
                            "Publico",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
