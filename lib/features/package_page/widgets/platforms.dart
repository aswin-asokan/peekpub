import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Define platform enum
enum PlatformType { android, ios, web, windows, macos, linux }

class Platforms extends StatelessWidget {
  final PlatformType platform;

  const Platforms({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    final Map<PlatformType, String> platformPaths = {
      PlatformType.android: "assets/icons/Android.svg",
      PlatformType.ios: "assets/icons/Apple.svg",
      PlatformType.web: "assets/icons/chrome.svg",
      PlatformType.windows: "assets/icons/Windows.svg",
      PlatformType.macos: "assets/icons/MacOS.svg",
      PlatformType.linux: "assets/icons/Ubuntu-logo.svg",
    };

    final Map<PlatformType, Color> platformColors = {
      PlatformType.android: Colors.green,
      PlatformType.ios: Colors.indigo,
      PlatformType.web: Colors.redAccent,
      PlatformType.windows: Colors.blueAccent,
      PlatformType.macos: Colors.black,
      PlatformType.linux: Colors.deepOrange,
    };

    final String path = platformPaths[platform] ?? "assets/icons/Android.svg";
    final Color color = platformColors[platform] ?? Colors.white;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SvgPicture.asset(
        path,
        height: 25,
        width: 25,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }
}
