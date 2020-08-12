import 'package:pklonline/ui/shared/colors_helper.dart';
import 'package:pklonline/ui/shared/shared_style.dart';
import 'package:pklonline/ui/shared/ui_helper.dart';

import 'package:flutter/material.dart';
import 'package:pklonline/viewmodels/startup_view_model.dart';

//import 'package:provider_architecture/provider_architecture.dart';
import 'package:stacked/stacked.dart';

// import flutter services
import 'package:flutter/services.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lock Orientation Portait Only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      onModelReady: (model) => model.startTimer(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              verticalSpaceSmall,
              verticalSpaceSmall,
              Text(
                'PKL Online',
                style: titleTextStyle,
              ),
              verticalSpaceMedium,
              verticalSpaceMedium,
              CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).primaryColor,
                  )),
              verticalSpaceMedium,
              verticalSpaceMedium,
              Text(
                '1.0.2',
                style: textButtonTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
