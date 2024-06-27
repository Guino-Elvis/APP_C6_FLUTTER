import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:evento_c6_app/src/controller/EventoController.dart';
import 'package:evento_c6_app/src/pages/widgets/evento_vistas/evento_detalle_Widget.dart';
import 'package:flutter/material.dart';


class EventoWidget extends StatefulWidget {
  const EventoWidget({Key? key}) : super(key: key);

  @override
  _EventoWidgetState createState() => _EventoWidgetState();
}

class _EventoWidgetState extends State<EventoWidget> {
  List<dynamic> item = []; 
  EventoController eventoController = EventoController();

  @override
  void initState() {
    super.initState();
    _getData();
    // _getData();
  }

  Future<void> _getData() async {
    try {
     final eventosData = await eventoController.getDataEvento(tipo: 'publico',seccion: '1');

      // final eventosData = await eventoController.getDataEvento(); // Utiliza una función específica para obtener eventos físicos
      setState(() {
        item = eventosData;
      });
    } catch (error) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideInRight(
      duration: Duration(milliseconds: 900),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: item.map<Widget>((items) {
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(5, 5),
                  )
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventoDetalleWidget(evento: items),
                    ),
                  );
                },

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
                    height: 200,
                    width: 138,
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                  height: 200,
                  width: 138,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
