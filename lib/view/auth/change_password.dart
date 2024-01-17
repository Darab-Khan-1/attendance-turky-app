import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../Widgets/buttons/k_elevated_button.dart';
import '../../Widgets/form_fields/k_text_field.dart';
import '../../controller/auth_controller/auth_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
   ChangePasswordScreen({super.key});
 final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
 final RxBool oldPassword = true.obs;
 final RxBool newPassword = true.obs;
final _authcontroller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }),
      child: Scaffold(
        appBar: AppBar(title: const Text('Change Password')),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.asset('assets/images/ridewithpassngers.png',height: 150,width: 230,),
                    const Gap(50),
                    Obx(() => TextInputFieldWidget(
                      controller: _authcontroller.oldPasswordController.value,
                      textInputType: TextInputType.emailAddress,
                      lable: 'Old Password',
                      hintText: 'Enter old Password',
                      obscure: oldPassword.value,
                      maxLines: 1,
                      suffixIcon: GestureDetector(
                        onTap: (){
                          oldPassword.value = !oldPassword.value;
                        },
                        child: Icon(oldPassword.value ? Icons.visibility_off : Icons.visibility),
                      ),
                      onChange: (value){
                        _authcontroller.checkPasswordValidity();
                      },
                      prefixIcon: const Icon(Icons.lock),
                    )),
                    const Gap(20),
                    Obx(() => TextInputFieldWidget(
                      controller: _authcontroller.newPasswordController.value,
                      textInputType: TextInputType.emailAddress,
                      lable: 'Password',
                      hintText: 'Enter New Password',
                      obscure: newPassword.value,
                      maxLines: 1,
                      suffixIcon: GestureDetector(
                        onTap: (){
                          newPassword.value = !newPassword.value;
                        },
                        child: Icon(newPassword.value ? Icons.visibility_off : Icons.visibility),
                      ),
                      onChange: (value){
                        _authcontroller.checkPasswordValidity();
                      },
                      prefixIcon: const Icon(Icons.lock),
                    )),
                    const Gap(20),
                    KElevatedButton(
                      title: 'Change Password',
                      isEnable: _authcontroller.isValid,
                      onPressed: () async {
                        if(_formkey.currentState!.validate()){
                          await _authcontroller.changePassword(context, oldPassword: _authcontroller.oldPasswordController.value.text, newPassword: _authcontroller.newPasswordController.value.text);


                        }
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
