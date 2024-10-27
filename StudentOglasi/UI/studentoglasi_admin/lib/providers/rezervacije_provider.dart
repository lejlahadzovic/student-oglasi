import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:studentoglasi_admin/models/Rezervacije/rezervacije.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class RezervacijeProvider extends BaseProvider<Rezervacije> {
  RezervacijeProvider() : super('Rezervacije');
 @override
  Rezervacije fromJson(data) {
    // TODO: implement fromJson
    return Rezervacije.fromJson(data);
  }
Future<File?> downloadReport(int smjestajId, int? smjestajnaJedinicaId, DateTime? startDate, DateTime? endDate) async {
  try {
    Dio dio = Dio();
    Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String filePath = "${directory?.path}/ReservationsReport_${smjestajId}.pdf";
    final url = '${baseUrl}${endPoint}/report/download/${smjestajId}';

    Map<String, dynamic> queryParams = {
      'smjestajId': smjestajId.toString(),
      if (smjestajnaJedinicaId != null) 'smjestajnaJedinicaId': smjestajnaJedinicaId.toString(),
      if (startDate != null) 'pocetniDatum': startDate.toIso8601String(),
      if (endDate != null) 'krajnjiDatum': endDate.toIso8601String(),
    };

    Response response = await dio.download(
      url,
      filePath,
      queryParameters: queryParams,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print("Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
        }
      },
      options: Options(headers: createHeaders()),
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
  Future<void> printReport(int smjestajId, int? smjestajnaJedinicaId, DateTime? startDate, DateTime? endDate) async {
    try {
      File? pdfFile = await downloadReport(smjestajId,smjestajnaJedinicaId,startDate,endDate);

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