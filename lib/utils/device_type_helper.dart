import 'package:device_info_plus/device_info_plus.dart';

Future<String> detectDeviceType() async {
  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;

  final model = androidInfo.model?.toLowerCase() ?? '';
  final device = androidInfo.device?.toLowerCase() ?? '';
  final manufacturer = androidInfo.manufacturer?.toLowerCase() ?? '';
  final product = androidInfo.product?.toLowerCase() ?? '';

  print('ℹ️ model: $model');
  print('ℹ️ device: $device');
  print('ℹ️ manufacturer: $manufacturer');
  print('ℹ️ product: $product');

  if (model.contains('watch') || device.contains('watch') || manufacturer.contains('wear') || product.contains('wear')) {
    print('✅ Detectado deviceType: wear');
    return 'wear';
  }
  if (model.contains('tv') || device.contains('tv') || manufacturer.contains('tv') || product.contains('tv')) {
    print('✅ Detectado deviceType: tv');
    return 'tv';
  }
  print('✅ Detectado deviceType: phone');
  return 'phone';
}
