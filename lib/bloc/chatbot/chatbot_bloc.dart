import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenx_chatbot/apis/apis.dart';
import 'package:zenx_chatbot/bloc/chatbot/chatbot_event.dart';
import 'package:zenx_chatbot/bloc/chatbot/chatbot_state.dart';
import 'package:zenx_chatbot/models/message.dart';
import '../../realm_db/presenter/message_realm_presenter.dart';

class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  ChatBotBloc() : super(ChatBotInitial()) {
    on<ChatBotEventInitialData>(_chatBotEventInitialData);
    on<ChatBotEventSendQuestion>(_chatBotEventSendQuestion);
    on<ChatBotEventDeleteMessage>(_chatBotEventDeleteMessage);
  }

  /// Initial Data From DB.
  List<Message> message = MessageRealmPresenter.getAllMessages().map((e) {
    return Message(
      msg: e.msg,
      msgType: e.msgType == 0 ? MessageType.bot : MessageType.user,
      complete: e.complete,
      dateTime: e.dateTime,
    );
  }).toList();

  /// Initial Data From DB.
  FutureOr<void> _chatBotEventInitialData(ChatBotEventInitialData event, Emitter<ChatBotState> emit) {
    emit(ChatBotInitialData(message: message));
  }

  /// Send Question.
  Future<FutureOr<void>> _chatBotEventSendQuestion(ChatBotEventSendQuestion event, Emitter<ChatBotState> emit) async {
    if (event.question.trim().isNotEmpty) {
      // user question.
      final question = Message(
        msg: event.question,
        msgType: MessageType.user,
      );
      message.add(question);
      MessageRealmPresenter.addMessage(question);
      emit(ChatBotReceiveData(message: message));

      // waiting.
      await Future.delayed(const Duration(milliseconds: 50));
      emit(ChatBotWaitingData());

      // call api.
      final res = await APIs.getAnswer(event.question);

      // bot answer.
      final answer = Message(
        msg: res,
        msgType: MessageType.bot,
      );
      message.add(answer);
      MessageRealmPresenter.addMessage(answer);
      emit(ChatBotReceiveData(message: message));
    }
  }

  /// Delete Message.
  FutureOr<void> _chatBotEventDeleteMessage(ChatBotEventDeleteMessage event, Emitter<ChatBotState> emit) {
    message.remove(event.message);
    emit(ChatBotReceiveData(message: message));
  }

}
