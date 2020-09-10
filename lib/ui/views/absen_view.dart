import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pklonline/ui/shared/shared_style.dart';
import 'package:pklonline/ui/shared/ui_helper.dart';
import 'package:pklonline/viewmodels/absen_view_model.dart';
import 'package:stacked/stacked.dart';

class RadioGroup {
  final int index;
  final String text;
  RadioGroup({this.index, this.text});
}

class AbsenView extends StatefulWidget {
  @override
  _AbsenViewState createState() => _AbsenViewState();
}

class _AbsenViewState extends State<AbsenView> {
  int _rgProgramming = 1;
  String _selectedValue;

  final List<RadioGroup> _programmingList = [
    RadioGroup(index: 1, text: "Laporan Kehadiran"),
    RadioGroup(index: 2, text: "Laporan Tugas/PKL"),
    RadioGroup(index: 3, text: "Laporan Mobilitas"),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ViewModelBuilder<AbsenViewModel>.reactive(
      viewModelBuilder: () => AbsenViewModel(),
      onModelReady: (model) => model.openLocationSetting(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Report Task'),
        ),
        body: LoadingOverlay(
          isLoading: model.busy,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12),
                width: screenWidthPercent(
                  context,
                  multipleBy: 0.95,
                ),
                child: Column(
                  children: <Widget>[
                    verticalSpaceMedium,
                    InkWell(
                      onTap: () async {
                        await model.cameraView();
                      },
                      child: Container(
                        padding: fieldPadding,
                        width: screenWidthPercent(
                          context,
                          multipleBy: 0.83,
                        ),
                        height: screenHeightPercent(
                          context,
                          multipleBy: 0.4,
                        ),
                        child: model.isPathNull() == false
                            ? Center(
                                child: Text(
                                  'Tap',
                                  style: textButtonTextStyle,
                                ),
                              )
                            : FittedBox(
                                child: Image.file(File(model.imagePath)),
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                    ),
                    verticalSpaceMedium,
                    LocationWidget(
                      title: 'Lat',
                      content: '${model.lat}',
                      visible: model.isPathNull(),
                    ),
                    // Lng
                    verticalSpaceSmall,
                    LocationWidget(
                      title: 'Lng',
                      content: '${model.lng}',
                      visible: model.isPathNull(),
                    ),
                    verticalSpaceMedium,
                    Visibility(
                      visible: model.isPathNull(),
                      child: Text(
                        'Address',
                        style: absenNameTextStyle,
                      ),
                    ),
                    verticalSpaceSmall,
                    Visibility(
                      visible: model.isPathNull(),
                      child: Text(
                        '${model.address}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: absenContentTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    verticalSpaceMedium,
                    Visibility(
                        visible: model.isPathNull(),
                        child: Container(
                          child: Column(
                            children: _programmingList
                                .map((programming) => RadioListTile(
                                      title: Text(programming.text),
                                      value: programming.index,
                                      groupValue: _rgProgramming,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      dense: true,
                                      onChanged: (value) {
                                        setState(() {
                                          _rgProgramming = value;
                                          _selectedValue = programming.text;
                                        });

                                        model.getValueRadio(_rgProgramming);
                                        print(_selectedValue);
                                      },
                                    ))
                                .toList(),
                          ),
                        )),
                    verticalSpaceMedium,
                    Visibility(
                      visible: model.isPathNull(),
                      child: Text(
                        "Today's Activity",
                        style: absenNameTextStyle,
                      ),
                    ),
                    verticalSpaceSmall,
                    Visibility(
                      visible: model.isPathNull(),
                      child: Container(
                        padding: fieldPadding,
                        width: screenWidthPercent(
                          context,
                          multipleBy: 0.9,
                        ),
                        child: TextField(
                          controller: model.commentController,
                          maxLines: 9,
                          minLines: 5,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    Container(
                      padding: fieldPadding,
                      width: screenWidthPercent(
                        context,
                        multipleBy: 0.9,
                      ),
                      height: fieldHeight,
                      child: MaterialButton(
                        onPressed: () {
                          model.sendMessages(context);
                        }, //since this is only a UI app
                        child: Text(
                          'Report',
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
                    verticalSpaceSmall
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    Key key,
    this.title,
    this.content,
    this.visible = true,
  }) : super(key: key);

  final String title;
  final String content;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '$title',
            style: absenNameTextStyle,
          ),
          Text(
            '$content',
            style: absenContentTextStyle,
          ),
        ],
      ),
    );
  }
}
