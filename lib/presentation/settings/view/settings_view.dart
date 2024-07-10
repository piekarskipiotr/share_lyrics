import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_lyrics/data/constants.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/presentation/settings/bloc/settings_bloc.dart';
import 'package:share_lyrics/presentation/settings/widgets/settings_widgets.dart';
import 'package:share_lyrics/design_system/scaffolds/app_scaffold.dart';
import 'package:share_lyrics/utils/extensions/extensions.dart';
import 'package:share_lyrics/utils/helpers/helpers.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  void _navigateToTermsOfService() {
    UrlLauncher.open(termsOfServiceUrl);
  }

  void _navigateToPrivacyPolicy() {
    UrlLauncher.open(privacyPolicyUrl);
  }

  // TODO(piotr): call this function like "show delete dialog" & move bloc call to function _deleteAccount
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
      onSecondaryPressed: context.pop,
      isPrimaryDestructive: true,
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
    // TODO(piotr): think about re-building / improving UI
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final user = state.user;
        final isSigningOut = state.status == StateStatus.loading;
        return AppScaffold(
          appBar: AppBar(
            backgroundColor: AppColors.transparent,
            title: Text(l10n.settings, style: AppTextStyles.h7()),
            leading: IconButton(
              onPressed: context.pop,
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
            ),
          ),
          body: SingleChildScrollView(
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
                    // TODO(piotr): improve color of danger and improve UI of dialog
                    SettingsSectionItem(
                      label: l10n.delete_account,
                      onTap: _deleteAccount,
                      isDanger: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: AppTextButton(
              label: l10n.sign_out,
              onPressed: _signOut,
              textColor: AppColors.primary,
              isLoading: isSigningOut,
            ),
          ),
        );
      },
    );
  }
}
