/// Builder.
abstract class AiImageState {}

/// Listener.
abstract class AiImageActionState extends AiImageState {}

/// Initial.
class AiImageInitial extends AiImageState {}

/// Loading.
class AiImageWaiting extends AiImageState {}

/// Create Image Success.
class AiImageCreateImageSuccess extends AiImageState {
  final String url;
  final String title;

  AiImageCreateImageSuccess({required this.url, required this.title});
}

/// Create Image Failure.
class AiImageCreateImageFailure extends AiImageState {}

/// ShowDialogSuccess.
class AiImageShowDialogSuccess extends AiImageActionState {}
