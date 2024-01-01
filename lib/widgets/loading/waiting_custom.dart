import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zenx_chatbot/constants/lottie_path.dart';
import 'package:zenx_chatbot/utils/app_utils/app_utils.dart';

class WaitingCustom extends StatelessWidget {
  const WaitingCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      LottiePath.waiting,
      width: AppUtils.mq.width * .5,
    );
  }
}
