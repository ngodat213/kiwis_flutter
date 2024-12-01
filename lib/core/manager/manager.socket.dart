import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ManagerSocket {
  ManagerSocket._();
  static IO.Socket socket = IO.io(AppAPI.domain,
      IO.OptionBuilder().setPath('/socket.io').setTransports(['websocket']));

  static void initSocket({int? idConversation, int? idChannel}) {
    print("idChannel" + idChannel.toString());
    try {
      socket = IO.io(
          AppAPI.domain,
          IO.OptionBuilder().setPath('/socket.io').setTransports(
              ['websocket']).setQuery({'idChannel': idChannel}).build());
      socket.connect();
      socket.on('connection', (_) {
        print('<-------------Connected socket------------->');
      });
      print('ok lalala');
    } catch (e) {
      print(e);
    }
  }
}
