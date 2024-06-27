import 'package:evento_c6_app/src/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
        final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Container(
      color: themeProvider.isDiurno ? Colors.white: Colors.transparent,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, "/admin_home");
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,),
            child: Text(
              "Lista De Eventos",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
              ),
            ),
          ),
          Spacer(),
          Icon(Icons.more_vert,
          size: 30,
          color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],)
        ],
      ),
    );
  }
}