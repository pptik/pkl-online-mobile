import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pklonline/ui/shared/shared_style.dart';
import 'package:pklonline/ui/shared/ui_helper.dart';
import 'package:pklonline/ui/widget/text_field_onchanged_widget.dart';
import 'package:pklonline/ui/widget/text_field_widget.dart';
import 'package:pklonline/viewmodels/change_kelas_viewmodel.dart';
import 'package:provider/provider.dart';
//import 'package:provider_architecture/provider_architecture.dart';
import 'package:stacked/stacked.dart';

// import flutter services
import 'package:flutter/services.dart';

class ChangeKelasView extends StatefulWidget {
  @override
  _ChangeKelasViewState createState() => _ChangeKelasViewState();
}

class _ChangeKelasViewState extends State<ChangeKelasView> {
  bool eulaVal = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    Provider.of<ChangeKelasViewModel>(context,listen: false).getAreas();
//  context.read<ChangeKelasViewModel>().getAreas();
  }

  @override
  Widget build(BuildContext context) {
    // Lock Orientation Portait Only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ViewModelBuilder<ChangeKelasViewModel>.reactive(
      viewModelBuilder: () => ChangeKelasViewModel(),
      onModelReady:(model)=> model.onModelReady(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Ganti Kelas'),
          centerTitle: true,
        ),
        body: LoadingOverlay(
          isLoading: model.busy,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      verticalSpaceLarge,
                      Container(
                          padding: fieldPadding,
                          width: screenWidthPercent(
                            context,
                            multipleBy: 0.9,
                          ),
                          height: fieldHeight,
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text('Choose Unit'),
                            value: model.unitSelected,
                            items: model.units == null
                                ? null
                                : model.units.map(
                                    (value) {
                                      return DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      );
                                    },
                                  ).toList(),
                            onChanged: (value) {
                              model.onUnitChanged(value);
                            },
                          ),
                        ),
                      // Visibility(
                      //   visible: model.changeVisibility(),
                      //   child: verticalSpaceSmall,
                      // ),
                      // Visibility(
                      //   visible: model.changeVisibility(),
                      //   child: Container(
                      //     padding: fieldPadding,
                      //     width: screenWidthPercent(
                      //       context,
                      //       multipleBy: 0.9,
                      //     ),
                      //     height: fieldHeight,
                      //     child: DropdownButton(
                      //       isExpanded: true,
                      //       hint: Text('Choose Unit'),
                      //       value: model.unitSelected,
                      //       items: model.units == null
                      //           ? null
                      //           : model.units.map(
                      //               (value) {
                      //                 return DropdownMenuItem(
                      //                   child: Text(value),
                      //                   value: value,
                      //                 );
                      //               },
                      //             ).toList(),
                      //       onChanged: (value) {
                      //         model.onUnitChanged(value);
                      //       },
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          onPressed: () {
                            model.updateKelas(context);
                          }, //since this is only a UI app
                          child: Text(
                            'UBAH',
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
                      verticalSpaceMedium,
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
