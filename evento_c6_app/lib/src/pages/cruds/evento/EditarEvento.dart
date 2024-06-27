
import 'package:evento_c6_app/src/controller/EventoController.dart';
import 'package:evento_c6_app/src/model/evento.dart';
import 'package:evento_c6_app/src/pages/cruds/evento/EventoList.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class EditEvento extends StatefulWidget {
  final List list;
  final int index;

  const EditEvento({super.key, required this.list, required this.index});

  @override
  State<EditEvento> createState() => _EditEventoState();
}

class _EditEventoState extends State<EditEvento> {
  EventoController eventoController = EventoController();

  late TextEditingController controllerid;
  late TextEditingController controlleruserId;
  late TextEditingController controllernombre;
  late TextEditingController controllerseccion;
  late TextEditingController controllertipo;
  late TextEditingController controllerfecha_inicio;
  late TextEditingController controllerfecha_fin;
  File? selectedImage;
  String eventoImageURL = "";

  @override
  void initState() {
    super.initState();
    controllerid =
        TextEditingController(text: widget.list[widget.index]['id'].toString());

    controlleruserId = TextEditingController(
        text: widget.list[widget.index]['userId']?.toString() ??
            'userId no especificado');    

    controllernombre = TextEditingController(
        text: widget.list[widget.index]['nombre']?.toString() ?? '');

    controllerseccion = TextEditingController(
        text: widget.list[widget.index]['seccion']?.toString() ?? '');
    
    selectedTipo = widget.list[widget.index]['tipo']?.toString() ?? "";

    controllerfecha_inicio = TextEditingController(
        text: widget.list[widget.index]['fecha_inicio']?.toString() ?? '');

    controllerfecha_fin = TextEditingController(
        text: widget.list[widget.index]['fecha_fin']?.toString() ?? '');

    eventoImageURL = widget.list[widget.index]['foto'] ?? '';

    selectedImage = null; // Initialize selectedImage as null
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    } else {
      // Handle if the user cancels image selection
    }
  }

  Future<void> _updateImageInFirebase() async {
    String eventoId = controllerid.text.trim();
    String eventoTitle = controllernombre.text.trim();

    String newImageUrl = widget.list[widget.index]['foto'] ?? "";

    if (selectedImage != null) {
      String fileName = 'evento/$eventoId-$eventoTitle.png';
      final firebaseStorageReference =
          FirebaseStorage.instance.ref().child(fileName);

      try {
        await firebaseStorageReference.putFile(selectedImage!);
        final downloadUrl = await firebaseStorageReference.getDownloadURL();

        if (downloadUrl != null) {
          newImageUrl = downloadUrl;
        } else {
          // Handle case where download URL is null
        }
      } catch (e) {
        print("Error uploading image: $e");
        // Handle error uploading image
      }
    }

    EventoModel updatedEvento = EventoModel(
      id: int.parse(eventoId),
      userId: controlleruserId.text.trim(),
      nombre: eventoTitle,
      seccion: controllerseccion.text.trim(),
      tipo: selectedTipo ?? "",
      fecha_inicio: controllerfecha_inicio.text.trim(),
      fecha_fin: controllerfecha_fin.text.trim(),
      foto: newImageUrl,
    );

    await eventoController.editarEvento(
      id: eventoId,
      userId: controlleruserId.text.trim(),
      nombre: eventoTitle,
      seccion: controllerseccion.text.trim(),
      tipo:selectedTipo ?? "", // Rol seleccionado
      fecha_inicio: controllerfecha_inicio.text.trim(),
      fecha_fin: controllerfecha_fin.text.trim(),
      foto: newImageUrl,
    );

    _navigateList(context);
  }

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventoList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

  String?
      selectedTipo; // Debes definir esta variable para almacenar el rol seleccionado
  List<String> tipos = ['publico', 'privado'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Evento"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(12.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.title, color: Colors.black),
                  title: TextFormField(
                    controller: controllerid,
                    decoration: InputDecoration(
                      hintText: "ID",
                      labelText: "ID",
                    ),
                    readOnly: true, // Make ID field read-only
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: eventoImageURL.isNotEmpty
                            ? eventoImageURL
                            : 'assets/nofoto.jpg',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/nofoto.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.photo, color: Colors.black),
                  title: ElevatedButton(
                    onPressed: _pickImage,
                    child: Text("Cambiar Foto"),
                  ),
                ),
                 ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controlleruserId,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Id del usuario",
                      labelText: "Id del usuario",
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controllernombre,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Nombre",
                      labelText: "Nombre de la evento",
                    ),
                  ),
                ),
               ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controllerseccion,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Seccion",
                      labelText: "Seccion para la vista del alumno",
                    ),
                  ),
                ),
                 Container(
                      margin: EdgeInsets.only(
                          left: 16.0,
                          right:
                              20.0), // Margen izquierdo para alinear visualmente con los otros campos
                      child: DropdownButtonFormField<String>(
                        value: selectedTipo,
                        onChanged: (String? newValue) {
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
                    ),
                ListTile(
                  leading: Icon(Icons.timer, color: Colors.black),
                  title: TextFormField(
                    controller: controllerfecha_inicio,
                    readOnly: true, // Hacer que el campo sea solo de lectura
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          controllerfecha_inicio.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Fecha de inicio",
                      labelText: "Fecha de inicio",
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.timer, color: Colors.black),
                  title: TextFormField(
                    controller: controllerfecha_fin,
                    readOnly: true, // Hacer que el campo sea solo de lectura
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          controllerfecha_fin.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Fecha de fin",
                      labelText: "Fecha de fin",
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _updateImageInFirebase,
                      child: Text("Editar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 16), // Agrega un espacio entre los botones
                    ElevatedButton(
                      onPressed: () {
                          Navigator.pushNamed(context, '/evento');
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
    );
  }
}
