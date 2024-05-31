import 'package:flutter/material.dart';
import 'package:studentoglasi_admin/main.dart';
import 'package:studentoglasi_admin/screens/components/side_menu.dart';
import 'package:studentoglasi_admin/screens/login.dart';
import 'package:studentoglasi_admin/screens/objave_list_screen.dart';
import 'package:studentoglasi_admin/screens/prakse_list_screen.dart';
import 'package:studentoglasi_admin/screens/stipendije_list_screen.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? title_widget;
  String? addButtonLabel;
  VoidCallback? onAddButtonPressed;
  IconData? addButtonIcon;

  MasterScreenWidget(
      {this.child,
      this.title,
      this.title_widget,
      this.addButtonLabel,
      this.onAddButtonPressed,
      this.addButtonIcon,
      super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
        // appBar: AppBar(),
        // drawer: Drawer(
        //   child: ListView(
        //     children: [
        //       ListTile(
        //         title: Text('Objave'),
        //         onTap: () {
        //           Navigator.of(context).push(
        //             MaterialPageRoute(
        //               builder: (context) => const ObjaveListScreen(),
        //             ),
        //           );
        //         },
        //       ),
        //       ListTile(
        //         title: Text('Odjavi se'),
        //         onTap: () {
        //           Navigator.of(context).push(
        //             MaterialPageRoute(
        //               builder: (context) => LoginPage(),
        //             ),
        //           );
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        body:
        Row(children: [
          Expanded(child: SideMenu()),
        
         Expanded(
          flex: 5,
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(125, 50, 100, 0),
              child: Row(
                children: [
                  widget.title_widget ??
                      Text(
                        widget.title ?? "",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                  Spacer(),
                  if (widget.addButtonLabel != null)
                    ElevatedButton.icon(
                      onPressed: widget.onAddButtonPressed,
                      label: Text(widget.addButtonLabel ?? ''),
                      icon: Icon(widget.addButtonIcon ?? Icons.add),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue.shade800),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: widget.child!,
            ),
          ],
        ))],));
  }
}