import 'package:animate_do/animate_do.dart';
import 'package:evento_c6_app/src/controller/EventoController.dart';
import 'package:evento_c6_app/src/pages/cruds/evento/EventoList.dart';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateEvento extends StatefulWidget {
  @override
  State<CreateEvento> createState() => _CreateEventoState();
}

class _CreateEventoState extends State<CreateEvento> {
  EventoController eventoController = EventoController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController seccionController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController fecha_inicioController = TextEditingController();
  final TextEditingController fecha_finController = TextEditingController();

  File? selectedImage;
  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventoList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    } else {
      // El Evento no seleccionó una imagen, puedes mostrar un mensaje de error.
    }
  }

  Future<String?> _uploadImage() async {
    if (selectedImage != null) {
      final firebaseStorageReference =
          FirebaseStorage.instance.ref().child('evento/${DateTime.now()}.png');
      await firebaseStorageReference.putFile(selectedImage!);
      final downloadUrl = await firebaseStorageReference.getDownloadURL();
      return downloadUrl;
    } else {
      return null; // Devuelve null en caso de que la imagen no se cargue.
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Aquí puedes procesar la imagen seleccionada.
      // Por ejemplo, puedes mostrarla en la interfaz de Evento.
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    } else {
      // El Evento canceló la selección.
    }
  }

// Add this function to validate fields
  bool _validateFields() {
    if (userIdController.text.isEmpty ||
        nombreController.text.isEmpty ||
        seccionController.text.isEmpty ||
        selectedTipo == null ||
        selectedTipo!.isEmpty ||
        fecha_inicioController.text.isEmpty ||
        fecha_finController.text.isEmpty) {
      // Show a modal indicating that all fields must be filled.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Campos Incompletos"),
            content: Text(
                "Por favor, complete todos los campos antes de crear el libro."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  String?
      selectedTipo; // Debes definir esta variable para almacenar el rol seleccionado
  List<String> tipos = [
    'publico',
    'privado',
  ]; // Definir la lista de roles
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Evento'),
      ),
      // drawer: MyDrawer(accountName: "Evento"),

      body: BounceInRight(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SlideInUp(
            child: ListView(
              children: [
                TextFormField(
                  controller: userIdController,
                  decoration: InputDecoration(
                    labelText: 'User',
                    hintText: 'Creador de Evento',
                    icon: Icon(Icons.person_add),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    hintText: 'Nombre del Evento',
                    icon: Icon(Icons.person_add),
                  ),
                ),
                 SizedBox(height: 16.0),
                TextFormField(
                  controller: seccionController,
                  decoration: InputDecoration(
                    labelText: 'Seccion',
                    hintText: 'Seccion del Evento',
                    icon: Icon(Icons.person_add),
                  ),
                ),
                SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                  value: selectedTipo,
                  onChanged: (String? newValue) {
                    // Aquí puedes manejar el cambio de valor seleccionado
                    setState(() {
                      selectedTipo = newValue;
                    });
                  },
                  items: tipos.map((String tipo) {
                    return DropdownMenuItem<String>(
                      value: tipo,
                      child: Text(tipo),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Tipo',
                    hintText: 'Selecciona un Tipo para el evento',
                    icon: Icon(Icons.category_outlined),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: fecha_inicioController,
                  decoration: InputDecoration(
                    labelText: 'Fecha de inicio',
                    hintText: 'Fecha de inicio',
                    icon: Icon(Icons.category),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        fecha_inicioController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: fecha_finController,
                  decoration: InputDecoration(
                    labelText: 'Fecha de cierre',
                    hintText: 'Fecha de cierre',
                    icon: Icon(Icons.category),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        fecha_finController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                ),
                SizedBox(height: 16.0),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Seleccionar Imagen'),
                ),
                if (selectedImage != null) Image.file(selectedImage!),
                SizedBox(height: 32.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () async {
                      if (_validateFields()) {
                        // Primero, carga la imagen en Firebase Storage
                        final downloadUrl = await _uploadImage();
                        await eventoController.crearEvento(
                          userIdController.text.trim(),
                          nombreController.text.trim(), // Nombre
                          seccionController.text.trim(), // Nombre
                          selectedTipo ?? "",
                          fecha_inicioController.text.trim(), // Contraseña
                          fecha_finController.text.trim(), // Código
                          downloadUrl ?? "", // URL de la imagen
                        );
                        _navigateList(context); // Utiliza _navigateList aquí
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                50), // Agrega un BorderRadius de 10
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'CREAR',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                    width:
                        16), // Agrega un espacio entre el texto y el botón "Cancelar"
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/evento');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.red, // Color de fondo para el botón "Cancelar"
                    ),
                    child: Text(
                      "Cancelar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
