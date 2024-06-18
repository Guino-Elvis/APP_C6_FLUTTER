import 'package:animate_do/animate_do.dart';
import 'package:evento_c6_app/src/component/user/drawer/drawers.dart';
import 'package:evento_c6_app/src/controller/EventoController.dart';
import 'package:evento_c6_app/src/pages/cruds/evento/EditarEvento.dart';
import 'package:evento_c6_app/src/pages/cruds/evento/EventoList.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:snippet_coder_utils/hex_color.dart';

class DetalleEvento extends StatefulWidget {
  final List list;
  final int index;
  DetalleEvento({required this.index, required this.list});

  @override
  _DetalleEventoState createState() => _DetalleEventoState();
}

class _DetalleEventoState extends State<DetalleEvento> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
   
  }

  @override
  void dispose() {
    super.dispose();

    // Asegúrate de restaurar el comportamiento predeterminado al salir de la pantalla
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: SystemUiOverlay.values);
  }

  final EventoController eventoController = EventoController();
  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventoList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(widget: widget),
      drawer: NavigationDrawerWidget(),
      body: ProfilePage(widget: widget),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final DetalleEvento widget;

  ProfilePage({required this.widget});

  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold,color: HexColor("#060c22"));
  }

  @override
  Widget build(BuildContext context) {

    return BounceInRight(
     
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Text("Creador",),
              SizedBox(height: 4,),
             Text(
                "${(widget.list[widget.index]['userId'] ?? 'Sin userId').toString().toUpperCase()} ",
                style: _style(),
              ),
              SizedBox(height: 16,),
    
              Text("Nombre", style: _style(),),
              SizedBox(height: 4,),
              Text(widget.list[widget.index]['nombre']?? 'No tienes nombre',),
              SizedBox(height: 16,),

              Row(
              children: [
                Text(
                  "Fecha de inicio",
                  style: _style(),
                ),
                SizedBox(height: 4),
                Text(widget.list[widget.index]['fecha_inicio']?? 'fecha_inicio',),
                SizedBox(height: 16),
                Text(
                  "Fecha de cierre",
                  style: _style(),
                ),
                SizedBox(height: 4),
                Text(widget.list[widget.index]['fecha_fin']?? 'fecha_fin',),
              ],
            ),
              Divider(color: Colors.grey,)
          ],
        ),
      ),
    );
  }
}



class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final DetalleEvento widget;

  CustomAppBar({required this.widget});

  @override
  Size get preferredSize => Size(double.infinity, 320);

  @override
  Widget build(BuildContext context) {

    ImageProvider<Object> imageProvider;

    if (widget.list[widget.index]['foto'] != null && widget.list[widget.index]['foto'].isNotEmpty) {
      imageProvider = NetworkImage(widget.list[widget.index]['foto']); // Usar la foto del Evento si está disponible
    } else {
      imageProvider = AssetImage('assets/nofoto.jpg'); // Usar una imagen de respaldo si no hay foto
    }

    return SlideInUp(
      child: ClipPath(
        clipper: MyClipper(),
        child: Container(
          padding: EdgeInsets.only(top: 0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/sideral2.jpg'), 
              fit: BoxFit.cover,
            ),
            
            ),
          child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              // color: HexColor("#0e1b4d").withOpacity(0.9),
               color: Color.fromARGB(50, 11, 44, 11).withOpacity(0.9),
            ),
          ),  
          
          Column(
          
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // Abre el Drawer
                    },
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      // Espacio de 2 píxeles entre los iconos
                      IconButton(
                        icon: Icon(
                          Icons.subdirectory_arrow_right_sharp,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/evento');
                        },
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start, // Alinea los elementos en la parte superior
                children: <Widget>[
                  Column(
                    children: <Widget>[
                     Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 4), // Agregar borde blanco
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageProvider, // Asignar la variable imageProvider
                          ),
                        ),
                        child: FutureBuilder(
                          future: precacheImage(imageProvider, context),
                          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // Muestra un indicador de carga mientras se carga la imagen
                              return CircularProgressIndicator();
                            } else {
                              // La imagen se ha cargado, puedes mostrarla
                              return Container(); // Opcional: Puedes quitar este contenedor si no necesitas mostrar nada adicional
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                       "${(widget.list[widget.index]['nombre'] ?? 'Sin nombre')}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Schedule",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "8",
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Events",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "12",
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Routines",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "4",
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      )
                    ],
                  ),
                  
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    print("//TODO: button clicked");
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => EditEvento(
                        list: widget.list,
                        index: widget.index,
                      ),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 16, 0),
                    
                    child: Transform.rotate(
                      angle: (math.pi * 0.05),
                      child: Container(
                        width: 110,
                        height: 32,
                        child: Center(
                          child: Text("Edit Profile",style: TextStyle(color: HexColor("#0e1b4d")),),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 20)
                            ]),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
           ],
          ),
        ),
        
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height - 70);
    p.lineTo(size.width, size.height);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}