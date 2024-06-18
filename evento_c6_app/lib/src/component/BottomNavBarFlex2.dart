import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:hexcolor/hexcolor.dart';


class BottomNavBarFlex2 extends StatefulWidget {
  final VoidCallback onPressedSpecialButtonItem;
  final VoidCallback onPressedSpecialButtonPdf;
  final VoidCallback onPressedSpecialButtonExel;
  final dynamic buttonColor; // Propiedad para el color del botón
  
  

  BottomNavBarFlex2({
    required this.onPressedSpecialButtonItem,
    required this.onPressedSpecialButtonPdf,
    required this.onPressedSpecialButtonExel,
    this.buttonColor, // El color puede ser nulo o cualquier valor
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBarFlex2> {
  

  @override
  Widget build(BuildContext context) {
    Color buttonColor = widget.buttonColor ?? HexColor("#231D10"); // Valor predeterminado si el color es nulo
    return 
       
       Scaffold(
         backgroundColor: Colors.transparent, // Establece el fondo transparente
        
        bottomNavigationBar: BottomAppBar(
          color: HexColor("#231D10").withOpacity(0.8),
          height: 55.0,

          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home),
                  color: Colors.white),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bar_chart),
                  color: Colors.white),
              SizedBox(width: 50),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                  color: Colors.white),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person),
                  color: Colors.white),
            ],
          ),
        ),
        //  floatingActionButton: ClipOval(
        //   child: FloatingActionButton(
        //     onPressed: (){},
        //     child: Icon(Icons.add,color: Colors.white),
        //     backgroundColor: Colors.red, // Usa el color proporcionado o el valor predeterminado
        //     tooltip: 'click add',
        //     elevation: 30,
        //   ),
        // ),
        // asasasas
         floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_home,
          animatedIconTheme: IconThemeData(size: 22.0),
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          tooltip: 'speed dial',
          heroTag: 'speed dial aaaa' ,
          backgroundColor: HexColor("#231D10"),
          foregroundColor: Colors.white,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.print,color: Colors.white,),
              backgroundColor: buttonColor, // Usa el color proporcionado o el valor predeterminado
              
              label: 'Exportar a Exel',
              elevation: 5,
              onTap: () {
                widget.onPressedSpecialButtonExel();
              },
            ),
              SpeedDialChild(
              
              child: Icon(Icons.picture_as_pdf,color: Colors.white,),
              backgroundColor: buttonColor, // Usa el color proporcionado o el valor predeterminado
              label: 'Exportar a Pdf',
              elevation: 5,
              
              onTap: () {
                widget.onPressedSpecialButtonPdf();
              },
            ),
              SpeedDialChild(
              child: Icon(Icons.add,color: Colors.white,),
              backgroundColor: buttonColor, // Usa el color proporcionado o el valor predeterminado
              label: 'Agregar nuevo Item',
              elevation: 5,
              onTap: () {
                widget.onPressedSpecialButtonItem();
              },
            )
          ],

         ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );

  }
}
