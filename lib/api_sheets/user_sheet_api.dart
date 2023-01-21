import 'package:gsheets/gsheets.dart';
import 'package:apply_job/model/user.dart';

class UserSheetApi {
  // get it from https://console.cloud.google.com
  static const _credentials = r''' 
{
  your API 
}


  ''';
  static final _spreadsheetId =
      'your ID'; // get it from https://console.cloud.google.com
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  // creat init
  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'user');

      final firstRow =
          UserFields.getFields(); // set title for first row in Excel
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print("İnit Error: $e");
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;
    _userSheet!.values.map.appendRows(rowList);
  }
}
