import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:evento_c6_app/src/component/Actualizar.dart';
import 'package:evento_c6_app/src/component/BottomNavBarFlex2.dart';
import 'package:evento_c6_app/src/component/user/drawer/drawers.dart';
import 'package:evento_c6_app/src/config/ConfigApi.dart';
import 'package:evento_c6_app/src/controller/EventoController.dart';
import 'package:evento_c6_app/src/controller/UsuarioController.dart';
import 'package:evento_c6_app/src/pages/cruds/evento/CreateEvento.dart';
import 'package:evento_c6_app/src/pages/cruds/evento/DetalleEvento.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class EventoList extends StatefulWidget {
  const EventoList({Key? key}) : super(key: key);

  @override
  State<EventoList> createState() => _EventoListState();
}

class _EventoListState extends State<EventoList> {
  late List<dynamic> data = [];
  late List<dynamic> dataUser = [];
  EventoController eventoController = EventoController();
  UsuarioController usuarioController = UsuarioController();

  late File excelFile;

 Future<void> _getDataUser() async {
    try {
      final categoriesData = await usuarioController.getData();
      setState(() {
        dataUser = categoriesData;
      });
      print('Data fetched successfully. Number of items: ${dataUser.length}');
    } catch (error) {
      // Manejar errores, por ejemplo, mostrando un mensaje al usuario
    }
  }

  Future<List<dynamic>> getData() async {
    final response =
        await http.get(Uri.parse(ConfigApi.buildUrl('/evento')));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Itera sobre los elementos y convierte las fechas de cadenas a objetos DateTime
      for (var item in responseData) {
        if (item['created_at'] is String) {
          item['created_at'] = DateTime.parse(item['created_at']);
        }
        if (item['updated_at'] is String) {
          item['updated_at'] = DateTime.parse(item['updated_at']);
        }
        // Repite el proceso para otras fechas si es necesario.
      }

      return responseData;
    } else {
      throw Exception('Failed to load data');
    }
  }

   void actualizarVista(List<dynamic> newData) {
  getData().then((result) {
    Provider.of<Actualizar>(context, listen: false).setData(result);
    setState(() => data = result);
  });
}

  Future<void> _navigateCrearEvento(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateEvento()));
    if (result != null) {
      actualizarVista(await getData());
    }
  }

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData().then((result) {
      setState(() {
        data = result;
      });
    });
     _getDataUser();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: isSearching
              ? TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar Eventos',
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {},
                    ),
                  ),
                  style: TextStyle(color: HexColor("#060c22")),
                )
              : Text(
                  'Lista de Eventos',
                  style: TextStyle(
                      color: HexColor("#060c22"), fontWeight: FontWeight.bold),
                ),
          iconTheme: IconThemeData(color: HexColor("#060c22")),
          actions: <Widget>[
            IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search,
                  color: HexColor("#060c22")),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    searchController
                        .clear(); // Limpia el campo de búsqueda cuando se cancela la búsqueda.
                  }
                });
              },
            ),
          ],
        ),
        drawer: NavigationDrawerWidget(),
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/fondo45.jpg'),
                      fit: BoxFit.cover),
                ),
                child: data.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ItemList(
                        list: data,
                        actualizarVista: actualizarVista,
                        scaffoldContext: context),
              ),
            ),
            Container(
              height: 60.0, // Ajusta la altura deseada para el BottomNavBarFlex
              child: BottomNavBarFlex2(
                onPressedSpecialButtonItem: () {
                  _navigateCrearEvento(context);
                },
                onPressedSpecialButtonExel: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirmar descarga"),
                        content:
                            Text("¿Seguro que quieres descargar este archivo?"),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Cancelar"),
                            onPressed: () {
                              Navigator.of(context).pop(); // Cierra el modal
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                onPressedSpecialButtonPdf: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirmar descarga"),
                        content: Text(
                            "¿Seguro que quieres descargar este archivo PDF?"),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Cancelar"),
                            onPressed: () {
                              Navigator.of(context).pop(); // Cierra el modal
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                buttonColor: HexColor("#231D10"),
              ),
            ),
          ],
        ),
      );
}

class ItemList extends StatelessWidget {
  final Function(List<dynamic>) actualizarVista;
  final List<dynamic> list;
 final EventoController eventoController = EventoController();
  final BuildContext scaffoldContext;

  ItemList(
      {Key? key,
      required this.list,
      required this.actualizarVista,
      required this.scaffoldContext})
      : super(key: key);

  String truncateString(String text, int maxLength) =>
      text.length <= maxLength ? text : text.substring(0, maxLength) + '...';

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];

          final userId = truncateString(
              item['userId']?.toString() ?? 'usuario no especificado', 15);

          final nombre = truncateString(
              item['nombre']?.toString() ?? 'nombre no especificado', 15);
         
          final created_at =
              item['created_at'] != null ? item['created_at'] : DateTime.now();
          final fechaFormateada = DateFormat('yyyy-MM-dd').format(created_at);
          final foto = item.containsKey('foto') && item['foto'] != null
              ? item['foto'].toString()
              : 'assets/nofoto.jpg';

          return Container(
            child: SlideInUp(
              child: GestureDetector(
                child: Stack(
                  children: [
                    Container(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: HexColor("#0e1b4d").withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: SlideInUp(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Stack(
                                    children: [
                                      if (foto.isEmpty)
                                        CircularProgressIndicator(),
                                      if (foto.isNotEmpty)
                                        CircleAvatar(
                                          backgroundImage:
                                              CachedNetworkImageProvider(foto),
                                        )
                                      else
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.blue, width: 2.0),
                                          ),
                                          child: CircleAvatar(
                                            backgroundImage:
                                                AssetImage('assets/nofoto.jpg'),
                                          ),
                                        ),
                                    ],
                                  ),
                                  title: Text(
                                    nombre,
                                    style: TextStyle(
                                      color: HexColor("#060c22"),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Fecha: $fechaFormateada'),
                                      Text('Creador: $userId'),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.visibility,
                                            color: HexColor("#0e1b4d")),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  DetalleEvento(
                                                      list: list, index: index),
                                            ),
                                          );
                                        },
                                         ),
                                      IconButton(
                                        icon: Icon(
                                            Icons.delete_outline_outlined,
                                            size: 25,
                                            color: Colors.red),
                                        onPressed: () {
                                          showDialog(
                                            context: scaffoldContext,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text("Confirmación"),
                                                content: Text(
                                                    "¿Seguro que quieres eliminar este item?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: Text("Cancelar"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      final id =
                                                          item['id'].toString();
                                                      final fotoURL =
                                                          item['foto']
                                                              .toString();
                                                      eventoController
                                                          .removerEvento(
                                                              id, fotoURL)
                                                          .then(
                                                              (response) async {
                                                        if (response
                                                                .statusCode ==
                                                            200) {
                                                          // Eliminación exitosa, actualizar el estado de la lista
                                                         
                                                          ScaffoldMessenger.of(
                                                                  scaffoldContext)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    "Item eliminado con éxito.")),
                                                          );
                                                            Navigator.of(scaffoldContext).pushNamed('/evento');  // Navega a la otra ruta
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  scaffoldContext)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    "Error al eliminar el item.")),
                                                          );
                                                        }
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Eliminar"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: HexColor("#F82249").withOpacity(0.8),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
