import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/presentation/widgets/app_scaffold.dart';

class SongDetailsView extends StatelessWidget {
  const SongDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(child: Text('Song details', textAlign: TextAlign.center, style: AppTextStyles.h9())),
      ),
    );
  }
}
