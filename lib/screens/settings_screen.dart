import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            'Appearance',
            [
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: Text(
                      themeProvider.isDarkMode ? 'Dark theme enabled' : 'Light theme enabled'
                    ),
                    value: themeProvider.isDarkMode,
                    onChanged: (_) => themeProvider.toggleTheme(),
                  );
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'Notifications',
            [
              SwitchListTile(
                title: const Text('Push Notifications'),
                subtitle: const Text('Receive alerts and updates'),
                value: true, // TODO: Implement notification settings
                onChanged: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notification settings coming soon!'),
                    ),
                  );
                },
              ),
              SwitchListTile(
                title: const Text('Email Notifications'),
                subtitle: const Text('Receive daily reports via email'),
                value: false, // TODO: Implement email settings
                onChanged: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email settings coming soon!'),
                    ),
                  );
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'Security',
            [
              ListTile(
                title: const Text('Change Password'),
                leading: const Icon(Icons.lock_outline),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password change feature coming soon!'),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Two-Factor Authentication'),
                leading: const Icon(Icons.security),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('2FA feature coming soon!'),
                    ),
                  );
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'About',
            [
              ListTile(
                title: const Text('Version'),
                subtitle: const Text('1.0.0'),
                leading: const Icon(Icons.info_outline),
              ),
              ListTile(
                title: const Text('Terms of Service'),
                leading: const Icon(Icons.description_outlined),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Terms of Service coming soon!'),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Privacy Policy'),
                leading: const Icon(Icons.privacy_tip_outlined),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Privacy Policy coming soon!'),
                    ),
                  );
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'Account',
            [
              ListTile(
                title: const Text('Sign Out'),
                leading: const Icon(Icons.logout),
                textColor: Theme.of(context).colorScheme.error,
                iconColor: Theme.of(context).colorScheme.error,
                onTap: () {
                  // TODO: Implement sign out functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sign out feature coming soon!'),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }
}
