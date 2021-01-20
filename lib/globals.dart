import 'dart:ui';

Color bodyColor = HexColor.fromHex('#4E4B66');
Color titleColor = HexColor.fromHex('#14142B');
Color primaryColor = HexColor.fromHex('#FF6D59');
Color whiteColor = HexColor.fromHex('#F7F7FC');
Color greyColor = HexColor.fromHex('#A0A3BD');
Color fillGreyColor = HexColor.fromHex('#EFF0F6');
Color brownColor = HexColor.fromHex('#86512F');
Color greyColor_2 = HexColor.fromHex('#767676');
Color beigeColor = HexColor.fromHex('#AE9C8B');
Color meatColor = HexColor.fromHex('#FCCEB2');

String allPublishingsUrl = 'http://192.168.1.42:3000/publishings/';
int selectedIndex = 0;
bool isDrawerOpen = false;

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
