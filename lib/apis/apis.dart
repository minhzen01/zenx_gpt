import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:translator_plus/translator_plus.dart';
import '../constants/app_constants.dart';

class APIs {
  // Get answer from chat GPT.
  static Future<String> getAnswer(String question) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer ${AppConst.apiKey}'},
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "max_tokens": 2000,
          "temperature": 0,
          "messages": [
            {
              "role": "user",
              "content": question,
            },
          ]
        }),
      );

      final data = jsonDecode(response.body);
      final encodedString = data['choices'][0]['message']['content'];
      final decodedString = utf8.decode(encodedString.runes.toList());
      return decodedString;
    } catch (e) {
      log('getAnswerException $e');
      return 'Something went wrong (Try again in sometime)';
    }
  }

  // Google translate.
  static Future<String> googleTranslate({required String from, required String to, required String text}) async {
    try {
      final translator = GoogleTranslator();
      final res = await translator.translate(
        text,
        from: from,
        to: to,
      );
      return res.text;
    } catch (e) {
      log(e.toString());
      return 'Something went wrong (Try again in sometime)';
    }
  }
}
