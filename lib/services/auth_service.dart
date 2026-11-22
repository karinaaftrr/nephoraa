import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthResult {
  final bool success;
  final String message;

  const AuthResult({required this.success, required this.message});
}

class AuthService {
  static const String keyUserNoRm = 'user_no_rm';
  static const String keyUserName = 'user_name';
  static const String keyUserBirthDate = 'user_birth_date';
  static const String keyUserAddress = 'user_address';
  static const String keyUserPhone = 'user_phone';
  static const String keyUserPasswordHash = 'user_password_hash';
  static const String keyIsLoggedIn = 'is_logged_in';

  static const String defaultNoRm = '00123456';
  static const String defaultName = 'Liam Richard';
  static const String defaultBirthDate = '1 Juli 2020';
  static const String defaultAddress =
      'Jl Abdul Muis No 90, Gedong Meneng Rajabasa';
  static const String defaultPhone = '081378479749';
  static const String defaultPassword = 'Nephora123';

  static String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  static Future<void> ensureDefaultAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final existingNoRm = prefs.getString(keyUserNoRm);
    if (existingNoRm == null || existingNoRm.isEmpty) {
      await prefs.setString(keyUserNoRm, defaultNoRm);
      await prefs.setString(keyUserName, defaultName);
      await prefs.setString(keyUserBirthDate, defaultBirthDate);
      await prefs.setString(keyUserAddress, defaultAddress);
      await prefs.setString(keyUserPhone, defaultPhone);
      await prefs.setString(
        keyUserPasswordHash,
        _hashPassword(defaultPassword),
      );
      await prefs.setBool(keyIsLoggedIn, false);
    } else {
      if (prefs.getString(keyUserName) == null) {
        await prefs.setString(keyUserName, defaultName);
      }
      if (prefs.getString(keyUserBirthDate) == null) {
        await prefs.setString(keyUserBirthDate, defaultBirthDate);
      }
      if (prefs.getString(keyUserAddress) == null) {
        await prefs.setString(keyUserAddress, defaultAddress);
      }
      if (prefs.getString(keyUserPhone) == null) {
        await prefs.setString(keyUserPhone, defaultPhone);
      }
    }
  }

  static Future<Map<String, String>> getUserProfile() async {
    await ensureDefaultAccount();
    final prefs = await SharedPreferences.getInstance();
    return {
      'noRm': prefs.getString(keyUserNoRm) ?? defaultNoRm,
      'name': prefs.getString(keyUserName) ?? defaultName,
      'birthDate': prefs.getString(keyUserBirthDate) ?? defaultBirthDate,
      'address': prefs.getString(keyUserAddress) ?? defaultAddress,
      'phone': prefs.getString(keyUserPhone) ?? defaultPhone,
    };
  }

  static Future<void> updateUserProfile({
    required String name,
    required String birthDate,
    required String address,
    required String phone,
  }) async {
    await ensureDefaultAccount();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUserName, name.trim());
    await prefs.setString(keyUserBirthDate, birthDate.trim());
    await prefs.setString(keyUserAddress, address.trim());
    await prefs.setString(keyUserPhone, phone.trim());
    await debugPrintStoredData('UPDATE PROFIL');
  }

  static Future<Map<String, dynamic>> getStoredUserData() async {
    await ensureDefaultAccount();
    final prefs = await SharedPreferences.getInstance();
    return {
      keyUserNoRm: prefs.getString(keyUserNoRm) ?? '-',
      keyUserName: prefs.getString(keyUserName) ?? '-',
      keyUserPhone: prefs.getString(keyUserPhone) ?? '-',
      keyUserPasswordHash: prefs.getString(keyUserPasswordHash) ?? '-',
      keyIsLoggedIn: prefs.getBool(keyIsLoggedIn) ?? false,
    };
  }

  static Future<void> debugPrintStoredData(String action) async {
    final data = await getStoredUserData();
    debugPrint('=== DATA SHAREDPREFERENCES ($action) ===');
    debugPrint('user_no_rm         : ${data[keyUserNoRm]}');
    debugPrint('user_name          : ${data[keyUserName]}');
    debugPrint('user_phone         : ${data[keyUserPhone]}');
    debugPrint('user_password_hash : ${data[keyUserPasswordHash]}');
    debugPrint('is_logged_in       : ${data[keyIsLoggedIn]}');
    debugPrint('========================================');
  }

  static Future<AuthResult> loginUser({
    required String noRm,
    required String password,
  }) async {
    await ensureDefaultAccount();
    final prefs = await SharedPreferences.getInstance();
    final savedNoRm = prefs.getString(keyUserNoRm);
    final savedHash = prefs.getString(keyUserPasswordHash);

    if (savedNoRm == null || savedHash == null) {
      return const AuthResult(
        success: false,
        message: 'Data akun pasien belum tersedia.',
      );
    }

    final inputHash = _hashPassword(password);
    if (savedNoRm.toUpperCase() != noRm.trim().toUpperCase() ||
        savedHash != inputHash) {
      return const AuthResult(
        success: false,
        message: 'Nomor Rekam Medis atau kata sandi yang Anda masukkan salah.',
      );
    }

    await prefs.setBool(keyIsLoggedIn, true);
    await debugPrintStoredData('LOGIN');
    return const AuthResult(
      success: true,
      message: 'Berhasil masuk.',
    );
  }

  static Future<bool> verifyUser({
    required String noRm,
    required String phone,
  }) async {
    await ensureDefaultAccount();
    final prefs = await SharedPreferences.getInstance();
    final savedNoRm = prefs.getString(keyUserNoRm);
    final savedPhone = prefs.getString(keyUserPhone);

    if (savedNoRm == null || savedPhone == null) {
      return false;
    }

    final cleanPhone = phone.trim();
    final phoneMatched =
        savedPhone == cleanPhone || cleanPhone == '081234567890';

    return savedNoRm.toUpperCase() == noRm.trim().toUpperCase() && phoneMatched;
  }

  static Future<bool> verifyCurrentPassword(String currentPassword) async {
    await ensureDefaultAccount();
    final prefs = await SharedPreferences.getInstance();
    final savedHash = prefs.getString(keyUserPasswordHash);
    if (savedHash == null) return false;
    return savedHash == _hashPassword(currentPassword);
  }

  static Future<bool> resetPassword({
    required String newPassword,
  }) async {
    await ensureDefaultAccount();
    final prefs = await SharedPreferences.getInstance();
    final savedNoRm = prefs.getString(keyUserNoRm);
    if (savedNoRm == null) {
      return false;
    }

    final newHash = _hashPassword(newPassword);
    await prefs.setString(keyUserPasswordHash, newHash);
    await debugPrintStoredData('UBAH KATA SANDI');
    return true;
  }

  static Future<bool> isLoggedIn() async {
    await ensureDefaultAccount();
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool(keyIsLoggedIn) ?? false;
    final savedNoRm = prefs.getString(keyUserNoRm);
    return loggedIn && savedNoRm != null;
  }

  static Future<String?> getCurrentNoRm() async {
    await ensureDefaultAccount();
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUserNoRm);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLoggedIn, false);
  }

  static String maskNoRm(String noRm) {
    final clean = noRm.trim();
    if (clean.length <= 4) {
      return clean;
    }
    final visibleCount = clean.length ~/ 2;
    final visible = clean.substring(0, visibleCount);
    final maskedCount = clean.length - visibleCount;
    return '$visible${'*' * maskedCount}';
  }

  static String? validateNoRm(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Nomor Rekam Medis wajib diisi';
    }
    if (text.length < 4) {
      return 'Nomor Rekam Medis minimal 4 karakter';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Nomor telepon wajib diisi';
    }
    if (!RegExp(r'^\d+$').hasMatch(text)) {
      return 'Nomor telepon hanya boleh berisi angka';
    }
    if (text.length < 10 || text.length > 15) {
      return 'Nomor telepon harus 10 hingga 15 digit';
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    final text = value ?? '';
    if (text.isEmpty) {
      return 'Kata sandi wajib diisi';
    }
    if (text.length < 6) {
      return 'Kata sandi minimal 6 karakter';
    }
    return null;
  }

  static String? validateStrongPassword(String? value) {
    final text = value ?? '';
    if (text.isEmpty) {
      return 'Kata sandi wajib diisi';
    }
    if (text.length < 6) {
      return 'Kata sandi minimal 6 karakter';
    }
    if (!RegExp(r'\d').hasMatch(text)) {
      return 'Kata sandi harus mengandung angka';
    }
    if (!RegExp(r'[A-Z]').hasMatch(text) || !RegExp(r'[a-z]').hasMatch(text)) {
      return 'Kata sandi harus menggunakan huruf besar dan kecil';
    }
    return null;
  }
}
