/// Builder.
abstract class AiImageState {}

/// Listener.
abstract class AiImageActionState {}

/// Initial.
class AiImageInitial extends AiImageState {}

class AiImageWaiting extends AiImageState {}

/// Create Image Success.
class AiImageCreateImageSuccess extends AiImageState {
  final String url;
  final String title;

  AiImageCreateImageSuccess({required this.url, required this.title});
}

/// Create Image Failure.
class AiImageCreateImageFailure extends AiImageState {}
