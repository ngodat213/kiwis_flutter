import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kiwis_flutter/core/constants/app.value.dart';

class CustomMarker extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool isCurrentLocation;

  const CustomMarker({
    Key? key,
    this.imageUrl,
    this.size = 40,
    this.isCurrentLocation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: isCurrentLocation
            ? CachedNetworkImage(
                imageUrl: imageUrl ?? AppValues.defaultAvatar,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.asset(
                  AppValues.defaultAvatar,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(
                Icons.location_on,
                color: Colors.red,
                size: size * 0.8,
              ),
      ),
    );
  }
}
