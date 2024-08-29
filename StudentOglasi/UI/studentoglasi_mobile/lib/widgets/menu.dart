import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100, // Set the height as per your requirement
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple[900],
              ),
            child: Text(
              'StudentOglasi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined, color: Colors.purple[900]),
            title: Text('Početna'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined, color: Colors.purple[900]),
            title: Text('Moj profil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.mail_outline, color: Colors.purple[900]),
            title: Text('Moje prijave'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/prijave');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.purple[900]),
            title: Text('Odjavi se'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/logout');
            },
          ),
        ],
      ),
    );
  }
}
