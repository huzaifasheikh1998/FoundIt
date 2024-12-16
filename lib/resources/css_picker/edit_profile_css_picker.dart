import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/resources/components/textFieldDesign1.dart';
import 'package:foundit/resources/css_picker/css.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EditProfileCSSPicker extends StatelessWidget {
  TextEditingController stateController;
  TextEditingController cityController;
  InputDecoration? inputDecoration;

  EditProfileCSSPicker({
    super.key,
    required this.stateController,
    required this.cityController,
    this.inputDecoration,
  });
  final List cityList = [];
  @override
  Widget build(BuildContext context) {
    final _state = stateList ??
        [].firstWhereOrNull((element) => element.name == stateController.text);
    if (_state != null) {
      for (var element in _state.name) {
        cityList.add(element.name as String? ?? '');
      }
    }
    return Padding(
      padding: EdgeInsets.only(),
      child: Column(
        children: [
          StatefulBuilder(builder: (context, _setState) {
            return TextFieldDesign1(
              prefixAsset: "assets/images/Icon awesome-flag-usa.svg",
              controller: stateController,
              label: "State",
              readOnly: true,
              onTap: () async {
                await _showStateDialog(context).then((value) {
                  if (value is Map<String, dynamic>) {
                    stateController.text = value['name'] as String? ?? '';
                    final List _tempStateList = value['city'] ?? [];
                    cityList.clear();
                    cityController.text = '';
                    for (var element in _tempStateList) {
                      cityList.add(element['name'] as String? ?? '');
                    }
                    _setState(() {});
                  }
                });
              },
            );
          }),
          Divider(
            thickness: 1,
          ),
          StatefulBuilder(builder: (context, _setState) {
            return TextFieldDesign1(
              prefixAsset: "assets/images/Icon awesome-city.svg",
              controller: cityController,
              label: "City",
              readOnly: true,
              onTap: () async {
                if (cityList.isNotEmpty) {
                  await _showCityDialog(context).then((value) {
                    if (value is String) {
                      cityController.text = value;
                      _setState(() {});
                    }
                  });
                }
              },
            );
          }),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Future _showStateDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (_context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              height: 0.5.sh,
              width: 0.9.sh,
              padding:
                  EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'States',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  15.verticalSpace,
                  SizedBox(
                    height: 0.4.sh,
                    child: ListView.builder(
                      itemCount: stateList?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.pop(context, stateList?[index]);
                              },
                              child: Row(
                                children: [
                                  Text(stateList?[index].name as String? ?? ""),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _showCityDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (_context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              height: 0.5.sh,
              width: 0.9.sh,
              padding:
                  EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Cities',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  15.verticalSpace,
                  SizedBox(
                    height: 0.4.sh,
                    child: ListView.builder(
                      itemCount: cityList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.pop(context, cityList[index]);
                              },
                              child: Row(
                                children: [
                                  Text(cityList[index]),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
