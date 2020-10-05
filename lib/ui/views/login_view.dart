import 'package:flutter/material.dart';
import 'package:pklonline/constants/route_name.dart';
import 'package:pklonline/services/navigation_service.dart';
import 'package:pklonline/viewmodels/login_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('Assets/image1.png'),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter)),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 270),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(23),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Container(
                        color: Color(0xfff5f5f5),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: model.emailController,
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'SFUIDisplay'),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.person_outline),
                              labelStyle: TextStyle(fontSize: 15)),
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        controller: model.passwordController,
                        obscureText: true,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            labelStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: MaterialButton(
                        onPressed: () {
                          model.loginAccount(context);
                        }, //since this is only a UI app
                        child: Text(
                          'SIGN IN',
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
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: new GestureDetector(
                          onTap: (){
                            // model.changePassword(context);
                          },
                          child:Text(
                            'Forgot your password?',
                            style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Center(
                          child: InkWell(
                        onTap: () {
                          locator<NavigationService>()
                              .navigateTo(SignUpViewRoute);
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Don't have an account?",
                                style: TextStyle(
                                  fontFamily: 'SFUIDisplay',
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                            TextSpan(
                                text: "sign up",
                                style: TextStyle(
                                  fontFamily: 'SFUIDisplay',
                                  color: Color(0xffff2d55),
                                  fontSize: 15,
                                ))
                          ]),
                        ),
                      )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
