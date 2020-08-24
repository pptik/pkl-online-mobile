import 'package:dart_amqp/dart_amqp.dart';

class RMQService {
  final String userQueue = "pklonline";
  final String passQueue = "pekae123";
  final String vHostQueue = "/pklonline";
  final String hostQueue = "rmq.server.pptik.id";
  final String queues = "android_publish";

  void publish(String message) {
    try {
      ConnectionSettings settings = new ConnectionSettings(
        host: hostQueue,
        authProvider: new PlainAuthenticator(userQueue, passQueue),
        virtualHost: vHostQueue,
      );
      Client client = new Client(settings: settings);
      print(message);
      client.channel().then((Channel channel) {
        return channel.queue(queues, durable: true);
      }).then((Queue queue) {
        queue.publish(message);
        print("publish");
        client.close();
      });
    } catch (e) {
      print("cehs");
      print(e.toString());
    }
  }
}
