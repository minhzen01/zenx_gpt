import '../constants/app_constants.dart';
import '../constants/lottie_path.dart';

enum HomeType { aiChatBot, aiImage, aiTranslate }

extension MyHomeType on HomeType {
  String get title => switch (this) {
        HomeType.aiChatBot => AppConst.chatBotTitle,
        HomeType.aiImage => AppConst.imageCreatorTitle,
        HomeType.aiTranslate => AppConst.languageTranslator,
      };

  String get lottiePath => switch (this) {
        HomeType.aiChatBot => LottiePath.aiGpt,
        HomeType.aiImage => LottiePath.aiImage,
        HomeType.aiTranslate => LottiePath.aiTranslate,
      };

  bool get leftAlign => switch (this) {
        HomeType.aiChatBot => true,
        HomeType.aiImage => false,
        HomeType.aiTranslate => true,
      };

  // VoidCallback get onTap => switch (this) {
  //       HomeType.aiChatBot => () => Get.to(
  //             () => const ChatBotFeature(),
  //             transition: Transition.rightToLeft,
  //             duration: const Duration(milliseconds: 200),
  //           ),
  //       HomeType.aiImage => () => Get.to(
  //             () => const ImageFeature(),
  //             transition: Transition.rightToLeft,
  //             duration: const Duration(milliseconds: 200),
  //           ),
  //       HomeType.aiTranslate => () => Get.to(
  //             () => const TranslatorFeature(),
  //             transition: Transition.rightToLeft,
  //             duration: const Duration(milliseconds: 200),
  //           ),
  //     };
}
