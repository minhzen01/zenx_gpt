/// Builder.
abstract class TranslateState {}

/// Listener.
abstract class TranslateActionState {}

/// Initial.
class TranslateInitial extends TranslateState {}

/// Change Language From.
class TranslateChangeLanguageFrom extends TranslateState {
  final String from;

  TranslateChangeLanguageFrom({required this.from});
}

/// Change Language To.
class TranslateChangeLanguageTo extends TranslateState {
  final String to;

  TranslateChangeLanguageTo({required this.to});
}

/// Swap Language.
class TranslateSwapLanguage extends TranslateState {
  final String from;
  final String to;
  final String text;

  TranslateSwapLanguage({required this.from, required this.to, required this.text});
}

/// Translate success.
class TranslateSuccess extends TranslateState {
  final String from;
  final String to;
  final String text;
  final String result;

  TranslateSuccess({required this.from, required this.to, required this.text, required this.result});
}

/// Translate failure.
class TranslateFailure extends TranslateState {
  final String from;
  final String to;
  final String text;
  final String result;

  TranslateFailure({required this.from, required this.to, required this.text, required this.result});
}

/// Loading.
class TranslateLoading extends TranslateState {}
