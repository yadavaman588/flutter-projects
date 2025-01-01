import 'dart:io';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/controllers/profile_controller.dart';
import 'package:itz_yours/widgets_commo/bg_widget.dart';
import 'package:itz_yours/widgets_commo/custom_textfield.dart';
import 'package:itz_yours/widgets_commo/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      height: 70,
                      width: 80,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(data['imageUrl'],
                              width: 80, height: 70, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              const Divider(),
              20.heightBox,
              customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false),
              20.heightBox,
              customTextField(
                  controller: controller.oldpassController,
                  hint: passswordHint,
                  title: oldpassword,
                  isPass: true),
              10.heightBox,
              customTextField(
                  controller: controller.newpassController,
                  hint: passswordHint,
                  title: newpassword,
                  isPass: true),
              30.heightBox,
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                          color: redColor,
                          onPress: () async {
                            controller.isLoading(true);
                            //if image is not selected by user
                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImg();
                            } else {
                              controller.profielImageLink = data['imageUrl'];
                            }
                            //if old password matches with the database

                            if (data['password'] ==
                                controller.oldpassController.text) {
                              if (controller.newpassController.text.length <
                                  6) {
                                VxToast.show(context,
                                    msg:
                                        "Minimum 6 Characters is required for password");
                                controller.isLoading(false);
                              } else {
                                await controller.changeAuthPassword(
                                  email: currentuser!.email,
                                  password: controller.oldpassController.text,
                                  newpassword:
                                      controller.newpassController.text,
                                );
                                await controller.updateProfile(
                                    imgUrl: controller.profielImageLink,
                                    name: controller.nameController.text,
                                    password:
                                        controller.newpassController.text);

                                VxToast.show(context, msg: "Updated");
                              }
                            } else {
                              VxToast.show(context,
                                  msg: "The old password is wrong");
                              controller.isLoading(false);
                            }
                          },
                          textColor: whiteColor,
                          title: "Save"),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}
