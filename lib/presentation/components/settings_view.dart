import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/nomoca_urls.dart';
import 'package:nomoca_flutter/presentation/common/launch_url.dart';
import 'package:nomoca_flutter/states/providers/get_version_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = useState('');
    ref.watch(getVersionProvider).maybeWhen(
          data: (result) {
            version.value = result;
          },
          orElse: () {},
        );

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: '',
            tiles: [
              SettingsTile(
                title: '通知設定',
                leading: const Icon(Icons.notifications_active),
                onPressed: (_) => openAppSettings(),
              ),
            ],
          ),
          SettingsSection(
            title: '',
            tiles: [
              SettingsTile(
                title: '利用規約',
                leading: const Icon(Icons.notes),
                onPressed: (_) => launchUrl(NomocaUrls.termsUrl),
              ),
              SettingsTile(
                title: 'プライバシーポリシー',
                leading: const Icon(Icons.privacy_tip),
                onPressed: (_) => launchUrl(NomocaUrls.privacyPolicyUrl),
              ),
            ],
          ),
          SettingsSection(
            title: '',
            tiles: [
              SettingsTile(
                title: 'ログアウト',
                leading: const Icon(Icons.logout),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
          SettingsSection(
            title: '',
            tiles: [
              SettingsTile(
                enabled: false,
                title: 'Version',
                subtitle: version.value,
              ),
            ],
          )
        ],
      ),
    );
  }
}
