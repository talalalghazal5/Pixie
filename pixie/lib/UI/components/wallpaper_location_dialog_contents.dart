import 'package:flutter/material.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class WallpaperLocationDialogContents extends StatefulWidget {
  const WallpaperLocationDialogContents(
      {super.key, required this.onValueChanged});
  final Function(int) onValueChanged;
  @override
  State<WallpaperLocationDialogContents> createState() =>
      _WallpaperLocationDialogContentsState();
}

class _WallpaperLocationDialogContentsState
    extends State<WallpaperLocationDialogContents> {
  int selectedLocation = WallpaperManagerPlus.homeScreen;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RadioListTile<int>(
          title: const Text(
            'Home screen',
            style: TextStyle(fontFamily: 'space'),
          ),
          value: WallpaperManagerPlus.homeScreen,
          groupValue: selectedLocation,
          onChanged: (value) => setState(() {
            selectedLocation = value!;
            widget.onValueChanged(value);
          }),
        ),
        RadioListTile<int>(
          title: const Text(
            'Lock screen',
            style: TextStyle(fontFamily: 'space'),
          ),
          value: WallpaperManagerPlus.lockScreen,
          groupValue: selectedLocation,
          onChanged: (value) => setState(() {
            selectedLocation = value!;
            widget.onValueChanged(value);
          }),
        ),
        RadioListTile<int>(
          title: const Text(
            'Both screens',
            style: TextStyle(fontFamily: 'space'),
          ),
          value: WallpaperManagerPlus.bothScreens,
          groupValue: selectedLocation,
          onChanged: (value) => setState(() {
            selectedLocation = value!;
            widget.onValueChanged(value);
          }),
        ),
      ],
    );
  }
}
