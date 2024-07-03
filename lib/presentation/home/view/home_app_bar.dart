import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/presentation/home/bloc/home_bloc.dart';
import 'package:share_lyrics/router/app_router.dart';
import 'package:share_lyrics/router/app_router_navigation.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  final _searchController = TextEditingController();

  void _clearSearchField() {
    _searchController.clear();
    context.read<HomeBloc>().add(const ChangeSearchPhrase(phrase: ''));
  }

  void _changeSearchPhrase(String phrase) {
    context.read<HomeBloc>().add(ChangeSearchPhrase(phrase: phrase));
  }

  void _navigateToSettings() {
    context.read<AppRouter>().showSettings();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SliverAppBar(
      backgroundColor: AppColors.transparent,
      leadingWidth: 200,
      leading: Center(
        child: RichText(
          text: TextSpan(
            style: AppTextStyles.h6(fontWeight: FontWeight.w900),
            children: [
              TextSpan(text: l10n.app_name_pt_1),
              TextSpan(
                text: l10n.app_name_pt_2,
                style: AppTextStyles.h6(fontWeight: FontWeight.w900, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: _navigateToSettings,
          icon: const Icon(Icons.settings_rounded, color: AppColors.white),
        ),
      ],
      bottom: _searchTextField(),
    );
  }

  PreferredSize _searchTextField() {
    final l10n = context.l10n;
    return PreferredSize(
      preferredSize: const Size(double.infinity, 72),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: AppTextFormField(
          label: l10n.search_hint,
          prefixIcon: Icons.search_rounded,
          suffixWidget: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final showSearch = state.showSearch;
              if (!showSearch) return const SizedBox();

              return GestureDetector(
                onTap: _clearSearchField,
                child: Text(
                  l10n.cancel,
                  style: AppTextStyles.h10(
                    fontWeight: FontWeight.bold,
                    color: AppColors.iosBlueText,
                  ),
                ),
              );
            },
          ),
          textController: _searchController,
          onChange: _changeSearchPhrase,
        ),
      ),
    );
  }
}
