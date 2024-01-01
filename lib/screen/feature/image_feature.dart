import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zenx_chatbot/bloc/ai_image/ai_image_bloc.dart';
import 'package:zenx_chatbot/bloc/ai_image/ai_image_event.dart';
import 'package:zenx_chatbot/constants/app_colors.dart';
import 'package:zenx_chatbot/constants/lottie_path.dart';
import 'package:zenx_chatbot/utils/app_utils/app_utils.dart';
import 'package:zenx_chatbot/widgets/button/elevated_button_custom.dart';
import 'package:zenx_chatbot/widgets/dialog/my_dialog.dart';
import 'package:zenx_chatbot/widgets/loading/loading_custom.dart';
import '../../bloc/ai_image/ai_image_state.dart';
import '../../constants/app_constants.dart';
import 'package:http/http.dart' as http;

class ImageFeature extends StatelessWidget {
  const ImageFeature({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return BlocConsumer<AiImageBloc, AiImageState>(
      listenWhen: (previous, current) => current is AiImageActionState,
      listener: (context, state) {},
      buildWhen: (previous, current) => current is! AiImageActionState,
      builder: (context, state) {
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
            title: const Text(AppConst.appBarImage),
          ),
          body: ListView(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            children: [
              if (state is AiImageInitial)
                Column(
                  children: [
                    SizedBox(
                      height: AppUtils.mq.height * .1,
                      child: const Center(
                        child: Text(
                          AppConst.aiImageTitle,
                          style: TextStyle(
                            color: AppColors.whiteText90,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: AppUtils.mq.height * .45,
                      alignment: Alignment.center,
                      child: Lottie.asset(
                        LottiePath.aiAsk2,
                        height: AppUtils.mq.height * .4,
                      ),
                    ),
                  ],
                ),
              if (state is AiImageWaiting)
                Column(
                  children: [
                    SizedBox(height: AppUtils.mq.height * .1),
                    Container(
                      height: AppUtils.mq.height * .45,
                      alignment: Alignment.center,
                      child: const LoadingCustom(),
                    ),
                  ],
                ),
              if (state is AiImageCreateImageSuccess)
                Column(
                  children: [
                    SizedBox(
                      height: AppUtils.mq.height * .1,
                      child: Center(
                        child: Text(
                          '${state.title.toUpperCase()} ${AppConst.picture}',
                          // lobster, germaniaOne
                          textAlign: TextAlign.center,
                          style: GoogleFonts.germaniaOne(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: AppColors.messageUserBg,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: AppUtils.mq.height * .45,
                      alignment: Alignment.center,
                      child: _aiImage(state.url),
                    ),
                  ],
                ),
              if (state is AiImageCreateImageFailure)
                Container(
                  height: AppUtils.mq.height * .5,
                  alignment: Alignment.center,
                  child: const Icon(Icons.error),
                ),
              const SizedBox(height: 24),
              TextFormField(
                controller: controller,
                textAlign: TextAlign.center,
                maxLines: 2,
                maxLength: null,
                cursorColor: AppColors.whiteText90,
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                style: const TextStyle(color: AppColors.whiteText90),
                decoration: const InputDecoration(
                  hintText: AppConst.imageCreatorTextFormField,
                  hintStyle: TextStyle(fontSize: 14, color: AppColors.hintTextField),
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
              const SizedBox(height: 28),
              ElevatedButtonCustom(
                backgroundColor: AppColors.messageUserBg,
                onTap: () {
                  if (controller.text.trim().isNotEmpty) {
                    context.read<AiImageBloc>().add(AiImageEventCreateImage(description: controller.text));
                    controller.clear();
                  } else {
                    MyDialog.info(AppConst.invalidTitle, AppConst.imageFillDescription);
                  }
                },
                title: AppConst.imageCreateButtonTitle,
              ),
            ],
          ),
          floatingActionButton: state is AiImageCreateImageSuccess
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SpeedDial(
                    animatedIcon: AnimatedIcons.menu_close,
                    backgroundColor: AppColors.floatingActionButtonBg,
                    overlayColor: AppColors.darkBg,
                    overlayOpacity: .4,
                    spacing: 4,
                    spaceBetweenChildren: 4,
                    children: [
                      SpeedDialChild(
                        backgroundColor: AppColors.lightBg,
                        onTap: () {
                          _shareImage(state.url);
                        },
                        child: const Icon(
                          Icons.share,
                          color: AppColors.darkBg,
                        ),
                        elevation: 0,
                      ),
                      SpeedDialChild(
                        backgroundColor: AppColors.lightBg,
                        onTap: () {
                          _saveNetworkImage(state.url);
                        },
                        child: const Icon(
                          Icons.download,
                          color: AppColors.darkBg,
                        ),
                        elevation: 0,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }

  Widget _aiImage(String? url) {
    if (url != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => const LoadingCustom(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    } else {
      return Lottie.asset(
        LottiePath.aiAsk2,
        height: AppUtils.mq.height * .4,
      );
    }
  }

  Future<void> _saveNetworkImage(String url) async {
    try {
      MyDialog.showLoadingDialog();

      final bytes = (await http.get(Uri.parse(url))).bodyBytes;
      final dir = await getTemporaryDirectory();
      final file = await File('${dir.path}/ai_image.png').writeAsBytes(bytes);

      await GallerySaver.saveImage(file.path, albumName: AppConst.appName).then((success) {
        Get.back();
        MyDialog.success(AppConst.successTitle, AppConst.savedToGallery);
      });
    } catch (e) {
      Get.back();
      MyDialog.failure(AppConst.failureTitle, AppConst.failureSub);
    }
  }

  Future<void> _shareImage(String url) async {
    try {
      MyDialog.showLoadingDialog();

      final bytes = (await http.get(Uri.parse(url))).bodyBytes;
      final dir = await getTemporaryDirectory();
      final file = await File('${dir.path}/ai_image.png').writeAsBytes(bytes);

      Get.back();

      await Share.shareXFiles([XFile(file.path)], text: AppConst.shareImage);
    } catch (e) {
      Get.back();
      MyDialog.failure(AppConst.failureTitle, AppConst.failureSub);
    }
  }
}
