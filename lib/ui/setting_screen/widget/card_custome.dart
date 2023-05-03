import 'package:btliot/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ButtonCustom extends StatefulWidget {
  ButtonCustom({
    super.key,
    required this.width,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final double width;
  final IconData icon;
  final String title;
  final Function onTap;
  late bool isSelected;
  @override
  _ButtonCustomState createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  bool isStatus = false;
  @override
  Widget build(BuildContext context) {
    //if (widget.disapble == true) widget.isSelected = true;
    return Container(
      padding: EdgeInsets.all(24),
      width: widget.width,
      decoration: BoxDecoration(
        color: Color(0xffEDEDED),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 30,
            offset: Offset(5, 5),
          ),
        ],
      ),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: Color(0xffDADADA),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: Colors.black,
                  size: 32,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SvgPicture.asset(
                  "assets/Star.svg",
                  color: Colors.grey,
                  width: 28,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 22,
          ),
          Text(
            widget.title,
            // textAlign: TextAlign.,
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                height: 1.3,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.visible),
          ),
          SizedBox(
            height: 22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.isSelected == true ? "ON" : "OFF",
                // textAlign: TextAlign.,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.visible),
              ),
              FlutterSwitch(
                activeColor: Colors.black,
                inactiveColor: Color(0xffD6D6D6),
                width: 62,
                height: 33,
                valueFontSize: 0,
                toggleSize: 20.0,
                value: widget.isSelected,
                borderRadius: 30.0,
                padding: 6.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    isStatus = val;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
