import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenx_chatbot/apis/apis.dart';
import 'package:zenx_chatbot/bloc/translate/translate_event.dart';
import 'package:zenx_chatbot/bloc/translate/translate_state.dart';
import 'package:zenx_chatbot/constants/app_constants.dart';
import '../../widgets/dialog/my_dialog.dart';
import 'translate_constant.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateBloc() : super(TranslateInitial()) {
    on<TranslateEventInitial>(_translateEventInitial);
    on<TranslateEventChangeLanguageFrom>(_translateEventChangeLanguageFrom);
    on<TranslateEventChangeLanguageTo>(_translateEventChangeLanguageTo);
    on<TranslateEventSwapLanguage>(_translateEventSwapLanguage);
    on<TranslateEventRequestTranslate>(_translateEventRequestTranslate);
  }

  /// Initial.
  FutureOr<void> _translateEventInitial(TranslateEventInitial event, Emitter<TranslateState> emit) {
    emit(TranslateInitial());
  }

  /// Change Language From.
  FutureOr<void> _translateEventChangeLanguageFrom(TranslateEventChangeLanguageFrom event, Emitter<TranslateState> emit) {
    emit(TranslateChangeLanguageFrom(from: event.from));
  }

  /// Change Language To.
  FutureOr<void> _translateEventChangeLanguageTo(TranslateEventChangeLanguageTo event, Emitter<TranslateState> emit) {
    emit(TranslateChangeLanguageTo(to: event.to));
  }

  /// Swap Language.
  FutureOr<void> _translateEventSwapLanguage(TranslateEventSwapLanguage event, Emitter<TranslateState> emit) {
    emit(TranslateSwapLanguage(from: event.from, to: event.to, text: event.result));
  }

  /// Request Translate.
  Future<FutureOr<void>> _translateEventRequestTranslate(TranslateEventRequestTranslate event, Emitter<TranslateState> emit) async {
    if (event.text.trim().isNotEmpty) {
      emit(TranslateLoading());
      // String prompt = '';
      // if (event.from == AppConst.fromLanguageDefault) {
      //   prompt = 'Can you translate given text to ${event.to}: \n${event.text}';
      // } else {
      //   prompt = 'Can you translate given text from ${event.from} to ${event.to}: \n${event.text}';
      // }
      try {
        // final res = await APIs.getAnswer(prompt);
        final res = await APIs.googleTranslate(
          from: TranslateConst.languageList[event.from]!,
          to: TranslateConst.languageList[event.to]!,
          text: event.text,
        );
        emit(TranslateSuccess(from: event.from, to: event.to, text: event.text, result: res));
      } catch (e) {
        log(e.toString());
        emit(TranslateFailure(from: event.from, to: event.to, text: event.text, result: AppConst.requestTranslateFailure));
      }
    } else {
      MyDialog.info(AppConst.invalidTitle, AppConst.transFillDescription);
    }
  }
}
