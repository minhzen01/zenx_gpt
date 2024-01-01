import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zenx_chatbot/hive_db/hive_constants.dart';

class HiveDB {
  static late Box _box;

  static Future<void> initialize() async {
    Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
    _box = Hive.box(name: HiveConst.nameBox);
  }

  static bool get showBoarding {
    return _box.get(HiveConst.showBoarding, defaultValue: true);
  }

  static set showBoarding(bool value) {
    return _box.put(HiveConst.showBoarding, value);
  }
}
