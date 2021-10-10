import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receipts_list_dummy_app/util/logger.dart';

class AddReceiptBloc extends Bloc<AddReceiptEvent, AddReceiptState> {
  AddReceiptBloc() : super(Uninitialized()) {
    on<InitCam>(_onInitCam);
    on<UploadImageButtonPressed>(_onImageUpladButtonPressed);
  }

  static const _logger = Logger('AddReceiptBloc');
  final ImagePicker _picker = ImagePicker();

  void _onInitCam(InitCam event, Emitter<AddReceiptState> emit) async {
    // get available cameras
    await availableCameras().then((cams) async {
      if (cams.isEmpty) {
        emit(const Valid());
      } else {
        // wait for camera controller to be initialized
        final controller = CameraController(cams[0], ResolutionPreset.max);
        await controller.initialize();
        emit(Valid(controller: controller));
      }
    }).catchError((error, stackTrace) {
      _logger.log('cam init error', error: error);
      emit(CamInitError());
    });
  }

  void _onImageUpladButtonPressed(
      UploadImageButtonPressed event, Emitter<AddReceiptState> emit) async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (state is Valid) {
      emit((state as Valid).copyWith(xFile: image));
    }
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

class UploadImageButtonPressed extends AddReceiptEvent {}

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

class Valid extends AddReceiptState {
  const Valid({
    this.controller,
    this.xFile,
  });

  Valid copyWith({
    CameraController? controller,
    XFile? xFile,
  }) {
    return Valid(
      controller: controller ?? this.controller,
      xFile: xFile ?? this.xFile,
    );
  }

  final CameraController? controller;
  final XFile? xFile;

  @override
  List<Object> get props => [
        controller.hashCode,
        xFile.hashCode,
      ];

  @override
  String toString() => 'CamInitialised { controller: $controller }';
}
