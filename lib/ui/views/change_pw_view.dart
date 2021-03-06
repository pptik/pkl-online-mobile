import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pklonline/ui/shared/ui_helper.dart';
import 'package:pklonline/ui/widget/button_widget.dart';
import 'package:pklonline/ui/widget/text_field_widget.dart';
import 'package:pklonline/viewmodels/edit_password_view_model.dart';
//import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:stacked/stacked.dart';

// import flutter services
import 'package:flutter/services.dart';

class EditPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lock Orientation Portait Only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ViewModelBuilder<EditPasswordViewModel>.reactive(
      viewModelBuilder: () => EditPasswordViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Change Password'),
          centerTitle: true,
        ),
        body: LoadingOverlay(
          isLoading: model.busy,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    verticalSpaceLarge,
                    TextFieldWidget(
                      hintText: 'Current Password',
                      icon: Icons.lock,
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      textFieldController: model.currentPasswordController,
                    ),
                    verticalSpaceSmall,
                    TextFieldWidget(
                      hintText: 'New Password',
                      icon: Icons.vpn_key,
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      textFieldController: model.newPasswordController,
                    ),
                    verticalSpaceSmall,
                    TextFieldWidget(
                      hintText: 'New Password Confirmation',
                      icon: Icons.vpn_key,
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      textFieldController: model.confirmationPasswordController,
                    ),
                    verticalSpaceLarge,
                    MaterialButton(
                      onPressed: () {
                        model.onUpdtePassword(context);
                      }, //since this is only a UI app
                      child: Text(
                        'Save Password',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color(0xffff2d55),
                      elevation: 0,
                      minWidth: 400,
                      height: 50,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    )
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
