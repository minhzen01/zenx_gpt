import 'package:equatable/equatable.dart';
import 'package:zenx_chatbot/models/message.dart';

abstract class ChatBotEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial.
class ChatBotEventInitial extends ChatBotEvent {}

/// Initial Data From DB.
class ChatBotEventInitialData extends ChatBotEvent {}

/// Send Question.
class ChatBotEventSendQuestion extends ChatBotEvent {
  final String question;

  ChatBotEventSendQuestion({required this.question});

  @override
  List<Object?> get props => [question];
}

/// Send Question.
class ChatBotEventDeleteMessage extends ChatBotEvent {
  final Message message;

  ChatBotEventDeleteMessage({required this.message});

  @override
  List<Object?> get props => [message];
}
