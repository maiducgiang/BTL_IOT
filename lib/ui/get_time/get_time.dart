import 'package:btliot/const.dart';
import 'package:btliot/extension/date_formatting.dart';
import 'package:btliot/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class GetTime extends StatefulWidget {
  const GetTime({Key? key}) : super(key: key);

  @override
  State<GetTime> createState() => _GetTimeState();
}

class _GetTimeState extends State<GetTime> {
  late DateTime? startDate;
  late DateTime? endDate;
  late TextEditingController startDateController = TextEditingController();
  late TextEditingController endDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chọn giờ bật tắt tự động',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        leading: InkWell(
          onTap: (() {
            Navigator.pop(context);
          }),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: kDarkGreyColor,
          ),
        ),
        backgroundColor: kBgColor,
        elevation: 0,
      ),
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: false,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2050, 1, 1, 0, 0),
                      theme: const DatePickerTheme(
                          headerColor: Colors.white,
                          backgroundColor: Colors.white,
                          itemStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {
                    setState(() {
                      startDate = date;
                      startDateController =
                          TextEditingController(text: date.toddMMyyyy());
                    });
                  },
                      onConfirm: (date) {},
                      currentTime: DateTime.now(),
                      locale: LocaleType.vi);
                },
                child: TextFormFieldInput(
                    enable: false,
                    controller: startDateController,
                    hinText: "Ngày tháng năm sinh"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
