part of 'registration_cubit.dart';

enum RegistrationStatus {
  initial,
  valid,
  invalid,
  submitting,
  success,
  failure,
}

class RegistrationState extends Equatable {
  final int currentStep;
  final RegistrationData data;
  final RegistrationStatus status;
  final String? errorMessage;

  const RegistrationState({
    this.currentStep = 0,
    this.data = const RegistrationData(),
    this.status = RegistrationStatus.initial,
    this.errorMessage,
  });

  RegistrationState copyWith({
    int? currentStep,
    RegistrationData? data,
    RegistrationStatus? status,
    String? errorMessage,
  }) {
    return RegistrationState(
      currentStep: currentStep ?? this.currentStep,
      data: data ?? this.data,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [currentStep, data, status, errorMessage];
}
