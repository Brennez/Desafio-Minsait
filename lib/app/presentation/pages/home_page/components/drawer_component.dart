import 'package:flutter/material.dart';

class DrawerComponnent extends StatelessWidget {
  const DrawerComponnent({
    super.key,
    required this.onTapHome,
    required this.onTapClearCache,
    required this.onTapHistoric,
  });

  final Function onTapHome;
  final Function onTapClearCache;
  final Function onTapHistoric;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF57606A),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Color(0xFF24292F)),
            title: Text('Home'),
            onTap: () => onTapHome(),
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              color: Color(0xFF24292F),
            ),
            title: Text('Histórico de buscas'),
            onTap: () => onTapHistoric(),
          ),
          ListTile(
            leading: Icon(
              Icons.clear_all,
              color: Color(0xFF24292F),
            ),
            title: Text('Limpar cache'),
            onTap: () => onTapClearCache(),
          ),
        ],
      ),
    );
  }
}
