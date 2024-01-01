import 'package:equatable/equatable.dart';

abstract class AiImageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial.
class AiImageEventInitial extends AiImageEvent {}

/// Request Generate Image.
class AiImageEventCreateImage extends AiImageEvent {
  final String description;

  AiImageEventCreateImage({required this.description});

  @override
  List<Object?> get props => [description];
}
