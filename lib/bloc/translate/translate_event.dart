import 'package:equatable/equatable.dart';

abstract class TranslateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial.
class TranslateEventInitial extends TranslateEvent {}

/// Change Language From.
class TranslateEventChangeLanguageFrom extends TranslateEvent {
  final String from;

  TranslateEventChangeLanguageFrom({required this.from});

  @override
  List<Object?> get props => [from];
}

/// Change Language To.
class TranslateEventChangeLanguageTo extends TranslateEvent {
  final String to;

  TranslateEventChangeLanguageTo({required this.to});

  @override
  List<Object?> get props => [to];
}

/// Swap Language.
class TranslateEventSwapLanguage extends TranslateEvent {
  final String from;
  final String to;
  final String result;

  TranslateEventSwapLanguage({required this.from, required this.to, required this.result});

  @override
  List<Object?> get props => [from, to, result];
}

/// Request translate.
class TranslateEventRequestTranslate extends TranslateEvent {
  final String from;
  final String to;
  final String text;

  TranslateEventRequestTranslate({required this.from, required this.to, required this.text});

  @override
  List<Object?> get props => [from, to, text];
}
