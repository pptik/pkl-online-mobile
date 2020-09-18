import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pklonline/ui/shared/shared_style.dart';
import 'package:pklonline/ui/shared/ui_helper.dart';
import 'package:pklonline/ui/widget/card_content_widget.dart';
import 'package:pklonline/viewmodels/profile_view_model.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lock Orientation Portait Only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ViewModelBuilder<ProfileViewModel>.reactive(
      onModelReady: (model) => model.initClass(),
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Profile'),
          centerTitle: true,
          actions: <Widget>[],
        ),
        body: LoadingOverlay(
          isLoading: model.busy,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    verticalSpaceSmall,
                    Card(
                      color: Colors.white,
                      child: Container(
                        width: screenWidthPercent(
                          context,
                          multipleBy: 0.95,
                        ),
                        child: Column(
                          children: <Widget>[
                            verticalSpaceSmall,
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: "${model.image}",
                                  placeholder: (context, url) =>
                                      new CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.image),
                                  fit: BoxFit.cover,
                                  height: 150,
                                ),
                              ),
                              width: 200,
                              height: 150,
                            ),
                            verticalSpaceSmall,
                            Text(
                              '${model.name}',
                              style: profileTextStyle,
                            ),
                            verticalSpaceSmall,
                          ],
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    Card(
                      color: Colors.white,
                      child: Container(
                        width: screenWidthPercent(
                          context,
                          multipleBy: 0.95,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Contact',
                                    style: cardTitleTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            CardContentWidget(
                                content: '${model.phoneNumber}',
                                icon: Icons.call),
                            CardContentWidget(
                                content: '${model.email}', icon: Icons.email),
                          ],
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    Card(
                      color: Colors.white,
                      child: Container(
                        width: screenWidthPercent(
                          context,
                          multipleBy: 0.95,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Class',
                                    style: cardTitleTextStyle,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // locator<VibrateService>().vibrateOn();
                                      model.goToEditProfile();
                                    },
                                    child: Text(
                                      'Edit',
                                      style: cardTitleYellowTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CardContentWidget(
                              content: '${model.unit}',
                              icon: Icons.class_,
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    Card(
                      color: Colors.white,
                      child: Container(
                          width: screenWidthPercent(
                            context,
                            multipleBy: 0.95,
                          ),
                          child: FlatButton(
                            onPressed: () {
                              model.goToChangePassword();
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      "Change Password",
                                      style: cardTitleYellowTextStyle,
                                    )),
                              ],
                            ),
                          )),
                    ),
                    verticalSpaceSmall,
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

class CircularIconButtonWidget extends StatelessWidget {
  final Function onTapFunction;
  final IconData icon;

  const CircularIconButtonWidget({
    Key key,
    @required this.onTapFunction,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onTapFunction,
      ),
    );
  }
}
