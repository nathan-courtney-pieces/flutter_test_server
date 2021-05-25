import 'package:get_server/get_server.dart';

class SocketPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Socket(builder: (socket) {
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
