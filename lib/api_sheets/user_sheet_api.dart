import 'package:gsheets/gsheets.dart';
import 'package:apply_job/model/user.dart';

class UserSheetApi {
  static const _credentials = r''' 
{
  "type": "service_account",
  "project_id": "gsheets-375316",
  "private_key_id": "733838dc578990e179fdfc812627e0b960b28362",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDLwskj4+THQTme\nl8ol1rt4IlyTCQcaDsRIHhnpkxsZdM27NSCTuUOPW2+TMBYZ9nXVJrf9sOJramMr\n8LM3Yi1WOjhY11y5v2w4LDsEmcSfB07LzW7WEDvaN8L+PEAR/ooGaMcvaL5qjNJa\nOiQlXz+ADzoayvK6LSc0dZLnrS6ab4i82hPfGmxipLaaZD2PriHqkZamC762sw2Y\nh5Wmjyw+STjBYb4G6FcroBviPvlptDKioUQwih1DZVU0QffDwrSlDpQzlpdL0one\nyCKYCJHjXu3syyvTvg2Lwnx8Wz4Hk6CyYibF+v9jmvphqat+54K4Zh2BkYC7RaeC\nKyl2Ns6xAgMBAAECggEAVJoEv8UguWaokOO/SCS3Y/MIcvhdnYEiGDt/UM8GgnRP\n83nkk9Fpbr1tPzTJCHCfjifsXwYxjJ34nUbscoNuBY5Y1PJeirUjLtOWkZty2wDC\nw7YBXhoRb9KVQNAtXgtMrcqVYWbhIQZlVJctaOL6T6aC3psDWy/iRlLG8zCh1/bX\nPYADDYO5e03jNKkF6EIB8xzxROc1DgKBMrXNagdOYTHXnEJFLWNiGIToLoYyNCq4\ncI+HyRBnCXRggQ+WUiu+6dPJpdtWD01WxK3ONWwAP7KILhEKT7mAGBwldXP0FD5k\n+ovx/0Ul3ULjZZDmL70z32sRU+xjKP6FB9iqMBKOfQKBgQD0S4mWa06E9sgxfB+J\nKQ35uvvp5lxziPtBbaEjtQeDYwyN7+NQbJUUai42UvyQMSsfilEinwexHq4JLotS\nWatUOPvko401IW99ptT06SaqLKg5Hk+vMOGk+cp0K/GQQF6uB7fHIUfqHnMUF6RL\ndynNHE0J/ecjHyQUFThIRuHJ6wKBgQDVhhDlfXEWx94m9U3Qz25b0zV79eX5Hs0T\njZvF35xCWhnqhMhQbCyGDTxDxrmmaoyDH1AUsVW3AP/ez4NqjRQyKtASrcjm7yG/\nFSArGmxAlYsVLRPMVU2zageiiuXxjR4c2j4Gw6tPk6rom8+e0B4WlMd0hRa5y35s\nPOyJ0M2m0wKBgCvqLEiK76l9R02F95FLfQSodUJ9s57dP/VqBK6Li1c2Bfq55c3+\nRupNkBMZ5ebxv8PCtIUZu2M+laB26nqaPe888yMNt4OWiBk5VUzVYKr0riTeawqe\nKeHjOV6ay6jXuW1lW8cDF49he+Rfv5wFRtFlRgAG0XcB0RV/Hwf3Hf2TAoGAHr/l\n4wbDqII0Dew5vp6AyByMkUOCUPQMmIpGKqLfP/b10H460sohR1TUnvYZekvR3Hg/\n8hrvuyEbuByuUkPq6qabvHTmf8tkUr5aGZr+h/aBRxVsynpmbDYSz2etYbHu6jzL\nvfGj1Bvx+vmlVrul+Z6HctJPyYXyuOe1MMuvMh0CgYBtzdt6E5P0Wx6lJ2HUtgjj\nDs4x1ank4J+/z1dzCO7WTr3/ihrZnQZWX6PLOzc6KjhGl/e8qL1iPHP3gQ2UZZBv\nTxHJVI1B428HdAieeROlFd5YIirqUUEkHzn4komxh6Pnpu7Xr2+Jp64W0um6GW2k\nkNvLmxURAfbjR9IeEkNIHA==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-375316.iam.gserviceaccount.com",
  "client_id": "107155947346815808629",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-375316.iam.gserviceaccount.com"
}


  ''';
  static final _spreadsheetId = '12YqObMianSZMHBfHi1fo4FIcIez7Ckq1ne-ve1VaogM';
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
