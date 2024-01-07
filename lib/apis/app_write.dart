import 'package:appwrite/appwrite.dart';
import 'package:zenx_chatbot/constants/app_constants.dart';

class AppWrite {
  static final Client _client = Client();
  static final _database = Databases(_client);

  static void init() {
    _client.setEndpoint('https://cloud.appwrite.io/v1').setProject('659ab4cad8f7dc8f3363').setSelfSigned(status: true);
    getApiKey();
  }

  static Future<String> getApiKey() async {
    try {
      final d = await _database.getDocument(
        databaseId: AppConst.databaseId,
        collectionId: AppConst.collectionId,
        documentId: AppConst.documentId,
      );
      AppConst.apiKey = d.data[AppConst.apiKeyData];
      return AppConst.apiKey;
    } catch (e) {
      return '';
    }
  }
}
