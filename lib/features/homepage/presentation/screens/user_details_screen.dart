import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matamix_task/core/theme/app_colors.dart';
import 'package:matamix_task/features/homepage/data/models/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailsScreen({
    super.key,
    required this.user,
  });

  List<Color> _getAvatarGradient(int id) {
    final gradients = [
      [const Color(0xFF5B5FEF), const Color(0xFF868CFF)],
      [const Color(0xFF6C5CE7), const Color(0xFFA29BFE)],
      [const Color(0xFF00B894), const Color(0xFF55EFC4)],
      [const Color(0xFF0984E3), const Color(0xFF74B9FF)],
      [const Color(0xFFE17055), const Color(0xFFFAB1A0)],
      [const Color(0xFFD63031), const Color(0xFFFF7675)],
      [const Color(0xFFE84393), const Color(0xFFFD79A8)],
    ];
    return gradients[id % gradients.length];
  }

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.textPrimary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final avatarColors = _getAvatarGradient(user.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: AppColors.textPrimary,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'User Details',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            /// Profile Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: avatarColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: avatarColors[0].withValues(alpha: 0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        user.initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '@${user.username}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F1F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'ID: #${user.id}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Contact Info Section
            _buildSection(
              title: 'Contact Information',
              icon: Icons.contact_mail_rounded,
              children: [
                _buildInfoTile(
                  context,
                  icon: Icons.email_outlined,
                  label: 'Email Address',
                  value: user.email,
                  onCopy: () => _copyToClipboard(context, user.email, 'Email'),
                ),
                const Divider(height: 1, color: AppColors.border),
                _buildInfoTile(
                  context,
                  icon: Icons.phone_outlined,
                  label: 'Phone Number',
                  value: user.phone,
                  onCopy: () => _copyToClipboard(context, user.phone, 'Phone'),
                ),
                const Divider(height: 1, color: AppColors.border),
                _buildInfoTile(
                  context,
                  icon: Icons.language_rounded,
                  label: 'Website',
                  value: user.website,
                  onCopy: () => _copyToClipboard(context, user.website, 'Website'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Address Section
            _buildSection(
              title: 'Address & Location',
              icon: Icons.location_on_rounded,
              children: [
                _buildInfoTile(
                  context,
                  icon: Icons.home_outlined,
                  label: 'Street',
                  value: '${user.address.street}, ${user.address.suite}',
                ),
                const Divider(height: 1, color: AppColors.border),
                _buildInfoTile(
                  context,
                  icon: Icons.location_city_rounded,
                  label: 'City & Zipcode',
                  value: '${user.address.city} - ${user.address.zipcode}',
                ),
                if (user.address.geo.lat.isNotEmpty) ...[
                  const Divider(height: 1, color: AppColors.border),
                  _buildInfoTile(
                    context,
                    icon: Icons.explore_outlined,
                    label: 'Coordinates (Lat, Lng)',
                    value: '${user.address.geo.lat}, ${user.address.geo.lng}',
                  ),
                ],
              ],
            ),

            const SizedBox(height: 20),

            /// Company Section
            _buildSection(
              title: 'Company & Work',
              icon: Icons.business_center_rounded,
              children: [
                _buildInfoTile(
                  context,
                  icon: Icons.corporate_fare_rounded,
                  label: 'Company Name',
                  value: user.company.name,
                ),
                if (user.company.catchPhrase.isNotEmpty) ...[
                  const Divider(height: 1, color: AppColors.border),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.format_quote_rounded,
                                size: 18,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Catchphrase',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '"${user.company.catchPhrase}"',
                            style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: AppColors.textPrimary,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (user.company.bs.isNotEmpty) ...[
                  const Divider(height: 1, color: AppColors.border),
                  _buildInfoTile(
                    context,
                    icon: Icons.lightbulb_outline_rounded,
                    label: 'Business Strategy',
                    value: user.company.bs,
                  ),
                ],
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Icon(icon, size: 20, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onCopy,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isNotEmpty ? value : 'N/A',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          if (onCopy != null)
            IconButton(
              icon: const Icon(
                Icons.copy_rounded,
                size: 16,
                color: AppColors.textMuted,
              ),
              onPressed: onCopy,
              tooltip: 'Copy',
            ),
        ],
      ),
    );
  }
}
