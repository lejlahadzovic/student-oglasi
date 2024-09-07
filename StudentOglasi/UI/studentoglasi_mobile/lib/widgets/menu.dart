import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100, 
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  Icon(Icons.school, color: Colors.white, size: 30),
                  SizedBox(width: 12),
                  Text(
                    'StudentOglasi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildListTile(
            context,
            Icons.home_outlined,
            'Početna',
            '/home',
          ),
          _buildListTile(
            context,
            Icons.account_circle_outlined,
            'Moj profil',
            '/profile',
          ),
          _buildListTile(
            context,
            Icons.mail_outline,
            'Moje prijave',
            '/prijave',
          ),
          _buildListTile(
            context,
            Icons.chat_bubble_outline,
            'Chat',
            '/chat',
          ),
          _buildListTile(
            context,
            Icons.notification_add_outlined,
            'Obavijesti',
            '/obavijesti',
          ),
          _buildListTile(
            context,
            Icons.logout,
            'Odjavi se',
            '/logout',
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title, String route) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: TextStyle(color: Colors.blue)),
      ),
      splashColor: Colors.blue.withOpacity(0.2),
      highlightColor: Colors.blue.withOpacity(0.1),
    );
  }
}
