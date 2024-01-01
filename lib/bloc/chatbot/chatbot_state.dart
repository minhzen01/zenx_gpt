import 'package:zenx_chatbot/models/message.dart';

/// Builder.
abstract class ChatBotState {}

/// Listener.
abstract class ChatBotActionState {}

/// Initial.
class ChatBotInitial extends ChatBotState {}

/// Initial Data From DB.
class ChatBotInitialData extends ChatBotState {
  final List<Message> message;

  ChatBotInitialData({required this.message});
}

/// Receive Data From GPT.
class ChatBotReceiveData extends ChatBotState {
  final List<Message> message;

  ChatBotReceiveData({required this.message});
}

/// Waiting Data From GPT.
class ChatBotWaitingData extends ChatBotState {}
