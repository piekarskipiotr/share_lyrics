import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SongImage extends StatelessWidget {
  const SongImage({required this.imageUrl, required this.imageSize, super.key});

  final String? imageUrl;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(imageSize / 2),
      child: SizedBox(
        height: imageSize,
        width: imageSize,
        child: _image(context, imageUrl),
      ),
    );
  }

  Widget _image(BuildContext context, String? imageUrl) {
    if (imageUrl == null) return _errorPlaceholder();

    return Center(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholder: (context, url) {
          return _loadingPlaceholder();
        },
        errorWidget: (context, url, error) {
          return _errorPlaceholder();
        },
      ),
    );
  }

  Widget _loadingPlaceholder() {
    return const AppShimmer();
  }

  Widget _errorPlaceholder() {
    return Container(
      color: AppColors.fieldBg,
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(16),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Icon(
          Icons.library_music_rounded,
          color: AppColors.white.withOpacity(0.2),
        ),
      ),
    );
  }
}
