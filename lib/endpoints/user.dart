import 'package:get_server/get_server.dart' as serv;
import 'globals.dart' as globals;

class UserPage extends serv.GetView {
  @override
  serv.Widget build(serv.BuildContext context) {
    print('context: ${context.method.toString()}');

    if (context.method.toString() == 'Method.post') {
      print(context.request.query);
      print(context.request.input.headers);
      print(context.request.input.response);
      context.payload().then((value) => print(value));
      print(' length:: ${globals.sockets.length}');
      globals.sockets.forEach((ws) {
        print('ws ?? ${ws.id}');
        ws.send('Hey sockets this is a broadcast');
      });
      return serv.Text('Yo Hey whats up http');
    }
    return serv.Socket(builder: (socket) {
      print('Socket:: $socket');
      socket.onOpen((ws) {
        globals.sockets.add(ws);
        print('length after: ${globals.sockets.length}');
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
