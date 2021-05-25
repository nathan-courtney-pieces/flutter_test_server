// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as dart;
import 'package:get_server/get_server.dart' as serv;
import 'dart:convert';

class HomePage extends serv.GetView {
  @override
  serv.Widget build(serv.BuildContext context) {
    print('context: ${context.method.toString()}');

    if (context.method.toString() == 'Method.post') {
      print(context.request.query);
      print(context.param('name'));
      print(context.request.input.headers);
      print(context.request.input.response);
      print('string?? ${context.request.input.toString()}');
      print(context.response);
      print(context.obs);
      // print(context.payload().toString());
      // print(context.payload);
      context.payload().then((value) => print(value));
      // print('body: $body');

      // var thing = context.payload();
      // print(thing);
      // print(thing.);
      // print(context.payload());
      // var Stream<List<int>> thing = context.request.query
      // var content = utf8.decodeStream(context.payload().asStream());

      return serv.Text('Yo Hey whats up http');
    }
    return serv.Socket(builder: (socket) {
      socket.onOpen((ws) {
        ws.send('socket ${ws.id} connected');
      });

      socket.onMessage((data) {
        print('data: $data');
        // socket.send(data);
      });

      // socket.onClose((close) {
      //   print('socket has closed. Reason: ${close.message}');
      // });
    });
  }
}
