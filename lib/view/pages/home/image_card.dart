import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../configs.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    required this.height,
    required this.padding,
    required this.shadow,
  }) : super(key: key);

  final double height;
  final double padding;
  final BoxShadow shadow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: '${ImageUrls.randomCat}?ink=${Random().nextInt(999999)}',
          fit: BoxFit.fill,
          width: height - padding * 2,
          height: height - padding * 2,
        ),
      ),
    );
  }
}