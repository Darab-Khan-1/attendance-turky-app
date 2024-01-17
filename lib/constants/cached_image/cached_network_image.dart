import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import '../colors.dart';

class cachedImage extends StatelessWidget {
  final String? imageURL;
  const cachedImage({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL!,
      height: 80,
      width: 80,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              // colorFilter:
              // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
          ),
        ),
      ),
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kErrorColor.withOpacity(0.2),
          ),
          child: Icon(Icons.error,color: kErrorColor.withOpacity(0.4))),
    );
  }
}
