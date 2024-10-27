import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:studentoglasi_admin/models/PrijaveStipendija/prijave_stipendija.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class PrijaveStipendijaProvider extends BaseProvider<PrijaveStipendija> {
  PrijaveStipendijaProvider() : super('PrijaveStipendija');

  @override
  PrijaveStipendija fromJson(data) {
    return PrijaveStipendija.fromJson(data);
  }

  Future<File?> downloadReport(int stipendijaId) async {
    try {
      Dio dio = Dio();

      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      String filePath = "${directory?.path}/ScholarshipReport_$stipendijaId.pdf";

      final url = '${baseUrl}${endPoint}/report/download/$stipendijaId';

      Response response = await dio.download(
        url, 
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print("Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
        options: Options(
          headers: createHeaders(),
        ),
      );

      if (response.statusCode == 200) {
        print("PDF downloaded successfully and saved to $filePath");
        return File(filePath);
      } else {
        print("Failed to download the PDF. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error during file download: $e");
      return null;
    }
  }
  Future<void> printReport(int stipendijaId) async {
    try {
      File? pdfFile = await downloadReport(stipendijaId);

      if (pdfFile != null) {
        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async {
            return pdfFile.readAsBytesSync();
          },
        );
      } else {
        print("PDF file not found");
      }
    } catch (e) {
      print("Error while printing: $e");
    }
  }
}
