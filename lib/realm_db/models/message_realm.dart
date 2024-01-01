import 'package:realm/realm.dart';

part 'message_realm.g.dart';

@RealmModel()
class _MessageRealm {
  late String msg;
  late int msgType;
  late bool complete;
  @PrimaryKey()
  late int dateTime;
}