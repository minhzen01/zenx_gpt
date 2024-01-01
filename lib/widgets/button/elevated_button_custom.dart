import 'package:flutter/material.dart';
import 'package:zenx_chatbot/constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../utils/app_utils/app_utils.dart';

class ElevatedButtonCustom extends StatelessWidget {
  const ElevatedButtonCustom({Key? key, required this.onTap, required this.title, this.backgroundColor}) : super(key: key);
  final VoidCallback onTap;
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          splashFactory: NoSplash.splashFactory,
          shape: const StadiumBorder(),
          elevation: 0,
          minimumSize: Size(AppUtils.mq.width * .4, 48),
          textStyle: AppTextStyles.textButton,
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(color: AppColors.whiteText90),
        ),
      ),
    );
  }
}
