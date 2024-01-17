import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/buttons/k_elevated_button.dart';
import '../../Widgets/form_fields/k_text_field.dart';
import '../../controller/auth_controller/auth_controller.dart';
import '../bottom_navigation_bar_screen/bottom_navigation_bar_screen.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final _authcontroller = Get.put(AuthController());
  final RxBool isValid = true.obs;
  final RxBool isPasswordVisisble = false.obs;
   GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  checkValidity() {
    if (_authcontroller.emailController.value.text.isNotEmpty && _authcontroller.passwordController.value.text.isNotEmpty) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
  }
   final scaffoldKey = GlobalKey<ScaffoldState>();
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
        key: scaffoldKey,
        appBar: AppBar(title: Text('Login Screen')),
        body: Container(
          height: size.height,
          width: size.width,
          child:  Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: SingleChildScrollView(

                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     // Image.asset('assets/images/NJM_Pro&Supp.png',height: 200,width: 200,),
                     //  SizedBox(height: 60,),
                      TextInputFieldWidget(
                        controller: _authcontroller.emailController.value,
                        textInputType: TextInputType.emailAddress,
                        isEmail: true,
                        lable: 'Email',
                        hintText: 'Enter Email',
                        onChange: (value){
                          checkValidity();
                        },
                        prefixIcon: Icon(Icons.email),

                      ),
                      SizedBox(height: 20,),
                      Obx(() => TextInputFieldWidget(
                        controller: _authcontroller.passwordController.value,
                        textInputType: TextInputType.emailAddress,
                        lable: 'Password',
                        hintText: 'Enter Password',
                        obscure: isPasswordVisisble.value,
                        maxLines: 1,
                        suffixIcon: GestureDetector(
                          onTap: (){
                            isPasswordVisisble.value = !isPasswordVisisble.value;
                          },
                          child: Icon(isPasswordVisisble.value ? Icons.visibility : Icons.visibility_off),
                        ),
                        onChange: (value){
                          checkValidity();
                        },
                        prefixIcon: Icon(Icons.lock),
                      )),
                      SizedBox(height: 20,),
                      KElevatedButton(
                        title: 'Login',
                        isEnable: isValid,
                        onPressed: (){
                          if(_formkey.currentState!.validate()){
                            _authcontroller.login(context);
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
      ),
    );
  }
}
