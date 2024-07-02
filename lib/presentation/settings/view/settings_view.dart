import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_lyrics/data/constants.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/presentation/settings/bloc/settings_bloc.dart';
import 'package:share_lyrics/presentation/settings/widgets/settings_widgets.dart';
import 'package:share_lyrics/presentation/widgets/app_scaffold.dart';
import 'package:share_lyrics/utils/extensions/extensions.dart';
import 'package:share_lyrics/utils/helpers/helpers.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  void _navigateBack() {
    context.pop();
  }

  void _navigateToTermsOfService() {
    UrlLauncher.open(termsOfServiceUrl);
  }

  void _navigateToPrivacyPolicy() {
    UrlLauncher.open(privacyPolicyUrl);
  }

  void _deleteAccount() {
    final l10n = context.l10n;
    AppActionDialog.show(
      title: l10n.account_delete_confirmation_title,
      subtitle: l10n.account_delete_confirmation_description,
      primaryText: l10n.delete,
      secondaryText: l10n.cancel,
      onPrimaryPressed: () {
        context.read<SettingsBloc>().add(const DeleteAccount());
      },
      onSecondaryPressed: () {
        context.pop();
      },
      context: context,
    );
  }

  void _signOut() {
    context.read<SettingsBloc>().add(const SignOut());
  }

  String? _getProviderName(UserInfo? userInfo) {
    final providerId = userInfo?.providerId;
    return providerId?.replaceAll('.com', '').toTitleCase();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        title: Text(l10n.settings, style: AppTextStyles.h7()),
        leading: IconButton(
          onPressed: _navigateBack,
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final user = state.user;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                SettingsSection(
                  label: l10n.general,
                  children: [
                    SettingsSectionItem(
                      label: l10n.email,
                      value: user?.email ?? '-',
                    ),
                    SettingsSectionItem(
                      label: l10n.signed_method,
                      value: _getProviderName(user?.providerData.firstOrNull) ?? '-',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsSection(
                  label: l10n.others,
                  children: [
                    SettingsSectionItem(
                      label: l10n.terms_of_service,
                      value: Icons.link_rounded,
                      onTap: _navigateToTermsOfService,
                    ),
                    SettingsSectionItem(
                      label: l10n.privacy_policy,
                      value: Icons.link_rounded,
                      onTap: _navigateToPrivacyPolicy,
                    ),
                    SettingsSectionItem(
                      label: l10n.delete_account,
                      onTap: _deleteAccount,
                      isDanger: true,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: _signOut,
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            l10n.sign_out,
            textAlign: TextAlign.center,
            style: AppTextStyles.h8(fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
