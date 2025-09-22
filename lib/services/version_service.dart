import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

/*class VersionService {
  static const String _url =
      "https://unicab.org/uniconecta/version_getdat1.php"; // tu endpoint

  /// Obtiene la versión local desde pubspec.yaml
  static Future<String> getLocalVersion() async {
    final info = await PackageInfo.fromPlatform();
    return "${info.version}+${info.buildNumber}";
  }

  /// Obtiene la versión del servidor
  static Future<String?> getServerVersion() async {
    try {
      final resp = await http.get(Uri.parse(_url));
      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        return data["version"];
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  /// Compara si la versión del servidor es mayor que la local
  static bool isServerGreater(String server, String local) {
    List<int> parseVersion(String v) {
      final cleaned = v.replaceAll("+", ".");
      return cleaned.split(".").map((e) => int.tryParse(e) ?? 0).toList();
    }

    final s = parseVersion(server);
    final l = parseVersion(local);

    for (int i = 0; i < s.length; i++) {
      if (i >= l.length) return true;
      if (s[i] > l[i]) return true;
      if (s[i] < l[i]) return false;
    }
    return false;
  }

  /// Verifica si requiere actualización
  static Future<bool> requiereActualizar() async {
    final local = await getLocalVersion();
    final server = await getServerVersion();
    if (server == null) return false;
    return isServerGreater(server, local);
  }
}*/

class VersionService {
  /// Obtiene la versión más reciente desde un endpoint remoto
  static Future<String?> obtenerVersionRemota() async {
    try {
      final url =
          Uri.parse("https://unicab.org/uniconecta/version_getdat1.php");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["version"]; // ejemplo: { "version": "1.0.1+3" }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Verifica si hay una nueva versión en el servidor
  static Future<bool> hayNuevaVersion() async {
    final versionRemota = await obtenerVersionRemota();
    if (versionRemota == null) return false;

    final info = await PackageInfo.fromPlatform();
    final versionLocal = info.version; // "1.0.1"
    final buildLocal = int.tryParse(info.buildNumber) ?? 0; // 2

    final partesRemota = versionRemota.split('+');
    final versionSemanticaRemota = partesRemota[0]; // "1.0.1"
    final buildRemoto =
        partesRemota.length > 1 ? int.tryParse(partesRemota[1]) ?? 0 : 0;

    if (_compararVersiones(versionSemanticaRemota, versionLocal) > 0) {
      return true;
    }

    if (_compararVersiones(versionSemanticaRemota, versionLocal) == 0 &&
        buildRemoto > buildLocal) {
      return true;
    }

    return false;
  }

  static int _compararVersiones(String v1, String v2) {
    final partes1 = v1.split('.').map(int.parse).toList();
    final partes2 = v2.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      if (partes1[i] > partes2[i]) return 1;
      if (partes1[i] < partes2[i]) return -1;
    }
    return 0;
  }
}
