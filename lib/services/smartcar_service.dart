import 'package:url_launcher/url_launcher.dart';

class SmartcarService {
  static const String backendUrl = 'https://backend-volguard.vercel.app';

  Future<void> loginWithSmartcar() async {
    final loginUrl = '$backendUrl/login';
    if (await canLaunchUrl(Uri.parse(loginUrl))) {
      await launchUrl(Uri.parse(loginUrl));
    } else {
      throw Exception('No se pudo abrir la URL');
    }
  }
}
