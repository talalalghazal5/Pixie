import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String langValue = 'ar';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Settings',
            style: TextStyle(
                fontFamily: 'space', fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: const Text(
              'Dark mode',
              style: TextStyle(fontFamily: 'space'),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            // tileColor: Colors.black12.withAlpha(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
            thickness: 0.5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              // color: Colors.black12.withAlpha(30),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Language',
                  style: TextStyle(fontFamily: 'space', fontSize: 15),
                ),
                DropdownButton(
                  value: langValue,
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'en',
                      child: Text('English'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'ar',
                      child: Text('Arabic'),
                    ),
                  ],
                  underline: Container(
                    color: Colors.black,
                    height: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  style:
                      const TextStyle(fontFamily: 'space', color: Colors.black),
                  onChanged: (value) {
                    setState(() {
                      langValue = value!;
                    });
                  },
                )
              ],
            ),
          ),
          const Spacer(flex: 10,),
          const Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Made by: Eng. Talal Alghazal', style: TextStyle(fontFamily: 'space', fontSize: 15, color: Colors.grey),),
                SizedBox(height: 6,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    FaIcon(FontAwesomeIcons.copyright, color: Colors.grey, size: 15,),
                    SizedBox(width: 5,),
                    Text('Copyrights reserved', style: TextStyle(fontFamily: 'space', fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Powered by',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/images/pexels_logo_black.png',
                  width: 60,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
