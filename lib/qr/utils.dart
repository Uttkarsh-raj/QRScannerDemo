import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future openPay({required String pay}) async {
    // final url = 'upi:$pay';
    await _launchUrl(pay);
  }

  static _launchUrl(pay) async {
    if (await canLaunchUrl(pay)) {
      launchUrl(pay);
    }
  }
}
