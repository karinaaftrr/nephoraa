import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../FiturHD/dashboard.dart';
import '../services/auth_service.dart';
import 'ganti_password_page.dart';

class NephoraAuthHeader extends StatelessWidget {
  final double height;

  const NephoraAuthHeader({
    super.key,
    this.height = 242,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: WaveHeaderPainter(),
            ),
          ),
          Positioned(
            top: 0,
            left: 24,
            right: 24,
            bottom: height * 0.18,
            child: Center(
              child: Image.asset(
                'assets/images/logo_2.png',
                width: 290,
                height: 82,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    Path buildWavePath(double yOffset) {
      final path = Path();
      path.lineTo(0, h * 0.895 + yOffset);
      path.cubicTo(
        w * 0.08,
        h * 0.81 + yOffset,
        w * 0.145,
        h * 0.742 + yOffset,
        w * 0.215,
        h * 0.742 + yOffset,
      );
      path.cubicTo(
        w * 0.34,
        h * 0.742 + yOffset,
        w * 0.47,
        h * 0.995 + yOffset,
        w * 0.607,
        h * 0.995 + yOffset,
      );
      path.cubicTo(
        w * 0.73,
        h * 0.995 + yOffset,
        w * 0.87,
        h * 0.88 + yOffset,
        w,
        h * 0.835 + yOffset,
      );
      path.lineTo(w, 0);
      path.close();
      return path;
    }

    final shadowPaint = Paint()
      ..color = const Color(0x26000000)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawPath(buildWavePath(4), shadowPaint);

    final gradientPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF1E4C4E),
          Color(0xFF12606A),
          Color(0xFF399195),
        ],
        stops: [0.0, 0.35, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawPath(buildWavePath(0), gradientPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NephoraAuthTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String? Function(String?)? validator;

  const NephoraAuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.onToggleObscure,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLength,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F7),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x16000000),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            validator: validator,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFF122E2F),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              counterText: '',
              hintStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA0A4AB),
              ),
              filled: true,
              fillColor: const Color(0xFFF5F6F7),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFEAECEF),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF399195),
                  width: 1.4,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.4,
                ),
              ),
              suffixIcon: onToggleObscure != null
                  ? IconButton(
                      onPressed: onToggleObscure,
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xFF1E4C4E),
                        size: 22,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

class NephoraAuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const NephoraAuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E4C4E),
          foregroundColor: const Color(0xFFFFFFFF),
          disabledBackgroundColor: const Color(0xFF1E4C4E).withValues(alpha: 0.6),
          elevation: 2,
          shadowColor: const Color(0x331E4C4E),
          shape: const StadiumBorder(),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _noRmController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _noRmController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    final result = await AuthService.loginUser(
      noRm: _noRmController.text,
      password: _passwordController.text,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result.success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.message,
            style: const TextStyle(fontFamily: 'Roboto'),
          ),
          backgroundColor: const Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 242,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: WaveHeaderPainter(),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 24,
                    right: 24,
                    bottom: 44,
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo_2.png',
                        width: 290,
                        height: 82,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selamat Datang!',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Masuk untuk melanjutkan',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 28),
                    NephoraAuthTextField(
                      label: 'Nomor Rekam Medis',
                      hintText: 'Masukkan Nomor Rekam Medis',
                      controller: _noRmController,
                      keyboardType: TextInputType.text,
                      validator: AuthService.validateNoRm,
                    ),
                    const SizedBox(height: 18),
                    NephoraAuthTextField(
                      label: 'Kata Sandi',
                      hintText: 'Masukkan kata sandi',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onToggleObscure: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      validator: AuthService.validateLoginPassword,
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GantiPasswordPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Ganti Password?',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF399195),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF399195),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    NephoraAuthButton(
                      text: 'Masuk',
                      isLoading: _isLoading,
                      onPressed: _handleLogin,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
