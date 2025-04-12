import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../logger.dart';

class AppUtils {
  static Future<ImageProvider<Object>> xFileToImage(XFile xFile) async {
    final Uint8List bytes = await xFile.readAsBytes();
    return Image.memory(bytes).image;
  }

  static bool isImage(String s) {
    return ["png", "jpeg", "bmp", "jpg", "webp"].any(s.toLowerCase().contains);
  }

  static String getDateTimeKey() {
    DateTime today = DateTime.now();
    DateFormat df = DateFormat('yyyyMMddHHmmssSSS');
    return df.format(today);
  }

  static int convertTime(String duration) {
    RegExp regex = new RegExp(r'(\d+)');
    List<String> a =
        regex.allMatches(duration).map((e) => e.group(0)!).toList();

    if (duration.indexOf('M') >= 0 &&
        duration.indexOf('H') == -1 &&
        duration.indexOf('S') == -1) {
      a = ["0", a[0], "0"];
    }

    if (duration.indexOf('H') >= 0 && duration.indexOf('M') == -1) {
      a = [a[0], "0", a[1]];
    }
    if (duration.indexOf('H') >= 0 &&
        duration.indexOf('M') == -1 &&
        duration.indexOf('S') == -1) {
      a = [a[0], "0", "0"];
    }

    int seconds = 0;

    if (a.length == 3) {
      seconds = seconds + int.parse(a[0]) * 3600;
      seconds = seconds + int.parse(a[1]) * 60;
      seconds = seconds + int.parse(a[2]);
    }

    if (a.length == 2) {
      seconds = seconds + int.parse(a[0]) * 60;
      seconds = seconds + int.parse(a[1]);
    }

    if (a.length == 1) {
      seconds = seconds + int.parse(a[0]);
    }
    return seconds;
  }

  static String formatDate({required DateTime dateTime}) {
    return DateFormat("HH:mm").format(dateTime);
  }

  static Color randomColor() {
    return Color(Random().nextInt(0xffffffff));
  }

  static Future<ImageSet?> pickerImage({required ImagePicker picker}) async {
    try {
      XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxHeight: 800,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        if (!AppUtils.isImage(p.extension(pickedFile.name))) {
          return null;
        }

        ImageProvider<Object> image = await AppUtils.xFileToImage(pickedFile);

        return ImageSet(image, pickedFile);
      }
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

  static String formattedTime2(int time) // --> time in form of seconds
  {
    final int hour = (time / 3600).floor();
    final int minute = ((time / 3600 - hour) * 60).floor();
    final int second = ((((time / 3600 - hour) * 60) - minute) * 60).floor();

    final String setTime = [
      if (hour > 0) hour.toString().padLeft(2, "0"),
      minute.toString().padLeft(2, "0"),
      second.toString().padLeft(2, '0'),
    ].join(':');
    return setTime;
  }

  static Future<XFile> uint8ListToXFile(
    Uint8List data, {
    String fileName = "temp.png",
  }) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(data);
    return XFile(file.path);
  }
}

class ImageSet {
  ImageProvider<Object>? imageProvider;
  XFile? imageFile;

  ImageSet(this.imageProvider, this.imageFile);
}
