import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  String tohhmmddMMyyyy() {
    final f = DateFormat('hh:mm dd/MM/yyyy');
    var dateUtc = toUtc();
    var dateLocal = dateUtc.toLocal();
    return f.format(dateLocal);
  }

  String toHHmm() {
    final f = DateFormat('HH:mm');
    var dateUtc = toUtc();
    var dateLocal = dateUtc.toLocal();
    return f.format(dateLocal);
  }

  String toddMMyyyy() {
    final f = DateFormat('dd/MM/yyyy');
    var dateUtc = toUtc();
    var dateLocal = dateUtc.toLocal();
    return f.format(dateLocal);
  }

  String toyyyy() {
    final f = DateFormat('yyyy');
    return f.format(this);
  }

  String toLocalTime() {
    final f = DateFormat('dd/MM/yyyy');
    var dateUtc = toUtc();
    var dateLocal = dateUtc.toLocal();
    return f.format(dateLocal);
  }

  String toEEEMMMd() {
    // final f = DateFormat('EEE, MMM d');
    final f = DateFormat.MMMEd('vi_VN');
    var dateUtc = toUtc();
    var dateLocal = dateUtc.toLocal();
    return f.format(dateLocal);
  }

  String toEEEMMMdY() {
    // final f = DateFormat('EEE, MMM d');
    final f = DateFormat.yMMMEd();
    var dateUtc = toUtc();
    var dateLocal = dateUtc.toLocal();
    return f.format(dateLocal);
  }
}
