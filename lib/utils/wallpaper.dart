import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

class WallpaperUtils {
  static setWallPaper(String path) {
    final pathPtr = TEXT(path).cast<Utf16>();
    SystemParametersInfo(20, 0, pathPtr, 0);
  }
}
