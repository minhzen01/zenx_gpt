import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:zenx_chatbot/bloc/translate/translate_event.dart';
import 'package:zenx_chatbot/constants/app_colors.dart';
import 'package:zenx_chatbot/widgets/button/elevated_button_custom.dart';
import '../../bloc/translate/translate_bloc.dart';
import '../../bloc/translate/translate_state.dart';
import '../../constants/app_constants.dart';
import '../../widgets/language_bottom_sheet.dart';
import '../../widgets/loading/waiting_custom.dart';

class TranslatorFeature extends StatelessWidget {
  const TranslatorFeature({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerFrom = TextEditingController();
    final TextEditingController controllerTo = TextEditingController();
    String from = AppConst.fromLanguageDefault;
    String to = AppConst.toLanguageDefault;
    return BlocConsumer<TranslateBloc, TranslateState>(
      listenWhen: (previous, current) => current is TranslateActionState,
      listener: (context, state) {},
      buildWhen: (previous, current) => current is! TranslateActionState,
      builder: (context, state) {
        if (state is TranslateChangeLanguageFrom) {
          from = state.from;
        } else if (state is TranslateChangeLanguageTo) {
          to = state.to;
        } else if (state is TranslateSwapLanguage) {
          from = state.from;
          to = state.to;
          controllerFrom.text = state.text;
        } else if (state is TranslateSuccess) {
          from = state.from;
          to = state.to;
          controllerFrom.text = state.text;
          controllerTo.text = state.result;
          context.read<TranslateBloc>().add(TranslateEventInitial());
        }

        return Scaffold(
          backgroundColor: AppColors.bgApp,
          appBar: AppBar(
            leading: Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            title: const Text(AppConst.appBarTrans),
          ),
          body: Container(
            color: AppColors.borderTextField,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.bgApp,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              TextFormField(
                                controller: controllerFrom,
                                textAlign: TextAlign.left,
                                maxLines: null,
                                maxLength: null,
                                keyboardType: TextInputType.text,
                                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                                cursorColor: AppColors.whiteText90,
                                style: const TextStyle(color: AppColors.whiteText90, fontSize: 18),
                                decoration: const InputDecoration(
                                  hintText: AppConst.hintTranslateTextField,
                                  hintStyle: TextStyle(fontSize: 18, color: AppColors.hintTextField),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                  ),
                                ),
                              ),
                              if (controllerTo.text.trim().isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 64),
                                  child: Container(
                                    color: AppColors.messageUserBg,
                                    height: 1.5,
                                    width: double.infinity,
                                  ),
                                ),
                              TextFormField(
                                controller: controllerTo,
                                textAlign: TextAlign.left,
                                maxLines: null,
                                maxLength: null,
                                keyboardType: TextInputType.none,
                                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                                cursorColor: Colors.transparent,
                                style: const TextStyle(color: AppColors.blueText90, fontSize: 18),
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(fontSize: 14, color: AppColors.hintTextField),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (state is TranslateLoading)
                          const SizedBox(
                            height: 88,
                            width: double.infinity,
                            child: WaitingCustom(),
                          ),
                        if (state is! TranslateLoading)
                          SizedBox(
                            height: 88,
                            width: double.infinity,
                            child: ElevatedButtonCustom(
                              backgroundColor: AppColors.messageUserBg,
                              onTap: () {
                                if (state is! TranslateLoading) {
                                  context.read<TranslateBloc>().add(TranslateEventRequestTranslate(from: from, to: to, text: controllerFrom.text));
                                }
                              },
                              title: AppConst.translateButton,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 32),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.bottomSheet(
                              LanguageBottomSheet(
                                title: AppConst.translateFrom,
                                onChange: (value) {
                                  context.read<TranslateBloc>().add(TranslateEventChangeLanguageFrom(from: value));
                                },
                                selected: from,
                              ),
                            ),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.messageBotBg,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  from,
                                  style: const TextStyle(color: AppColors.whiteText90),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (from != AppConst.fromLanguageDefault) {
                              context.read<TranslateBloc>().add(TranslateEventSwapLanguage(from: to, to: from, result: controllerTo.text));
                            }
                          },
                          icon: const Icon(
                            // Icons.arrow_forward,
                            Icons.swap_horiz,
                            color: AppColors.whiteText75,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.bottomSheet(
                              LanguageBottomSheet(
                                title: AppConst.translateTo,
                                onChange: (value) {
                                  context.read<TranslateBloc>().add(TranslateEventChangeLanguageTo(to: value));
                                },
                                selected: to,
                              ),
                            ),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.messageBotBg,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  to,
                                  style: const TextStyle(color: AppColors.whiteText90),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
