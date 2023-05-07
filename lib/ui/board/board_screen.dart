import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:btliot/constant.dart';
import 'package:btliot/extension/date_formatting.dart';
import 'package:btliot/ui/board/cubit/broad_cubit.dart';
import 'package:btliot/ui/board/cubit/broad_state.dart';
import 'package:btliot/ui/detail_board/detail_board.dart';
import 'package:btliot/ui/edit_board/edit_board_screen.dart';
import 'package:btliot/ui/image/image_screen.dart';
import 'package:btliot/ui/router/router.gr.dart';
import 'package:btliot/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as p;

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  List<XFile> imageFileList = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BroadCubit()..init(),
      child: BlocConsumer<BroadCubit, BroadState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: greyPrymarySecondColor,
              appBar: _appBar(context),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditBoardScreen()),
                  ).then((value) {
                    context.read<BroadCubit>().init();
                  });
                  // context.router.push(EditBoardPage()).then((value) {
                  //   context.read<BroadCubit>().init();
                  // });
                },
                backgroundColor: primaryColor,
                elevation: 3,
                highlightElevation: 5,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Container(
                            //   height: 70,
                            //   alignment: Alignment.center,
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         padding: EdgeInsets.only(left: 16),
                            //         width: 32,
                            //       ),
                            //       Expanded(
                            //         child: Container(
                            //           alignment: Alignment.center,
                            //           margin:
                            //               EdgeInsets.symmetric(vertical: 8),
                            //           child: Text(
                            //             "Kỷ niệm ",
                            //             style: headerTitleStyle,
                            //             //style: subTitleStyle.copyWith(),
                            //             overflow: TextOverflow.ellipsis,
                            //           ),
                            //         ),
                            //       ),
                            //       Container(
                            //         padding: EdgeInsets.only(right: 16),
                            //         alignment: Alignment.center,
                            //         child: SvgPicture.asset(
                            //           "assets/images/icons/icon_search.svg",
                            //           color: greyPrymaryColor,
                            //           width: 24,
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            state.listBoardLocal.length != 0
                                ? Container(
                                    alignment: Alignment.center,
                                    //margin: EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      "Bạn có ${state.listBoardLocal.length} kỷ niệm",
                                      style: subTitleStyle.copyWith(
                                          color: greyPrymaryColor,
                                          fontSize: 13),
                                    ),
                                  )
                                : Container(),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.listBoardLocal.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    // onTap: () {
                                    //   context.router
                                    //       .push(DetailBoardPage(
                                    //           boardModelLocal:
                                    //               state.listBoardLocal[index]))
                                    //       .then((value) {
                                    //     context.read<BroadCubit>().init();
                                    //   });
                                    // },
                                    child: ItemBoard(
                                      context: context,
                                      state: state,
                                      index: index,
                                      // title:
                                      //     state.listBoardLocal[index].title,
                                      // image: state
                                      //     .listBoardLocal[index].listImage,
                                      // time: state.listBoardLocal[index].time
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  AppBar _appBar(
    BuildContext context,
  ) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Color(0xffEFF2F7),
      elevation: 0,
      title: Text(
        "Kỷ niệm ",
        style: headerTitleStyle.copyWith(fontWeight: FontWeight.w600),
        //style: subTitleStyle.copyWith(),
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        // Container(
        //   padding: EdgeInsets.only(right: 16),
        //   alignment: Alignment.center,
        //   child: SvgPicture.asset(
        //     "assets/images/icons/icon_search.svg",
        //     color: greyPrymaryColor,
        //     width: 24,
        //   ),
        // )
      ],
    );
  }

  Widget ItemBoard({
    required int index,
    required BroadState state,
    required BuildContext context,
    // required String title,
    // required DateTime time,
    // Function()? onPress,
    // List<Uint8List>? image,
  }) {
    Duration duration = state.listBoardLocal[index].timeDuration!;
    var hour = duration.inHours;
    var minute = duration.inMinutes % 60;
    var textTime =
        "${hour > 9 ? hour.toString() : "0${hour.toString()}"}:${minute > 9 ? minute.toString() : "0${minute.toString()}"}";
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   alignment: Alignment.center,
          //   margin: EdgeInsets.symmetric(horizontal: 6),
          //   width: 72,
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         height: 10,
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           // unfocus(context)
          //         },
          //         child: Text(
          //           FormatDayShip(state.listBoardLocal[index].time).format4(),
          //           textAlign: TextAlign.center,
          //           style: subTitleStyle.copyWith(
          //               fontWeight: FontWeight.w400,
          //               fontSize: 11,
          //               color: greyPrymaryColor),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 6,
          //       ),
          //       countDay(state.listBoardLocal[index].time) != ""
          //           ? Container(
          //               padding: EdgeInsets.symmetric(
          //                 horizontal: 7,
          //               ),
          //               decoration: BoxDecoration(
          //                   color: greyPrymaryColor,
          //                   borderRadius: BorderRadius.circular(20)),
          //               child: Text(
          //                 countDay(state.listBoardLocal[index].time),
          //                 textAlign: TextAlign.center,
          //                 style: subTitleStyle.copyWith(
          //                     fontSize: 11, color: Colors.white),
          //               ),
          //             )
          //           : Container(),
          //     ],
          //   ),
          // ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailBoardScreen(
                          boardModelLocal: state.listBoardLocal[index])),
                ).then((value) {
                  context.read<BroadCubit>().init();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(14),
                //padding: ,
                margin: EdgeInsets.only(right: 12, left: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.listBoardLocal[index].title,
                      style: titleStyle.copyWith(
                          height: 1.3,
                          wordSpacing: 0.5,
                          letterSpacing: 0.5,
                          fontSize: 15,
                          color: Color(0xff1C2433)),
                    ),
                    state.listBoardLocal[index].listImage != null &&
                            state.listBoardLocal[index].listImage!.length != 0
                        ? Container(
                            height: 60,
                            margin: EdgeInsets.symmetric(vertical: 14),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state
                                    .listBoardLocal[index].listImage!.length,
                                itemBuilder: (context, index2) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShowImageScreen(
                                                    image: state
                                                        .listBoardLocal[index]
                                                        .listImage!)),
                                      );
                                      // MaterialPageRoute(
                                      //     builder: (context) => ShowImageScreen(
                                      //         image: state.listBoardLocal[index]
                                      //             .listImage!));

                                      // context.router.push(ShowImagePage(
                                      //     image: state.listBoardLocal[index]
                                      //         .listImage!));
                                    },
                                    child: Container(
                                      width: 60,
                                      margin: EdgeInsets.only(right: 10),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.memory(
                                          state.listBoardLocal[index]
                                              .listImage![index2],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : Container(
                            height: 20,
                          ),
                    Container(
                      //margin: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Text(
                            FormatTime(state.listBoardLocal[index].time)
                                .format(),
                            style: subTitleStyle.copyWith(
                                fontSize: 13, color: greyPrymaryColor),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: SvgPicture.asset(
                              "assets/images/icons/ellipse.svg",
                              color: greyPrymaryColor,
                              width: 3,
                            ),
                          ),
                          Text(
                            textTime,
                            style: subTitleStyle.copyWith(
                                fontSize: 13, color: greyPrymaryColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String countDay(DateTime time) {
    int timeIn = time.millisecondsSinceEpoch;
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now > timeIn + (1000 * 60 * 60 * 24)) {
      double day = (now - timeIn) / ((1000 * 60 * 60 * 24));
      return (day.toInt()).toString() + " Ngày";
    } else {
      return "";
    }
  }

  Widget imageItem() {
    ImagePicker picker = ImagePicker();
    XFile? image;
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Container(),
      ),
    );
  }
}
