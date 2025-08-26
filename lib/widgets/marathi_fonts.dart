import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:pdf/widgets.dart' as pw;

class MarathiFonts {
  static Future<pw.Font> getMarathiFont() async {
    final fontData = await rootBundle
        .load("fonts/NotoSansDevanagari-Regular.ttf")
        .then((f) => f.buffer.asByteData());
    return pw.Font.ttf(fontData.buffer.asByteData());
  }
}
