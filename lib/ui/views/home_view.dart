import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pklonline/constants/route_name.dart';
import 'package:pklonline/ui/shared/colors_helper.dart';
import 'package:pklonline/viewmodels/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder:()=>HomeViewModel(),
      builder: (context,model,child) =>Scaffold(
          body: Center(
            child: Text("Home"),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: bluePrimary,
            child: Icon(
                Icons.add
            ),
            onPressed: () {
          model.goAnotherView(AbsenViewRoute);
            },
            heroTag: "AbsenViewRoute",
          )
      ),
    );
  }
  
}