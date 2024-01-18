
import 'dart:io';

import 'package:attendence_app/controller/auth_controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Widgets/buttons/k_elevated_button.dart';
import '../../Widgets/form_fields/k_text.dart';
import '../../Widgets/form_fields/k_text_field.dart';
import '../../Widgets/image_picker/image_picker.dart';
import '../../constants/cached_image/cached_network_image.dart';
import '../../constants/colors.dart';
import '../../controller/proflie_controller/proflie_controller.dart';
import 'package:lottie/lottie.dart';

import '../auth/change_password.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  RxString profileImage=''.obs;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final controller = Get.put(ProfileController());
  final _authcontroller = Get.put(AuthController());

  RxBool isLogoutPressed = false.obs;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getProfile();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }),
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: kTransparent,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: Icon(Icons.lock, color: kWhiteColor),
                onPressed: () {
                  _authcontroller.oldPasswordController.value.clear();
                  _authcontroller.newPasswordController.value.clear();
                  Get.to(ChangePasswordScreen());
                },
              )
            ],
          ),
          body: Obx(() => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: controller.isloading.value == true?
            Center(child: CircularProgressIndicator(),):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      profileImage.value.isEmpty && controller.avatar.value.isEmpty?
                      GestureDetector(
                        onTap: () async {
                          await imagePickerFunction();
                        },
                        child: Lottie.asset("assets/json/profile_json.json",width: 220,height: 200,)):
                      GestureDetector(
                        onTap: () async {
                          await imagePickerFunction();
                        },
                        child: controller.avatar.isNotEmpty &&
                            controller.avatar.value.startsWith("http") &&
                            profileImage.value == ''?
                            cachedImage(imageURL: controller.avatar.value):
                        CircleAvatar(
                            radius: 60,
                            backgroundImage: Image.file(
                              File(profileImage
                                  .value), // Local file path
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context)
                                  .size
                                  .width,
                              height: 200,
                            ).image

                          // : const AssetImage(ImageAssets.lady),
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextInputFieldWidget(
                          controller: controller.nameController.value,
                          textInputType: TextInputType.emailAddress,
                          lable: 'Full Name',
                          prefixIcon: Icon(Icons.person),
                          onChange: (value){
                            controller.checkValidity();
                          }
                      ),
                      SizedBox(height: 10,),
                      TextInputFieldWidget(
                        controller: controller.emailController.value,
                        textInputType: TextInputType.emailAddress,
                        lable: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      SizedBox(height: 10,),
                      TextInputFieldWidget(
                        controller: controller.phoneController.value,
                        textInputType: TextInputType.phone,
                        lable: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                        onChange: (value){
                          controller.checkValidity();
                        },
                      ),
                      SizedBox(height: 10,),
                      KElevatedButton(
                        title: 'Update',
                        isEnable: controller.isValid,
                        onPressed: (){
                          if(_formkey.currentState!.validate()){
                            controller.updateProfile(context);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
          floatingActionButton: KFloatingButton(
            lable: "Logout",
            ontap: () {
              if(isLogoutPressed.value == false){
                isLogoutPressed.value = true;
                controller.logoutApi(context);
              }
            },
          )
      ),
    );
  }

  Future<void> imagePickerFunction () async{
    final ctrl = Get.find<ProfileController>();
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
    ].request();

    if (statuses[Permission.camera]!.isGranted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        scaffoldKey.currentState!.showBottomSheet(
              (context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 210,
              child:  CustomImagePicker(
                onImagePicked: (value) {
                  if(value!=null){
                    profileImage.value = value.path;
                    ctrl.avatar.value = value.path;
                  }
                  ctrl.checkValidity();
                  Navigator.pop(context, value); // Return the picked image to the caller
                },
              ),
            );
          },
        );
      });
    } else {
      print('No permission provided');
      if (statuses[Permission.storage]!.isDenied ||
          statuses[Permission.storage]!.isPermanentlyDenied) {
        // Handle storage permission denied or permanently denied
        print('Storage permission denied');
      }
      if (statuses[Permission.camera]!.isDenied ||
          statuses[Permission.camera]!.isPermanentlyDenied) {
        // Handle camera permission denied or permanently denied
        print('Camera permission denied');
      }
    }

  }
}
