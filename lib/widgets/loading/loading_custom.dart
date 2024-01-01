import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zenx_chatbot/constants/lottie_path.dart';
import 'package:zenx_chatbot/utils/app_utils/app_utils.dart';

class LoadingCustom extends StatelessWidget {
  const LoadingCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      LottiePath.loading,
      width: AppUtils.mq.width * .5,
    );
  }
}
