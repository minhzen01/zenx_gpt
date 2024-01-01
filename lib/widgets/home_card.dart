import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:zenx_chatbot/constants/app_colors.dart';
import 'package:zenx_chatbot/constants/app_text_styles.dart';
import 'package:zenx_chatbot/models/home_type.dart';
import 'package:zenx_chatbot/utils/app_utils/app_utils.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key, required this.homeType, required this.onTap}) : super(key: key);

  final HomeType homeType;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        elevation: 0,
        color: AppColors.homeCardBg,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (homeType.leftAlign)
                Lottie.asset(
                  homeType.lottiePath,
                  width: AppUtils.mq.width * .35,
                ),
              Expanded(
                child: Center(
                  child: Text(
                    homeType.title,
                    style: AppTextStyles.textButton.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5,
                      color: AppColors.whiteText90,
                    ),
                  ),
                ),
              ),
              if (!homeType.leftAlign)
                Lottie.asset(
                  homeType.lottiePath,
                  width: AppUtils.mq.width * .35,
                ),
            ],
          ),
        ),
      ).animate().fade(duration: 1.5.seconds, curve: Curves.easeIn),
    );
  }
}
