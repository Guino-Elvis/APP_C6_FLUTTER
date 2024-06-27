import 'package:evento_c6_app/src/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class AsistenciaItem extends StatelessWidget {
  const AsistenciaItem({super.key});

 @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return GridView.count(
      childAspectRatio: 0.58,
      crossAxisCount: 2,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        for(int i=1; i <8; i++)
        Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
           // color: Colors.white,
             color: themeProvider.isDiurno ? Colors.white: themeColors[9],
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
                        color: themeProvider.isDiurno ? HexColor("#F82249"): themeColors[0],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ],),
                    child: Text(
                      "Publico",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.delete_outline,
                    color: themeProvider.isDiurno ? HexColor("#F82249"): themeColors[7],
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, "/detalle");
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Image.asset(
                    "assets/lib2.jfif",
                    width: 220,
                    height: 180,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Evento1",
                 
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
                      ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text("write description of pruduct",style: TextStyle( color: themeProvider.isDiurno ? Colors.black87: Colors.grey,),),
              ),
              SizedBox(height: 4),

           
            ],
          ),
        )
      ],
    );
  }
}
