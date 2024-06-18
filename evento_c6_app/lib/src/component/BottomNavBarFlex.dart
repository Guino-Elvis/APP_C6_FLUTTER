import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class BottomNavBarFlex extends StatefulWidget {
  final VoidCallback onPressedSpecialButton;
  final dynamic buttonColor; // Propiedad para el color del botón


  BottomNavBarFlex({
    required this.onPressedSpecialButton,
    this.buttonColor, // El color puede ser nulo o cualquier valor
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBarFlex> {
   

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
         floatingActionButton: ClipOval(
          child: FloatingActionButton(
            onPressed: widget.onPressedSpecialButton,
            child: Icon(Icons.add,color: Colors.white),
            backgroundColor: buttonColor, // Usa el color proporcionado o el valor predeterminado
            tooltip: 'click add',
            elevation: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );

  }
}
