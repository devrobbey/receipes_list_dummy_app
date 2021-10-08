import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:receipts_list_dummy_app/util/logger.dart';

class AddReceiptBloc extends Bloc<AddReceiptEvent, AddReceiptState> {
  AddReceiptBloc() : super(Uninitialized()) {
    on<InitCam>(_onInitCam);
  }

  static const _logger = Logger('AddReceiptBloc');

  final Future<List<CameraDescription>> camerasFuture = availableCameras();

  void _onInitCam(InitCam event, Emitter<AddReceiptState> emit) async {
    // get available cameras
    availableCameras().then((cams) async {
      if (cams.isEmpty) {
        emit(CamInitError());
      } else {
        // wait for camera controller to be initialized
        final controller = CameraController(cams[0], ResolutionPreset.max);
        await controller.initialize();
        emit(CamInitialised(controller: controller));
      }
    }).catchError((error, stackTrace) {
      _logger.log('cam init error', error: error);
      emit(CamInitError());
    });
  }

  @override
  void onTransition(Transition<AddReceiptEvent, AddReceiptState> transition) {
    _logger.log(transition.toString());
    super.onTransition(transition);
  }
}

/////////////////////////////////////
//////////
//////////  EVENTS
//////////
/////////////////////////////////////

abstract class AddReceiptEvent {
  const AddReceiptEvent();
}

class InitCam extends AddReceiptEvent {}

class TitleChanged extends AddReceiptEvent {
  const TitleChanged(this.title);

  final String title;
}

class SubtitleChanged extends AddReceiptEvent {
  const SubtitleChanged(this.subtitle);

  final String subtitle;
}

class FormSubmitted extends AddReceiptEvent {}

/////////////////////////////////////
//////////
//////////  STATES
//////////
/////////////////////////////////////

abstract class AddReceiptState extends Equatable {
  const AddReceiptState();

  @override
  List<Object?> get props => [];
}

class Uninitialized extends AddReceiptState {}

class CamInitInProgress extends AddReceiptState {
  const CamInitInProgress();
}

class CamInitError extends AddReceiptState {}

class CamInitialised extends AddReceiptState {
  const CamInitialised({required this.controller});

  final CameraController controller;

  @override
  List<Object> get props => [controller];

  @override
  String toString() => 'CamInitialised { controller: $controller }';
}

////////////////////////////////////////////////////////////
////////////
////////////    FORMFIELD MODELS (for Formz)
////////////
////////////////////////////////////////////////////////////

enum MailValidationError { invalid }

class Mail extends FormzInput<String, MailValidationError> {
  const Mail.pure([String value = '']) : super.pure(value);

  const Mail.dirty([String value = '']) : super.dirty(value);

  @override
  MailValidationError? validator(String value) {
    return RegExp(
                r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')
            .hasMatch(value)
        ? null
        : MailValidationError.invalid;
  }
}

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([String value = '']) : super.pure(value);

  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    return RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}
