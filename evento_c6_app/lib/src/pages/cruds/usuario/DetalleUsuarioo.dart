import 'package:animate_do/animate_do.dart';
import 'package:evento_c6_app/src/component/user/drawer/drawers.dart';
import 'package:evento_c6_app/src/controller/UsuarioController.dart';
import 'package:evento_c6_app/src/pages/cruds/usuario/EditUsuario.dart';
import 'package:evento_c6_app/src/pages/cruds/usuario/UsuarioList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:snippet_coder_utils/hex_color.dart';

class DetalleUsuarioo extends StatefulWidget {
  final List list;
  final int index;
  DetalleUsuarioo({required this.index, required this.list});

  @override
  _DetalleUsuariooState createState() => _DetalleUsuariooState();
}

class _DetalleUsuariooState extends State<DetalleUsuarioo> {
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

  final UsuarioController usuarioController = UsuarioController();
  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsuarioList()),
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
  final DetalleUsuarioo widget;

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
             Text("Name",),
              SizedBox(height: 4,),
             Text(
                "${(widget.list[widget.index]['name'] ?? 'Sin nombre').toUpperCase()} ${(widget.list[widget.index]['apellido_p'] ?? 'Sin apellido paterno').toUpperCase()} ${(widget.list[widget.index]['apellido_m'] ?? 'Sin apellido materno').toUpperCase()}",
                style: _style(),
              ),
              SizedBox(height: 16,),
    
              Text("Email", style: _style(),),
              SizedBox(height: 4,),
              Text(widget.list[widget.index]['email']?? 'No tienes email',),
              SizedBox(height: 16,),
    
              Row(
                children: [
                  Text("Codigo U :", style: _style()),
                  SizedBox(width: 4),
                  Text(widget.list[widget.index]['codigo'] ?? 'No tienes codigo',),
                  SizedBox(width: 16),
                  Text("DNI :", style: _style()),
                  SizedBox(width: 4),
                  Text(widget.list[widget.index]['dni']?? 'No tienes dni',),
                ],
              ),
              SizedBox(height: 16,),
              Text("Location", style: _style(),),
              SizedBox(height: 4,),
              Text("Juliaca-puno PERU"),
              SizedBox(height: 16,),
    
              Text("Telefono", style: _style(),),
              SizedBox(height: 4,),
              Text("916882598"),
              SizedBox(height: 16,),
    
              Text("Rol", style: _style(),),
              SizedBox(height: 4,),
              Text(widget.list[widget.index]['role']?? 'No tienes rol',),
              SizedBox(height: 16,),
              Row(
              children: [
                Text("Created_at", style: _style()),
                SizedBox(width: 4),
                Text(DateFormat('dd/MM/yyyy').format(widget.list[widget.index]['created_at']?? 'No tienes fecha crea')),
                SizedBox(width: 16),
                Text("Updated_at", style: _style()),
                SizedBox(width: 4),
                Text(DateFormat('dd/MM/yyyy').format(widget.list[widget.index]['updated_at']?? 'No tienes fecha edit')),
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
  final DetalleUsuarioo widget;

  CustomAppBar({required this.widget});

  @override
  Size get preferredSize => Size(double.infinity, 320);

  @override
  Widget build(BuildContext context) {

    ImageProvider<Object> imageProvider;

    if (widget.list[widget.index]['foto'] != null && widget.list[widget.index]['foto'].isNotEmpty) {
      imageProvider = NetworkImage(widget.list[widget.index]['foto']); // Usar la foto del usuario si está disponible
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
              image: AssetImage('assets/fondologin2.jpg'), // Reemplaza 'tu_ruta_de_imagen' con la ruta de tu imagen de fondo
              fit: BoxFit.cover,
            ),
            
            ),
          child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              // color: HexColor("#0e1b4d").withOpacity(0.9),
               color: Color.fromARGB(255, 5, 27, 65).withOpacity(0.9),
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
                          Navigator.pushNamed(context, '/usuario');
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
                       "${(widget.list[widget.index]['name'] ?? 'Sin nombre')}",
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
                      builder: (BuildContext context) => EditUsuario(
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