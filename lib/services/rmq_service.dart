
import 'package:dart_amqp/dart_amqp.dart';

class RMQService {
  final String userQueue = "absensi_selfie";
  final String passQueue = "lkjhgfdsa123!";
  final String vHostQueue = "/absensi_selfie";
  final String hostQueue = "rmq2.pptik.id";
  final String queues = "android_publish";

  void publish(String message) {
    ConnectionSettings settings = new ConnectionSettings(
      host: hostQueue,
      authProvider: new PlainAuthenticator(userQueue, passQueue),
      virtualHost: vHostQueue,
    );
    Client client = new Client(settings: settings);

    client.channel().then((Channel channel) {
      return channel.queue(queues, durable: true);
    }).then((Queue queue) {
      queue.publish(message);
      client.close();
    });
  }
}
