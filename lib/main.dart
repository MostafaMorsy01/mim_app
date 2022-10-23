import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:device_preview/device_preview.dart';
import 'package:meem_app/meem_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: false,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => Phoenix(
        child: const MeemApp(),
      ),
    ),
  );
}
