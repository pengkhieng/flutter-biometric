class AssetHelper {
  static String svgPath(String assetName) {
    const svgsPath = 'assets/svgs';
    final path = '$svgsPath/$assetName';
    return path;
  }
}

class SvgAsset {
  static final security_fill_icon = _getSvgPath('security_fill_icon.svg');

  static String _getSvgPath(String svgName) => AssetHelper.svgPath(svgName);
}
