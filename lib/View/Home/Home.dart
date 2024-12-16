import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Controller/BottomController.dart';
import 'package:foundit/Controller/UserController.dart';
import 'package:foundit/NavBar/Navbar.dart';
import 'package:foundit/View/Home/BoxItemScreen.dart';
import 'package:foundit/View/Home/Filter.dart';
import 'package:foundit/resources/components/Global.dart';
import 'package:foundit/services/api_services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Box",
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xff2C2C2C)),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            final bottomcontroller = Get.put(BottomController());
            bottomcontroller.navBarChange(0);
            Get.to(() => MainScreen());
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Container(
              width: 56.w,
              height: 38.h,
              child: Image.asset("assets/images/Group 331@2x.png"),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 336.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffEA8806)),
                        borderRadius: BorderRadius.circular(25.r),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 25, top: 6),
                          // labelText: "Type a message",
                          hintText: "Search here",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xffA7B1BF),
                            fontFamily: "Inter, Regular",
                          ),
                          suffixIcon: Container(
                            width: 50.w,
                            height: 30.h,
                            child: Row(
                              children: [
                                7.horizontalSpace,
                                Container(
                                  width: 40.w,
                                  height: 40.h,
                                  // decoration: BoxDecoration(
                                  //   shape: BoxShape.circle,
                                  //   color: Color(0xff00DBFA),
                                  // ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/Group 450@2x.png",
                                      scale: 3,
                                      color: Color(0xffA7B1BF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => FilterScreen());
                      },
                      child: Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffFFB24B),
                              Color(0xffEA8806),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          "assets/images/Icon material-filter-list@2x.png",
                          scale: 2,
                        ),
                      ),
                    )
                  ],
                ),
                21.verticalSpace,
                FutureBuilder(
                  future: ApiServices().callGetBoxes(context),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(
                        color: Color(0xffEA8806),
                      );
                    } else {
                      if (snapshot.data == true) {
                        final _data = UserController.user.data!;
                        if (_data.isEmpty || _data.length == 0) {
                          return Center(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 0.2.sh),
                                  child: Image.asset(
                                    "assets/images/folder.png",
                                    scale: 5,
                                  ),
                                ),
                                Text("No Boxes Found")
                              ],
                            ),
                          );
                        } else {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _data.length,
                            itemBuilder: (context, index) {
                              final _box = _data[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => BoxItemScreen(
                                        box: _box,
                                      ));
                                  // Get.toNamed("/Box1Screen");
                                },
                                child: Container(
                                  width: 390.w,
                                  height: 91.h,
                                  margin: EdgeInsets.symmetric(vertical: 8.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.r),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 80.w,
                                              height: 62.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(40)),

                                                  // border: Border.all(
                                                  // color: Colors.red,
                                                  // ),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        baseUrl +
                                                            UserController
                                                                .user
                                                                .data![index]
                                                                .thumbnail
                                                                .toString(),
                                                      ))),
                                              // child: Image.network(
                                              //   baseUrl +
                                              //       UserController
                                              //           .user.data![index].thumbnail
                                              //           .toString(),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                            26.horizontalSpace,
                                            Text(
                                              UserController
                                                  .user.data![index].boxName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            log(_box.id.toString());
                                            await ApiServices()
                                                .deleteBox(
                                                    _box.id.toString(), context)
                                                .then((value) => setState(
                                                      () {},
                                                    ));
                                          },
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(right: 15.w),
                                            width: 16.w,
                                            height: 21.h,
                                            child: Image.asset(
                                                "assets/images/Icon material-delete@2x.png"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        return Container();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
