import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenx_chatbot/bloc/ai_image/ai_image_event.dart';
import 'package:zenx_chatbot/bloc/ai_image/ai_image_state.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:zenx_chatbot/constants/app_constants.dart';

import '../../widgets/dialog/my_dialog.dart';

enum Status { none, loading, success }

class AiImageBloc extends Bloc<AiImageEvent, AiImageState> {
  AiImageBloc() : super(AiImageInitial()) {
    on<AiImageEventCreateImage>(_aiImageEventCreateImage);
  }

  /// Generate Image.
  Future<FutureOr<void>> _aiImageEventCreateImage(AiImageEventCreateImage event, Emitter<AiImageState> emit) async {
    // Loading.
    emit(AiImageWaiting());
    try {
      // Generate Image.
      OpenAI.apiKey = AppConst.apiKey;
      OpenAIImageModel image = await OpenAI.instance.image.create(
        prompt: event.description,
        n: 1,
        size: OpenAIImageSize.size1024,
        responseFormat: OpenAIImageResponseFormat.url,
      );
      final url = image.data[0].url.toString();
      if (url != '') {
        // Success.
        emit(AiImageCreateImageSuccess(
          url: image.data[0].url.toString(),
          title: event.description,
        ));

        await Future.delayed(const Duration(milliseconds: 2500));
        MyDialog.success(AppConst.successTitle, AppConst.successSub);
      } else {
        // Failure.
        MyDialog.failure(AppConst.failureTitle, AppConst.failureSub);
        emit(AiImageCreateImageFailure());
      }
    } catch (e) {
      // Failure.
      MyDialog.failure(AppConst.failureTitle, AppConst.failureSub);

      emit(AiImageCreateImageFailure());
    }
  }
}
