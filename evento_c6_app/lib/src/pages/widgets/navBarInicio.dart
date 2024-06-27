import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class NavBarInicio extends StatelessWidget {
  const NavBarInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
        duration: Duration(milliseconds: 600),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              alignment: Alignment.centerLeft,
              child: Text(
                'Evento Universitario ',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, top: 10, right: 25),
              alignment: Alignment.centerLeft,
              child: Text(
                'Descubre eventos publicos y sumérgete en nuevas historias y conocimientos.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25, top: 5),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 15,
                            ),
                            // Ajuste del espacio entre el icono y el texto
                            Text(
                              '137k',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5), // Espacio entre los dos textos
                        Text(
                          'Favorites',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            vertical: BorderSide(color: Colors.white))),
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 15,
                            ),
                            // Ajuste del espacio entre el icono y el texto
                            Text(
                              '137k',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5), // Espacio entre los dos textos
                        Text(
                          'Favorites',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 15,
                            ),
                            // Ajuste del espacio entre el icono y el texto
                            Text(
                              '137k',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5), // Espacio entre los dos textos
                        Text(
                          'Favorites',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
   
      ),
    );
  }
}
