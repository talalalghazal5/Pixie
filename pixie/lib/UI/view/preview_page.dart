import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixie/controllers/color_controller.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/services/home_page_service.dart';
import 'package:pixie/services/permssion_service.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key, required this.photo});
  final Photo photo;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    print(ColorController().convertColor(widget.photo.avgColor));
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Hero(
          tag: widget.photo.src.portrait!,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CachedNetworkImage(
              imageUrl: widget.photo.src.original!,
              progressIndicatorBuilder: (context, url, progress) => Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color(
                    ColorController().convertColor(widget.photo.avgColor),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error occured while getting the image',
                    style: TextStyle(fontFamily: 'space'),
                  ),
                ],
              ),
              placeholderFadeInDuration: const Duration(milliseconds: 0),
              fadeInCurve: Curves.linear,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white38),
                  gradient: const LinearGradient(
                    colors: [Colors.white30, Colors.white60],
                    transform: GradientRotation(45),
                  ),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
            )),
        Positioned(
          bottom: 0,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.1, 1],
                      colors: [Colors.black, Colors.black.withOpacity(0)],
                    ).createShader(rect);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      transform: GradientRotation(-pi / 2),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Taken by:',
                      style:
                          TextStyle(color: Colors.white70, fontFamily: 'space'),
                    ),
                    Text(
                      widget.photo.photographer,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'spaceBold',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 10,
            right: 10,
            child: IconButton(
                onPressed: () async {
                  var status = await PermissionService().requestPermissions();
                  if (status == PermissionStatus.granted) {
                    HomePageService().downloadPhoto(
                      imageId: widget.photo.id,
                      imageUrl:
                          widget.photo.src.original!,
                      context: context.mounted ? context : context,
                    );
                    
                  }
                },
                icon: const LineIcon(
                  LineIcons.horizontalEllipsis,
                  color: Colors.white,
                  size: 30,
                )))
      ]),
    );
  }
}
