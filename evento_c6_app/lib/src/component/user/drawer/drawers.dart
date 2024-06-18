import 'package:evento_c6_app/src/config/theme.dart';
import 'package:evento_c6_app/src/service/authService/ShareApiTokenService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  String accountEmail = "";
  String accountName = "";
  String accountFoto = "";
  String accountRole = "";

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  // Future<void> loadUserProfile() async {
  //   final loginDetails = await ShareApiTokenService.loginDetails();

  //   if (loginDetails != null) {
  //     setState(() {
  //       accountName = truncateText(loginDetails.user?.name ?? "", 10);
  //       accountEmail = truncateText(loginDetails.user?.email ?? "", 15);
  //       accountFoto = loginDetails.user?.foto ?? "";
  //     });
  //   }
  // }

  Future<void> loadUserProfile() async {
    final loginDetails = await ShareApiTokenService.loginDetails();

    if (loginDetails != null) {
      setState(() {
        accountName = truncateText(loginDetails.user?.name ?? "", 10);
        accountEmail = truncateText(loginDetails.user?.email ?? "", 15);
        accountFoto = loginDetails.user?.foto ?? "";
        accountRole = loginDetails.user?.role ?? "";
      });
    }
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }

  @override
  Widget build(BuildContext context) {
    //drawertheme
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();

    final name = '$accountName';
    final email = '$accountEmail';
    final urlImage = '$accountFoto';

    return Drawer(
      child: Material(
        color: themeProvider.isDiurno ? themeColors[0] : themeColors[6],
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildSearchField(),
                  const SizedBox(height: 24),
                  // Opciones comunes para ambos roles
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        accountRole == 'user' ? '/user_home' : '/admin_home',
                      );
                    },
                  ),
                 
                  const SizedBox(height: 16),
                  if (accountRole == 'user') ...[

                    buildMenuItem(
                      text: 'Libros',
                      icon: CupertinoIcons.book,
                      onTap: () {
                        Navigator.of(context).pushNamed('/librohome');
                      },
                    ),
                     const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Portal',
                    icon: Icons.school_outlined,
                    onTap: () {
                      Navigator.of(context).pushNamed('/colegiohome');
                    },
                  ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Workflow',
                      icon: Icons.workspaces_outline,
                      onTap: () {
                        Navigator.of(context).pushNamed('/workflow');
                      },
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Updates',
                      icon: Icons.update,
                      onTap: () {
                        Navigator.of(context).pushNamed('/updates');
                      },
                    ),
                  ],
                  if (accountRole == 'admin') ...[
                    // Opciones específicas para el rol de administrador
                    buildMenuItem(
                      text: 'Usuarios || CRUD',
                      icon: Icons.person,
                      onTap: () {
                        Navigator.of(context).pushNamed('/usuario');
                      },
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Evento || CRUD',
                      icon: Icons.person,
                      onTap: () {
                        Navigator.of(context).pushNamed('/evento');
                      },
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'reserva_crud',
                      icon: CupertinoIcons.book_solid,
                      onTap: () {
                        Navigator.of(context).pushNamed('/reserva_crud');
                      },
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Libro_Crud',
                      icon: CupertinoIcons.book_solid,
                      onTap: () {
                        Navigator.of(context).pushNamed('/libro_crud');
                      },
                    ),
                  ],
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          themeProvider.isDiurno
                              ? CupertinoIcons.sun_max
                              : CupertinoIcons.moon_circle,
                          size: 30,
                          color: themeProvider.isDiurno
                              ? Colors.white
                              : Colors.white,
                        ),
                        Switch(
                          value: themeProvider.isDiurno,
                          onChanged: (value) {
                            themeProvider.toggleTheme();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Plugins',
                    icon: Icons.account_tree_outlined,
                    onTap: () {
                      Navigator.of(context).pushNamed('/plugins');
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onTap: () {
                      ShareApiTokenService.logout(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
  }) =>
      Container(
        padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            Spacer(),
            CircleAvatar(
              radius: 24,
              backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              child: Icon(Icons.edit, color: Colors.white),
            )
          ],
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onTap,
    );
  }
}
