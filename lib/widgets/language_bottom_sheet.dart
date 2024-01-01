import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenx_chatbot/bloc/translate/translate_constant.dart';
import 'package:zenx_chatbot/constants/app_colors.dart';
import 'package:zenx_chatbot/constants/app_constants.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({Key? key, required this.title, required this.onChange, required this.selected}) : super(key: key);
  final String title;
  final void Function(String) onChange;
  final String selected;

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  String searchValue = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = _controller.text.trim();
    List<String> fullList = List.from(TranslateConst.languageList);
    if (widget.title == AppConst.translateFrom) {
      fullList.insert(0, AppConst.fromLanguageDefault);
    }
    final List<String> list = c.isEmpty ? fullList : fullList.where((e) => e.toLowerCase().contains(searchValue)).toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.messageBotBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 32),
              Expanded(
                child: Center(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: AppColors.whiteText90,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: .5,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: const SizedBox(
                  height: 32,
                  width: 32,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.close,
                      color: AppColors.hintTextField,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _controller,
            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            onChanged: (value) {
              setState(() => searchValue = value.toLowerCase());
            },
            style: const TextStyle(color: AppColors.whiteText90),
            cursorColor: AppColors.whiteText90,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.hintTextField,
                size: 24,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              isDense: true,
              hintText: AppConst.search,
              hintStyle: TextStyle(fontSize: 16, color: AppColors.hintTextField),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(color: AppColors.borderTextField),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(color: AppColors.borderTextField),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(color: AppColors.borderTextField),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.only(left: 14.5),
            child: Text(
              AppConst.allLanguages,
              style: TextStyle(
                color: AppColors.hintTextField,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.bgApp,
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.only(top: 0),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      widget.onChange(list[index]);
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 13, left: 16, bottom: 12.5),
                      color: widget.selected == list[index] ? AppColors.messageUserBg : AppColors.bgApp,
                      width: double.infinity,
                      child: Row(
                        children: [
                          if (widget.selected == list[index])
                            const Padding(
                              padding: EdgeInsets.only(right: 12.0),
                              child: Icon(
                                Icons.check,
                                color: AppColors.lightBg,
                                size: 18,
                              ),
                            ),
                          Text(
                            list[index],
                            style: const TextStyle(
                              color: AppColors.whiteText90,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 1,
                    width: double.infinity,
                    color: AppColors.hintTextField,
                    padding: const EdgeInsets.only(left: 16, bottom: 6, right: 16),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
