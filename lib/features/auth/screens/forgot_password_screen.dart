import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:university_app/l10n/app_localizations.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/widgets/modern_text_field.dart';
import 'change_password_screen.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _verifyIdentity() {
    if (_formKey.currentState?.validate() ?? false) {
      // Logic for identity verification goes here.
      // For now we simulate success and move to the reset password page.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.identityVerifiedSuccess),
          backgroundColor: Colors.green,
        ),
      );

      // Delay to let the user see the success message
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ChangePasswordScreen(),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
        title: Text(l10n.forgotPasswordTitle),
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.lock_person_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ).animate().scale(
                  delay: 150.ms,
                  duration: 300.ms,
                  curve: Curves.easeOutBack,
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.forgotPasswordDesc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                    height: 1.5,
                  ),
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 40),
                ModernTextField(
                  label: l10n.emailOrIdLabel,
                  prefixIcon: Icons.badge_rounded,
                  controller: _inputController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.requiredField;
                    }
                    final val = value.trim();
                    // If it is entirely numbers, it must be an ID of 10 digits
                    if (RegExp(r'^[0-9]+$').hasMatch(val)) {
                      if (val.length != 10) return 'رقم الهوية يجب أن يتكون من 10 أرقام';
                    } else {
                      // Otherwise it must be a valid email
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                        return 'البريد الإلكتروني غير صحيح';
                      }
                    }
                    return null;
                  },
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _verifyIdentity,
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    shadowColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.4),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    l10n.verifyIdentityButton,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.2, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
