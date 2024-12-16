import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Model/create_product_lov_data_model/city.dart';
import 'package:foundit/Model/create_product_lov_data_model/state_list.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/ViewModel/order_detail_view_model.dart';
import 'package:foundit/resources/components/textFieldDesign1.dart';
import 'package:foundit/resources/css_picker/css.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
final List cityList = [];

class CSSPicker extends StatelessWidget {
  final bool isEdit;
  final TextEditingController? countryController;
  final TextEditingController stateController;
  final TextEditingController cityController;

  CSSPicker({
    super.key,
    this.isEdit = false,
    this.countryController,
    required this.stateController,
    required this.cityController,
  });

  final cssViewModel = Get.put(CSSViewModel());
  @override
  Widget build(BuildContext context) {
    if (isEdit) cssViewModel.setStateValue(stateController.text);
    return Column(
      children: [
        StatefulBuilder(builder: (context, _setState) {
          return TextFieldDesign1(
            readOnly: true,
            label: "Country",
            hint: "Select Country",
            controller: countryController,
            onTap: () async {
              await _showStateDialog(context).then((value) {
                if (value is StateList) {
                  // stateController.text = value.name ?? '';
                  // log(stateController.text,
                  //     name: 'state controller text');
                  final List<City> _tempStateList = value.city ?? [];
                  cityList.clear();
                  cityController.text = '';
                  for (var element in _tempStateList) {
                    cityList.add(element.name ?? '');
                  }
                  // _setState(() {
                  cssViewModel.setSearchResult(stateList);
                  // });
                  cssViewModel.orderDetailViewModel
                      .setState(value.name.toString());
                  stateController.text = value.name!;
                } else {
                  log('error state select', name: 'stateSelect');
                }
              });
            },
          );
        }),
        isEdit
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Divider(
                  thickness: 1,
                ),
              )
            : SizedBox(),
        // 12.verticalSpace,
        Row(
          children: [
            Expanded(
              child: StatefulBuilder(builder: (context, _setState) {
                return TextFieldDesign1(
                  readOnly: true,
                  label: "State",
                  hint: "Select State",
                  controller: stateController,
                  onTap: () async {
                    await _showStateDialog(context).then((value) {
                      if (value is StateList) {
                        // stateController.text = value.name ?? '';
                        // log(stateController.text,
                        //     name: 'state controller text');
                        final List<City> _tempStateList = value.city ?? [];
                        cityList.clear();
                        cityController.text = '';
                        for (var element in _tempStateList) {
                          cityList.add(element.name ?? '');
                        }
                        // _setState(() {
                        cssViewModel.setSearchResult(stateList);
                        // });
                        cssViewModel.orderDetailViewModel
                            .setState(value.name.toString());
                        stateController.text = value.name!;
                      } else {
                        log('error state select', name: 'stateSelect');
                      }
                    });
                  },
                );
              }),
            ),
            10.horizontalSpace,
            Expanded(
              child: StatefulBuilder(builder: (context, _setState) {
                return TextFieldDesign1(
                  readOnly: true,
                  label: "City",
                  hint: "Select City",
                  controller: cityController,
                  onTap: () async {
                    if (cityList.isNotEmpty) {
                      await _showCityDialog(context).then((value) {
                        if (value is String) {
                          cityController.text = value;
                          _setState(() {});
                        }
                      });
                    } else {
                      Utils.showSnackBar(
                          type: false, msg: 'Please select state first.');
                    }
                  },
                );
              }),
            ),
          ],
        )
      ],
    );
  }

  Future _showStateDialog(BuildContext context) async {
    final TextEditingController stateSearchController = TextEditingController();
    return await showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (_context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              height: 0.6.sh,
              width: 0.9.sh,
              padding:
                  EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: GetBuilder<CSSViewModel>(builder: (value) {
                return Column(
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
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(33.0),
                          color: Color.fromARGB(73, 186, 196, 212)),
                      child: TextField(
                        onChanged: (_value) {
                          value.searchState(_value);
                        },
                        controller: stateSearchController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            prefixIcon: Icon(Icons.search)),
                      ),
                    ),
                    15.verticalSpace,
                    SizedBox(
                        height: 0.4.sh,
                        child: ListView.builder(
                          itemCount: value.searchResult.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Navigator.pop(
                                        context, value.searchResult[index]);
                                    log(value.searchResult[index].toString(),
                                        name: 'search result pop');
                                  },
                                  child: Row(
                                    children: [
                                      Text(value.searchResult[index].name
                                              as String? ??
                                          ""),
                                    ],
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          },
                        ))
                  ],
                );
              }),
            ),
          );
        });
  }

  Future _showCityDialog(BuildContext context) async {
    final TextEditingController citySearchController = TextEditingController();

    return await showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (_context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              height: 0.6.sh,
              width: 0.9.sh,
              padding:
                  EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: GetBuilder<CSSViewModel>(builder: (value) {
                return Column(
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
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(33.0),
                          color: Color.fromARGB(73, 186, 196, 212)),
                      child: TextField(
                        onChanged: (_value) {
                          value.searchCity(_value);
                        },
                        controller: citySearchController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            prefixIcon: Icon(Icons.search)),
                      ),
                    ),
                    15.verticalSpace,
                    SizedBox(
                      height: 0.4.sh,
                      child: ListView.builder(
                        itemCount: value.searchCityResult.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Navigator.pop(
                                      context, value.searchCityResult[index]);
                                  cssViewModel.setCitySearchResult(cityList);
                                },
                                child: Row(
                                  children: [
                                    Text(value.searchCityResult[index]),
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
                );
              }),
            ),
          );
        });
  }
}

class CSSViewModel extends GetxController {
  Timer _debounce = Timer(Duration(milliseconds: 500), () {});
  Timer _debounceCity = Timer(Duration(milliseconds: 500), () {});
  OrderDetailViewModel orderDetailViewModel = Get.put(OrderDetailViewModel());

  // List<Map<String, dynamic>> searchResult = stateList;
  List<StateList> searchResult = stateList;

  List searchCityResult = cityList;

  setSearchResult(List<StateList> value) {
    log(value.toString(), name: 'set search result');
    searchResult = value;
    update();
  }

  setCitySearchResult(value) {
    searchCityResult = value;
    update();
  }

  searchState(String searchQuery) {
    final String query = searchQuery.toLowerCase();
    if (_debounce.isActive) _debounce.cancel();
    _debounce = Timer(Duration(milliseconds: 600), () {
      if (query.isEmpty) {
        setSearchResult(stateList);
      } else {
        setSearchResult(
          stateList
              .where((element) => element.name!.toLowerCase().contains(query))
              .toList(),
        );
      }
    });
  }

  searchCity(String searchQuery) {
    final String query = searchQuery.toLowerCase();
    if (_debounceCity.isActive) _debounce.cancel();
    _debounceCity = Timer(Duration(milliseconds: 600), () {
      if (query.isEmpty) {
        setCitySearchResult(cityList);
      } else {
        setCitySearchResult(cityList
            .where((element) => element.toLowerCase().contains(query))
            .toList());
      }
    });
  }

  setStateValue(String stateValue) {
    final _state =
        stateList.firstWhereOrNull((element) => element.name == stateValue);
    if (_state != null) {
      for (var element in _state.city ?? []) {
        cityList.add(element.name as String? ?? '');
      }
    }
  }
}
