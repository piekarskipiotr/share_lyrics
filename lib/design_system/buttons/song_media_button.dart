import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_lyrics/data/models/song/song_media.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/utils/helpers/helpers.dart';

class SongMediaButton extends StatelessWidget {
  const SongMediaButton({
    required this.songMedia,
    super.key,
  });

  final SongMedia songMedia;

  void _openSongMedia(String url) {
    UrlLauncher.open(url);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          overlayColor: WidgetStateProperty.all(songMedia.provider.buttonBackgroundColor),
          backgroundColor: WidgetStateProperty.all(songMedia.provider.buttonBackgroundColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        onPressed: () => _openSongMedia(songMedia.url),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                songMedia.provider.logo,
                width: 16,
                height: 16,
                colorFilter: songMedia.provider.logoColorFilter,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                songMedia.provider.name,
                style: AppTextStyles.h10(
                  fontWeight: FontWeight.bold,
                  color: songMedia.provider.buttonTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
