import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenx_chatbot/bloc/chatbot/chatbot_bloc.dart';
import 'package:zenx_chatbot/constants/app_colors.dart';
import 'package:zenx_chatbot/models/message.dart';
import 'package:zenx_chatbot/realm_db/presenter/message_realm_presenter.dart';
import '../constants/app_constants.dart';
import '../constants/image_path.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  final BuildContext mContext;
  final void Function() onTap;

  const MessageCard({super.key, required this.message, required this.mContext, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: message.msgType == MessageType.bot
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.bgApp,
                        child: Image.asset(
                          ImagePath.appLogo,
                          width: 28,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 4, bottom: 4.0),
                        child: Text(
                          AppConst.appName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.messageBotBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: message.complete == false
                        ? AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                message.msg,
                                textStyle: const TextStyle(
                                  color: AppColors.whiteText90,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 1.25,
                                ),
                                speed: const Duration(milliseconds: 10),
                              ),
                            ],
                            isRepeatingAnimation: false,
                            onTap: () {
                              // print("Tap Event");
                            },
                            onFinished: () {
                              final index =
                                  context.read<ChatBotBloc>().message.indexWhere((e) => (e.msg == message.msg && e.dateTime == message.dateTime));
                              context.read<ChatBotBloc>().message[index].complete = true;
                              MessageRealmPresenter.addMessage(context.read<ChatBotBloc>().message[index]);
                            },
                          )
                        : Text(
                            message.msg,
                            style: const TextStyle(
                              color: AppColors.whiteText90,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.25,
                            ),
                          ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.messageUserBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message.msg,
                      style: const TextStyle(
                        color: AppColors.whiteText90,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
