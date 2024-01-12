import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';
import 'package:tiktok_clone/features/videos/widgets/flash_button.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _deniedPermissions = false;

  bool _isSelfieMode = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late CameraController _cameraController;
  late double _maxZoomLevel;
  late double _minZoomLevel;
  double _currentZoomLevel = 1.0;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 100,
    ),
  );

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_buttonAnimationController);

  late FlashMode _flashMode;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    await _cameraController.prepareForVideoRecording();

    _maxZoomLevel = await _cameraController.getMaxZoomLevel();
    _minZoomLevel = await _cameraController.getMinZoomLevel();
    print("maxZoomLevel : $_maxZoomLevel");

    _flashMode = _cameraController.value.flashMode;

    setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
    } else {
      _deniedPermissions = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    if(!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }


    WidgetsBinding.instance.addObserver(this);

    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _cameraController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(!_hasPermission) return;
    if(!_cameraController.value.isInitialized) return;

    if(state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }

    //print(state);
  }

  Future<void> toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    print(_flashMode);
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    print("START RECORDING");

    if (_cameraController.value.isRecordingVideo) {
      return;
    }

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    print("STOP RECORDING");

    if (!_cameraController.value.isRecordingVideo) {
      return;
    }

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (video == null) return;

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  Future<void> _onPanUpdate(DragUpdateDetails details) async {
    double reverseDelta = -details.delta.dy;
    print("reverseDelta : $reverseDelta");

    _currentZoomLevel += (reverseDelta * 0.05);

    if(_currentZoomLevel >= _maxZoomLevel) _currentZoomLevel = _maxZoomLevel;
    if(_currentZoomLevel <= _minZoomLevel) _currentZoomLevel = _minZoomLevel;

    await _cameraController.setZoomLevel(_currentZoomLevel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _deniedPermissions
                        ? "Please allow permission"
                        : "Initializing...",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size18,
                    ),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive(),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if(!_noCamera && _cameraController.value.isInitialized)
                    Positioned.fill(
                      child: CameraPreview(
                        _cameraController,
                      ),
                    ),
                  if(!_noCamera)
                    Positioned(
                      top: Sizes.size36,
                      right: Sizes.size3,
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: toggleSelfieMode,
                            icon: Icon(
                              Icons.cameraswitch,
                            ),
                          ),
                          Gaps.v5,
                          FlashButton(
                            isSelect: _flashMode == FlashMode.off,
                            setFlashMode: () => _setFlashMode(FlashMode.off),
                            icon: Icons.flash_off_rounded,
                          ),
                          Gaps.v5,
                          FlashButton(
                            isSelect: _flashMode == FlashMode.always,
                            setFlashMode: () => _setFlashMode(FlashMode.always),
                            icon: Icons.flash_on_rounded,
                          ),
                          Gaps.v5,
                          FlashButton(
                            isSelect: _flashMode == FlashMode.auto,
                            setFlashMode: () => _setFlashMode(FlashMode.auto),
                            icon: Icons.flash_auto_rounded,
                          ),
                          Gaps.v5,
                          FlashButton(
                            isSelect: _flashMode == FlashMode.torch,
                            setFlashMode: () => _setFlashMode(FlashMode.torch),
                            icon: Icons.flashlight_on_rounded,
                          ),
                        ],
                      ),
                    ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: Sizes.size40,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTapDown: _startRecording,
                          onTapUp: (details) => _stopRecording(),
                          onPanUpdate: (details) => _onPanUpdate(details),
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: Sizes.size80 + Sizes.size14,
                                  height: Sizes.size80 + Sizes.size14,
                                  child: CircularProgressIndicator(
                                    color: Colors.red.shade400,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size80,
                                  height: Sizes.size80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
