import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pklonline/constants/helper.dart';
import 'package:pklonline/constants/route_name.dart';
import 'package:pklonline/ui/shared/colors_helper.dart';
import 'package:pklonline/ui/widget/list_content_widget.dart';
import 'package:pklonline/viewmodels/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Pkl Online"),
            centerTitle: true,
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (item) async {
                  print('item selected $item');
                  if (item.contains('Profile')) {
                    model.goAnotherView(ProfileViewRoute);
                  } else {
                    print('getting out');
                    model.signOut(context);
                  }
                },
                itemBuilder: (context) {
                  return Helper.choices.map(
                    (choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    },
                  ).toList();
                },
              ),
            ],
          ),
          body: SafeArea(
            child: ListView.builder(
              itemCount: model.absenData.length,
              itemBuilder: (context, i) {
                return ListContentWidget(
                  content: '${model.absenData[i].description}',
                  date: '${model.formatDate(model.absenData[i].timestamp)}',
                  address: '${model.absenData[i].address}',
                  imageUrl:
                      'http://pklonline.pptik.id/${model.absenData[i].image}',
                  name: '${model.absenData[i].name}',
                  imageLocal: '${model.absenData[i].localImage}',
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: bluePrimary,
            child: Icon(Icons.add),
            onPressed: () {
              model.goAnotherView(AbsenViewRoute);
            },
            heroTag: "AbsenViewRoute",
          )),
    );
  }
}
