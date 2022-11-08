import 'package:btliot/const.dart';
import 'package:flutter/material.dart';

class ControlButton extends StatefulWidget {
  const ControlButton(
      {super.key,
      required this.size,
      required this.icon,
      required this.title,
      this.disapble,
      required this.onTap});

  final Size size;
  final IconData icon;
  final String title;
  final Function onTap;
  final bool? disapble;
  @override
  _ControlButtonState createState() => _ControlButtonState();
}

class _ControlButtonState extends State<ControlButton> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    if (widget.disapble == true) isSelected = true;
    return GestureDetector(
      onTap: (() {}),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              widget.onTap.call();
              if (widget.disapble == true) {
              } else if (widget.disapble != true) {
                setState(() {
                  isSelected = !isSelected;
                });
              }
            },
            child: Container(
              height: widget.size.height * 0.105,
              width: widget.size.width * 0.21,
              decoration: BoxDecoration(
                color: (isSelected ? kOrangeColor : Colors.white),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? kOrangeColor.withOpacity(0.5)
                        : Colors.grey.shade200,
                    blurRadius: 30,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: Icon(
                widget.icon,
                color:
                    isSelected ? Colors.white : kDarkGreyColor.withOpacity(0.6),
                size: 45,
              ),
            ),
          ),
          SizedBox(height: widget.size.height * 0.005),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kDarkGreyColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
