import 'package:flutter/material.dart';
import '../../navbar/navbar.dart';
import '../../services/auth_service.dart';

class KelolaProfilPage extends StatefulWidget {
  const KelolaProfilPage({super.key});

  @override
  State<KelolaProfilPage> createState() => _KelolaProfilPageState();
}

class _KelolaProfilPageState extends State<KelolaProfilPage> {
  final _nameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await AuthService.getUserProfile();
    if (!mounted) return;
    setState(() {
      _nameController.text = profile['name'] ?? AuthService.defaultName;
      _birthDateController.text =
          profile['birthDate'] ?? AuthService.defaultBirthDate;
      _addressController.text =
          profile['address'] ?? AuthService.defaultAddress;
      _phoneController.text = profile['phone'] ?? AuthService.defaultPhone;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    await AuthService.updateUserProfile(
      name: _nameController.text,
      birthDate: _birthDateController.text,
      address: _addressController.text,
      phone: _phoneController.text,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perubahan profil berhasil disimpan.'),
        backgroundColor: Color(0xFF138896),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 24, 6),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.chevron_left_rounded,
                        size: 32,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Text(
                    'Kelola Profil',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(26, 14, 26, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/profile_liam.png',
                              width: 86,
                              height: 86,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color(0xFF12606A),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit_outlined,
                                size: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    _buildField('Nama Lengkap', _nameController),
                    const SizedBox(height: 16),
                    _buildField(
                      'Tanggal Lahir',
                      _birthDateController,
                      suffixIcon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Color(0xFFB0B0B0),
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildField('Alamat', _addressController),
                    const SizedBox(height: 16),
                    _buildField(
                      'No Telepon',
                      _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 64),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF138896),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Simpan Perubahan',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NephoraNavbar(currentIndex: 3),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13.5,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 15,
            ),
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFF138896),
                width: 1.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
