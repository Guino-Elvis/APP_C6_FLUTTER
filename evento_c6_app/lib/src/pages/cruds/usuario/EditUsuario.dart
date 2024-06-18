import 'package:animate_do/animate_do.dart';
import 'package:evento_c6_app/src/controller/UsuarioController.dart';
import 'package:evento_c6_app/src/pages/cruds/usuario/UsuarioList.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';


class EditUsuario extends StatefulWidget {
  final List list;
  final int index;

  const EditUsuario({required this.list, required this.index});

  @override
  State<EditUsuario> createState() => _EditUsuarioState();
}

class _EditUsuarioState extends State<EditUsuario> {
  UsuarioController usuarioController = UsuarioController();

  late TextEditingController controllerid;
  late TextEditingController controllerapellido_p;
  late TextEditingController controllerapellido_m;
  late TextEditingController controllerdni;
  late TextEditingController controllercodigo;
  late TextEditingController controllername;
  late TextEditingController controllerrole;
  late TextEditingController controlleremail;
  late TextEditingController controllerpassword;
  late TextEditingController controllerfoto;
  File? selectedImage;
  String usuarioImageURL = "";

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
  void initState() {
    super.initState();
    controllerid =
        TextEditingController(text: widget.list[widget.index]['id'].toString());
    controllername = TextEditingController(
        text: widget.list[widget.index]['name']?.toString() ??
            'Nombre no especificado');
    controllerapellido_p = TextEditingController(
        text: widget.list[widget.index]['apellido_p']?.toString() ??
            'apellido_p no especificado');
    controllerapellido_m = TextEditingController(
        text: widget.list[widget.index]['apellido_m']?.toString() ??
            'apellido_m no especificado');
    controllerdni = TextEditingController(
        text: widget.list[widget.index]['dni']?.toString() ??
            'dni no especificado');
    controllercodigo = TextEditingController(
        text: widget.list[widget.index]['codigo']?.toString() ??
            'codigo no especificado');
    selectedRole = widget.list[widget.index]['role']?.toString() ?? "";
    // controllerrole = TextEditingController(
    //     text: widget.list[widget.index]['role']?.toString()?? 'rol no especificado');
    controlleremail = TextEditingController(
        text: widget.list[widget.index]['email'].toString());
    controllerpassword = TextEditingController(
        text: widget.list[widget.index]['password'].toString());

    usuarioImageURL = widget.list[widget.index]['foto'] != null
        ? widget.list[widget.index]['foto'].toString()
        : 'assets/nofoto.jpg';

    selectedImage = File(usuarioImageURL);
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    } else {
      // El usuario no seleccionó una nueva imagen.
    }
  }

  Future<void> _updateImageInFirebase() async {
    String newImageUrl =
        widget.list[widget.index]['foto'] ?? ""; // Default to an empty string
    if (selectedImage != null) {
      final firebaseStorageReference =
          FirebaseStorage.instance.ref().child('usuario/${DateTime.now()}.png');

      try {
        await firebaseStorageReference.putFile(selectedImage!);
        final downloadUrl = await firebaseStorageReference.getDownloadURL();

        if (downloadUrl != null) {
          newImageUrl =
              downloadUrl; // Si se selecciona una nueva imagen, se actualiza la URL
        } else {
          // Handle the case where downloadUrl is null (image upload failed)
          // You might want to display an error message or use a default image URL.
        }
      } catch (e) {
        // Maneja el error, por ejemplo, muestra un mensaje al usuario
        print("Error al cargar la imagen: $e");
      }
    }

    // Actualiza la categoría, incluyendo la URL de la imagen (ya sea la existente o la nueva)
    usuarioController.editarUsuario(
      controllerid.text.trim(),
      controllername.text.trim(),
      controllerapellido_p.text.trim(),
      controllerapellido_m.text.trim(),
      controllerdni.text.trim(),
      controllercodigo.text.trim(),
      // controllerrole.text.trim(),
      selectedRole ?? "", // Rol seleccionado
      controlleremail.text.trim(),
      controllerpassword.text.trim(),

      newImageUrl,
    );

    _navigateList(context);
  }

  String?
      selectedRole; // Debes definir esta variable para almacenar el rol seleccionado
  List<String> roles = ['admin', 'user', 'docente', 'librero'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Usuario"),
      ),
      body: SlideInUp(
        child: Form(
          child: BounceInRight(
            child: ListView(
              padding: const EdgeInsets.all(12.0),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Visibility(
                      visible: false,
                      child: ListTile(
                        leading: Icon(Icons.title, color: Colors.black),
                        title: TextFormField(
                          controller: controllerid,
                          decoration: InputDecoration(
                            hintText: "id",
                            labelText: "id",
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.all(
                    //       8.0), // Agrega márgenes alrededor de la imagen
                    //   child: CachedNetworkImage(
                    //     imageUrl: usuarioImageURL.isNotEmpty
                    //         ? usuarioImageURL
                    //         : 'assets/nofoto.jpg',
                    //     placeholder: (context, url) =>
                    //         CircularProgressIndicator(), // Puedes personalizar el indicador de carga
                    //     errorWidget: (context, url, error) =>
                    //         Image.asset('assets/nofoto.jpg'),
                    //     width: 80.0,
                    //     height: 80.0,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    Card(
                        elevation: 4, // Define la elevación de la sombra negra
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Define la forma del Card
                        ),
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0), // Hace que la imagen esté recortada con bordes redondeados
                            child: CachedNetworkImage(
                              imageUrl: usuarioImageURL.isNotEmpty
                                  ? usuarioImageURL
                                  : 'assets/nofoto.jpg',
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/nofoto.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: TextFormField(
                        controller: controllername,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "nombre",
                          labelText: "nombre del usuario",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: TextFormField(
                        controller: controllerapellido_p,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Apellido paterno",
                          labelText: "Apellido paterno del usuario",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: TextFormField(
                        controller: controllerapellido_m,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Apellido materno",
                          labelText: "Apellido materno del usuario",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: TextFormField(
                        controller: controllerdni,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "DNI",
                          labelText: "Dni del usuario",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: TextFormField(
                        controller: controllercodigo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Codigo",
                          labelText: "codigo del usuario",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:16.0,right: 20.0), // Margen izquierdo para alinear visualmente con los otros campos
                      child: DropdownButtonFormField<String>(
                        value: selectedRole,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedRole = newValue;
                          });
                        },
                        items: roles.map((String role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Rol',
                          hintText: 'Selecciona un rol',
                          icon: Icon(Icons.category_outlined),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: TextFormField(
                        controller: controlleremail,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          labelText: "Correo electronico de usuario",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: TextFormField(
                        controller: controllerpassword,
                        obscureText: true, // Esto ocultará la contraseña
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Contraseña",
                          labelText: "Contraseña de usuario",
                        ),
                      ),
                    ),
                    Divider(
                      height: 1.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Container(child: Text("Cambiar Foto")),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            _updateImageInFirebase();
                          },
                          child: Container(child: Text("Editar")),
                        ),
                        SizedBox(width: 16), // Agrega un espacio entre los botones
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/usuario');
                          },
                          child: Text("Cancelar"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
