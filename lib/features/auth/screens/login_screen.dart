import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:university_app/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/modern_text_field.dart';
import '../../../../core/widgets/animated_verify_dialog.dart';

import 'forgot_password_screen.dart';
import '../../student_registration/screens/registration_screen.dart';
import 'change_password_screen.dart'; // Assuming linkage
import '../../../../core/widgets/support_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Key _columnKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.primary.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 48,
                  ),
                  child: Column(
                    key: _columnKey,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:
                        [
                              // Logo or Title
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  height: 220,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 48),

                              // Username Field
                              ModernTextField(
                                label: AppLocalizations.of(context)!.username,
                                prefixIcon: Icons.person,
                              ),
                              const SizedBox(height: 16),

                              // Password Field
                              ModernTextField(
                                label: AppLocalizations.of(context)!.password,
                                prefixIcon: Icons.lock,
                                isPassword: true,
                              ),
                              const SizedBox(height: 12),

                              // Forgot Password Link
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const ForgotPasswordScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.forgotPassword,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Login Button
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to Home
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ChangePasswordScreen(
                                            isMandatory: true,
                                          ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 8,
                                  shadowColor: theme.colorScheme.primary
                                      .withValues(alpha: 0.4),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    AppLocalizations.of(context)!.loginButton,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Links
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.dontHaveAccount,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const RegistrationScreen(),
                                        ),
                                      ).then(
                                        (_) => setState(() {
                                          _columnKey = UniqueKey();
                                        }),
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.newStudentRegistration,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      showGeneralDialog(
                                        context: context,
                                        barrierLabel: '',
                                        barrierDismissible: true,
                                        barrierColor: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        pageBuilder: (context, anim1, anim2) {
                                          return AnimatedVerifyDialog(
                                            onCancel: () =>
                                                Navigator.pop(context),
                                            onVerify: () {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.statusActive,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  backgroundColor: Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.verifyReferenceRequest,
                                      style: GoogleFonts.outfit(
                                        color: const Color(0xFFFF9800),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextButton(
                                    onPressed: () {
                                      showGeneralDialog(
                                        context: context,
                                        barrierLabel: '',
                                        barrierDismissible: true,
                                        barrierColor: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        pageBuilder: (context, anim1, anim2) {
                                          return const SupportDialog();
                                        },
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.orange,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.headset_mic_rounded,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.needHelp.replaceAll(': ', ''),
                                          style: TextStyle(
                                            color: theme.colorScheme.onSurface
                                                .withValues(alpha: 0.7),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]
                            .animate(interval: 50.ms)
                            .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                            .slideY(begin: 0.1, end: 0, duration: 350.ms),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
