import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/registration_data.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(const RegistrationState());

  void updateData(RegistrationData newData) {
    emit(state.copyWith(data: newData));
  }

  void nextStep() {
    if (state.currentStep < 6) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void jumpToStep(int step) {
    if (step >= 0 && step <= 6) {
      emit(state.copyWith(currentStep: step));
    }
  }

  Future<void> submitRegistration() async {
    emit(state.copyWith(status: RegistrationStatus.submitting));
    try {
      // Simulate API call
      // await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: RegistrationStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: RegistrationStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
