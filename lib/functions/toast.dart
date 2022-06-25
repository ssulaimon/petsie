import 'package:toast/toast.dart';

void showToast({
  required String message,
}) {
  Toast.show(
    message,
    duration: Toast.lengthLong,
    gravity: Toast.bottom,
  );
}
