import 'package:realm/realm.dart';

class RealmDb {
  /// Initial
  static Realm initial(List<SchemaObject> schemaObjects) {
    return Realm(Configuration.local(schemaObjects));
  }
}
