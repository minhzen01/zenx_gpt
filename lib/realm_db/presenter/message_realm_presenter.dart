import 'package:realm/realm.dart';
import 'package:zenx_chatbot/realm_db/models/message_realm.dart';
import '../../models/message.dart';
import '../realm_db.dart';

class MessageRealmPresenter {
  /// Initial.
  static Realm realm = RealmDb.initial([MessageRealm.schema]);

  /// Get all messages.
  static RealmResults<MessageRealm> getAllMessages() {
    RealmResults<MessageRealm> allMessage = realm.all<MessageRealm>();
    if (allMessage.length > 50) {
      final firstE = allMessage.take(allMessage.length - 50);
      realm.write(() => realm.deleteMany<MessageRealm>(firstE));
    }
    return realm.all<MessageRealm>();
  }

  /// Add message.
  static void addMessage(Message message) {
    realm.write<MessageRealm>(() {
      return realm.add<MessageRealm>(
        MessageRealm(
          message.msg,
          message.msgType == MessageType.bot ? 0 : 1,
          message.complete,
          message.dateTime,
        ),
        update: true,
      );
    });
  }

  /// Delete Message.
  static void deleteMessages(List<MessageRealm> messageList) {
    realm.deleteMany(messageList);
  }

  /// Query and delete message.
  static void queryAndDeleteMessage(Message message) {
    realm.write(
      () => realm.deleteMany<MessageRealm>(
        realm.query<MessageRealm>(
          'msg == \$0 AND msgType == \$1 AND complete == \$2 AND dateTime == \$3',
          [
            message.msg,
            message.msgType == MessageType.bot ? 0 : 1,
            message.complete,
            message.dateTime,
          ],
        ),
      ),
    );
  }
}
