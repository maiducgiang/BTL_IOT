import 'dart:ui';

extension DefineColor on int {
  Color getColor() {
    if (this < 0) return Color(0xff0047AA);
    if (this < 5) return Color(0xff0265c9);
    if (this < 10) return Color(0xff0277DB);
    if (this < 15) return Color(0xff0289EE);
    if (this < 20) return Color(0xff0097fc);
    if (this < 25) return Color(0xff5fb6fd);
    if (this < 30) return Color(0xff8ecbfe);
    if (this < 35) return Color(0xffffca7f);
    if (this < 40) return Color(0xffffb44c);
    if (this < 45) return Color(0xffffa425);
    if (this < 50) return Color(0xfffe9400);
    return Color(0xfffa8801);
  }
}
