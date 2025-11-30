import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';
import 'address_screen.dart';
import 'order_history_screen.dart';
import 'favorites_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=400&q=80',
                ),
              ),
              const SizedBox(height: 16),
              Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  final profile = auth.userProfile;
                  return Column(
                    children: [
                      Text(
                        profile?['name'] ?? auth.user?.displayName ?? 'User',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        profile?['email'] ?? auth.user?.email ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (profile?['phoneNumber'] != null && profile!['phoneNumber'].isNotEmpty)
                        Text(
                          profile['phoneNumber'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 48),
              _buildProfileOption(
                context,
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                  );
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.favorite_border,
                title: 'Favorites',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()),
                  );
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.location_on_outlined,
                title: 'Shipping Address',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddressScreen()),
                  );
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.history,
                title: 'Order History',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderHistoryScreen()),
                  );
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.red[50],
                    foregroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
    );
  }
}
