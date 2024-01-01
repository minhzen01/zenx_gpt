import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zenx_chatbot/constants/app_constants.dart';
import 'package:zenx_chatbot/constants/app_text_styles.dart';
import 'package:zenx_chatbot/constants/lottie_path.dart';
import 'package:zenx_chatbot/models/board.dart';
import 'package:zenx_chatbot/realm_db/presenter/message_realm_presenter.dart';
import 'package:zenx_chatbot/routes/route_name.dart';
import 'package:zenx_chatbot/routes/router.dart';
import 'package:zenx_chatbot/utils/app_utils/app_utils.dart';
import 'package:zenx_chatbot/widgets/button/elevated_button_custom.dart';

import '../models/message.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    final list = [
      Board(
        title: AppConst.askMeTitle,
        subTitle: AppConst.askMeSub,
        lottie: LottiePath.aiAsk2,
      ),
      Board(
        title: AppConst.playTitle,
        subTitle: AppConst.playSub,
        lottie: LottiePath.aiAsk,
        // lottie: LottiePath.aiPlay,
      ),
    ];

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: list.length,
        itemBuilder: (ctx, index) {
          final bool isLast = index == list.length - 1;
          return SizedBox(
            width: AppUtils.mq.width,
            child: Column(
              children: [
                SizedBox(height: AppUtils.mq.height * .175),
                SizedBox(
                  height: AppUtils.mq.height * .4,
                  child: FractionallySizedBox(
                    widthFactor: .75,
                    child: Lottie.asset(
                      list[index].lottie,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  list[index].title,
                  style: AppTextStyles.textBold.copyWith(
                    letterSpacing: .5,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: AppUtils.mq.width * .7,
                  child: Text(
                    list[index].subTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.textMedium.copyWith(
                      color: Colors.black87,
                      height: 1.25,
                    ),
                  ),
                ),
                const Spacer(),
                Wrap(
                  spacing: 10,
                  children: List.generate(
                    list.length,
                    (i) => Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == index ? Colors.blue : Colors.grey,
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButtonCustom(
                  onTap: () {
                    if (isLast) {
                      AppRouter.goReplacement(context, RouteName.homeScreen);
                      final completedMessage = Message(msg: AppConst.chatBotQuestion, msgType: MessageType.bot, complete: true);
                      MessageRealmPresenter.addMessage(completedMessage);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  title: isLast ? AppConst.finishButton : AppConst.nextButton,
                ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     splashFactory: NoSplash.splashFactory,
                //     shape: const StadiumBorder(),
                //     elevation: 0,
                //     minimumSize: Size(AppUtils.mq.width * .4, 48),
                //     textStyle: AppTextStyles.textButton,
                //   ),
                //   onPressed: () {
                //     if (isLast) {
                //       AppRouter.goReplacement(context, RouteName.homeScreen);
                //     } else {
                //       pageController.nextPage(
                //         duration: const Duration(milliseconds: 500),
                //         curve: Curves.ease,
                //       );
                //     }
                //   },
                //   child: Text(
                //     isLast ? AppConst.finishButton : AppConst.nextButton,
                //   ),
                // ),
                const Spacer(flex: 2),
              ],
            ),
          );
        },
      ),
    );
  }
}
