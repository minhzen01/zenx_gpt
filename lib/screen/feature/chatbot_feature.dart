import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenx_chatbot/bloc/chatbot/chatbot_event.dart';
import 'package:zenx_chatbot/constants/app_colors.dart';
import 'package:zenx_chatbot/models/message.dart';
import 'package:zenx_chatbot/realm_db/presenter/message_realm_presenter.dart';
import 'package:zenx_chatbot/widgets/message_card.dart';
import 'package:zenx_chatbot/widgets/loading/waiting_custom.dart';
import '../../bloc/chatbot/chatbot_bloc.dart';
import '../../bloc/chatbot/chatbot_state.dart';
import '../../constants/app_constants.dart';

class ChatBotFeature extends StatefulWidget {
  const ChatBotFeature({super.key});

  @override
  State<ChatBotFeature> createState() => _ChatBotFeatureState();
}

class _ChatBotFeatureState extends State<ChatBotFeature> {
  final TextEditingController _controller = TextEditingController();
  List<Message> message = [];

  @override
  void initState() {
    super.initState();
    message = [];
    context.read<ChatBotBloc>().add(ChatBotEventInitialData());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgApp,
      appBar: AppBar(
        leading: Container(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            onPressed: () {
              for (int i = 0; i < message.length; i++) {
                context.read<ChatBotBloc>().message[i].complete = true;
              }
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(AppConst.appBarChatBot),
      ),
      body: BlocConsumer<ChatBotBloc, ChatBotState>(
        listenWhen: (previous, current) => current is ChatBotActionState,
        listener: (context, state) {},
        buildWhen: (previous, current) => current is! ChatBotActionState,
        builder: (context, state) {
          if (state is ChatBotReceiveData) {
            message = [];
            final reversedList = state.message;
            for (int i = reversedList.length - 1; i >= 0; i--) {
              message.add(reversedList[i]);
            }
          } else if (state is ChatBotInitialData) {
            message = [];
            final reversedList = state.message;
            for (int i = reversedList.length - 1; i >= 0; i--) {
              message.add(reversedList[i]);
            }
          }
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Flexible(
                      child: ListView.separated(
                        reverse: true,
                        padding: const EdgeInsets.only(top: 8),
                        shrinkWrap: true,
                        itemCount: message.length,
                        itemBuilder: (context, index) {
                          if (state is ChatBotWaitingData && index == 0) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                MessageCard(
                                    onTap: () {
                                      _showActionSheet(context, message[index]);
                                    },
                                    message: message[index],
                                    mContext: context),
                                const Center(child: WaitingCustom()),
                              ],
                            );
                          } else if (message[index].msgType == MessageType.bot && index == 0 && state is! ChatBotWaitingData) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MessageCard(
                                    onTap: () {
                                      _showActionSheet(context, message[index]);
                                    },
                                    message: message[index],
                                    mContext: context),
                                const SizedBox(height: 8),
                              ],
                            );
                          } else if (message[index].msgType == MessageType.user && index == 0 && state is! ChatBotWaitingData) {
                            return Align(
                              alignment: Alignment.centerRight,
                              child: MessageCard(
                                onTap: () {
                                  _showActionSheet(context, message[index]);
                                },
                                message: message[index],
                                mContext: context,
                              ),
                            );
                          } else {
                            return MessageCard(
                              onTap: () {
                                _showActionSheet(context, message[index]);
                              },
                              message: message[index],
                              mContext: context,
                            );
                          }
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 8);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller,
                          textAlign: TextAlign.center,
                          onTapOutside: (e) => FocusScope.of(context).unfocus(),
                          style: const TextStyle(color: AppColors.whiteText90),
                          cursorColor: AppColors.whiteText90,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            isDense: true,
                            hintText: AppConst.hintTextChatBot,
                            hintStyle: TextStyle(fontSize: 14, color: AppColors.hintTextField),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: AppColors.borderTextField),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: AppColors.borderTextField),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: AppColors.borderTextField),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: AppColors.darkBg,
                        radius: 24,
                        child: IconButton(
                          onPressed: () {
                            if (_controller.text.trim().isNotEmpty && state is! ChatBotWaitingData) {
                              context.read<ChatBotBloc>().add(ChatBotEventSendQuestion(question: _controller.text));
                              _controller.clear();
                            }
                          },
                          icon:
                              // Text("🚀", style: TextStyle(fontSize: 20),),
                              const Icon(
                            Icons.send,
                            color: AppColors.sendButton,
                            size: 28,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showActionSheet(BuildContext context, Message message) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          Container(
            color: AppColors.white10,
            child: CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                await Clipboard.setData(ClipboardData(text: message.msg));
                const snackBar = SnackBar(
                  duration: Duration(milliseconds: 1000),
                  backgroundColor: AppColors.successBg,
                  content: Text(AppConst.copied),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.symmetric(vertical: 56, horizontal: 12),
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text(AppConst.copy),
            ),
          ),
          Container(
            color: AppColors.white10,
            child: CupertinoActionSheetAction(
              child: const Text(
                AppConst.delete,
                style: TextStyle(color: AppColors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
                context.read<ChatBotBloc>().add(ChatBotEventDeleteMessage(message: message));
                MessageRealmPresenter.queryAndDeleteMessage(message);
              },
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: false,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            AppConst.cancel,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
