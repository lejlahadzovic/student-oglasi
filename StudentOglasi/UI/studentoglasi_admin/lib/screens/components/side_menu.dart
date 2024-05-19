import 'package:flutter/material.dart';
import 'package:studentoglasi_admin/screens/login.dart';
import 'package:studentoglasi_admin/screens/objave_list_screen.dart';
import 'package:studentoglasi_admin/screens/prakse_list_screen.dart';
import 'package:studentoglasi_admin/screens/prijave_praksa_list_screen.dart';
import 'package:studentoglasi_admin/screens/prijave_stipendija_list_screen.dart';
import 'package:studentoglasi_admin/screens/stipendije_list_screen.dart';
import 'package:studentoglasi_admin/screens/studetni_list_screen.dart';

int _selectedIndex = 0;

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              DrawerHeader(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'StudentOglasi',
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              _buildListTile(Icons.supervisor_account_outlined, 'Studenti', 0),
              SizedBox(height: 3),
              _buildListTile(Icons.article_outlined, 'Novosti', 1),
              SizedBox(height: 3),
              _buildListTile(Icons.hotel_outlined, 'Smještaji', 2),
              SizedBox(height: 3),
              _buildListTile(Icons.work_outline, 'Prakse', 3),
              SizedBox(height: 3),
              _buildListTile(Icons.school_outlined, 'Stipendije', 4),
              SizedBox(height: 3),
              _buildListTile(Icons.date_range_outlined, 'Rezervacije', 5),
              SizedBox(height: 3),
              _buildListTile(Icons.done_all_outlined, 'Praksa - prijave', 6),
              SizedBox(height: 3),
              _buildListTile(
                  Icons.done_all_outlined, 'Stipendija - prijave', 7),
            ],
          )),
          Container(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      child: Column(
                    children: [
                      Divider(),
                      _buildListTile(
                          Icons.exit_to_app_outlined, 'Odjavi se', 8),
                    ],
                  ))))
        ],
      ),
    );
  }

  ListTile _buildListTile(IconData icon, String title, int index) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 20.0),
      leading: Icon(
        icon,
        color: _selectedIndex == index ? Colors.blue : Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: _selectedIndex == index ? Colors.blue : Colors.black,
        ),
      ),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        _navigateToScreen(index);
      },
    );
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const StudentiListScreen(),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ObjaveListScreen(),
          ),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PrakseListScreen(),
          ),
        );
        break;
      case 4:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const StipendijeListScreen(),
          ),
        );
        break;
        case 6:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PrijavePraksaListScreen(),
          ),
        );
        break;
        case 7:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PrijaveStipendijaListScreen(),
          ),
        );
        break;
      case 8:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
        break;
      default:
        break;
    }
  }
}
