import 'package:pdf/widgets.dart' as pw;

pw.TableRow buildTableRow(String header, List<String> values) {
  return pw.TableRow(
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(2),
        child: pw.Text(
          header,
          style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
        ),
      ),
      for (var value in values)
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Text(value, style: const pw.TextStyle(fontSize: 10)),
          ),
        )
    ],
  );
}
