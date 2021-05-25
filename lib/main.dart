import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as mat;
import 'package:get_server/get_server.dart' as get_server;
import './server.dart';
import 'endpoints/home.dart';
import 'endpoints/user.dart';

void main() {
  // get_server.runApp(get_server.GetServer(home: SocketPage()));
  mat.runApp(MyApp());
  get_server.runIsolate(initServer);
  // initServer();
  doWhenWindowReady(() {
    final win = appWindow;
    final initialSize = Size(600, 450);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });
}

void initServer(_) {
  // get_server.runApp(
  //   get_server.GetServerApp(
  //     home: SocketPage(),
  //   ),
  // );

  get_server.runApp(get_server.GetServer(getPages: [
    get_server.GetPage(name: '/', page: () => HomePage()),
    get_server.GetPage(name: '/user', page: () => UserPage()),
  ]));
}

const borderColor = Color(0xFF805306);

class MyApp extends mat.StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return mat.MaterialApp(
        debugShowCheckedModeBanner: false,
        home: mat.Scaffold(
            body: WindowBorder(
                color: borderColor,
                width: 1,
                child: Row(children: [RightSide()]))));
  }
}

const backgroundStartColor = Color(0x424242);
const backgroundEndColor = Color(0xFAFAFA);

class RightSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [backgroundStartColor, backgroundEndColor],
                  stops: [0.0, 1.0]),
            ),
            child: Column(children: [
              WindowTitleBarBox(
                  child: Row(children: [
                Expanded(child: MoveWindow()),
                WindowButtons()
              ])),
              SizedBox(height: 120),
              SizedBox(
                  width: 400,
                  child: mat.TextFormField(
                    cursorColor: mat.Theme.of(context).cursorColor,
                    initialValue: '',
                    maxLength: 200,
                    decoration: mat.InputDecoration(
                      icon: Icon(mat.Icons.alternate_email),
                      labelText: '',
                      labelStyle: TextStyle(
                        color: Color(0xFF6200EE),
                      ),
                      helperText: 'Enter Email',
                      enabledBorder: mat.UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF6200EE)),
                      ),
                    ),
                  )),
              mat.TextButton(
                  style: mat.ButtonStyle(alignment: Alignment.bottomCenter),
                  onPressed: () {
                    appWindow.hide();
                  },
                  child: Text('Sign In'))
            ])));
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: Color(0xFF805306),
    mouseOver: Color(0xFFF6A00C),
    mouseDown: Color(0xFF805306),
    iconMouseOver: Color(0xFF805306),
    iconMouseDown: Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: Color(0xFFD32F2F),
    mouseDown: Color(0xFFB71C1C),
    iconNormal: Color(0xFF805306),
    iconMouseOver: mat.Colors.white);

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
