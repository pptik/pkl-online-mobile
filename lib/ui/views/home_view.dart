import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      builder: (context, model, child) => Scaffold(
          body: SafeArea(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, i) {
                return ListContentWidget(
                  content: 'Laporan Tentang Sesuatu',
                  date: '19299202002',
                  address: 'Komplek Padasuka ',
                  imageUrl:
                      'https://cdn.pixabay.com/photo/2017/02/16/23/10/smile-2072907_1280.jpg',
                  name: 'Deral Alvin',
                  imageLocal: '-',
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
