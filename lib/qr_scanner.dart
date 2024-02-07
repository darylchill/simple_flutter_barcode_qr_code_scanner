import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerWithController extends StatefulWidget {
   const BarcodeScannerWithController( {super.key  });

  @override
  State<BarcodeScannerWithController> createState() =>
      _BarcodeScannerWithControllerState();
}

class _BarcodeScannerWithControllerState extends State<BarcodeScannerWithController> {
  String code ="";
  late AudioPlayer audioplayer;

  MobileScannerController controller = MobileScannerController(
    torchEnabled: true,
    // formats: [BarcodeFormat.qrCode]
    // facing: CameraFacing.front,
  );

  bool isStarted = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    audioplayer = AudioPlayer();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            //allowDuplicates: true,
              controller: controller,
              fit: BoxFit.contain,
              // allowDuplicates: true,
              // controller: MobileScannerController(
              //   torchEnabled: true,
              //   facing: CameraFacing.front,
              // ),
              onDetect: (capture) async{

                //play audio beep with just_audio package
                audioplayer.setAsset('assets/audio/beep.mp3');
                audioplayer.play();
                //
                //kill the mobile scanner
                controller.stop();
                controller.dispose();

                //return to main screen with value
                if (!mounted) return;
                Navigator.pop(context, capture.barcodes.last.rawValue.toString());


              }
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder(
                      valueListenable: controller.torchState,
                      builder: (context, state, child) {
                        if (state == false) {
                          return const Icon(
                            Icons.flash_off,
                            color: Colors.grey,
                          );
                        }
                        switch (state) {
                          case TorchState.off:
                            return const Icon(
                              Icons.flash_off,
                              color: Colors.grey,
                            );
                          case TorchState.on:
                            return const Icon(
                              Icons.flash_on,
                              color: Colors.yellow,
                            );
                        }
                      },
                    ),
                    iconSize: 32.0,
                    onPressed: () => controller.toggleTorch(),
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: isStarted
                        ? const Icon(Icons.stop)
                        : const Icon(Icons.play_arrow),
                    iconSize: 32.0,
                    onPressed: () => setState(() {
                      isStarted ? controller.stop() : controller.start();
                      isStarted = !isStarted;
                    }),
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 200,
                      height: 50,
                      child: FittedBox(
                        child: Text(
                          code ?? 'Scan something!',
                          overflow: TextOverflow.fade,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder(
                      valueListenable: controller.cameraFacingState,
                      builder: (context, state, child) {
                        if (state == null) {
                          return const Icon(Icons.camera_front);
                        }
                        switch (state) {
                          case CameraFacing.front:
                            return const Icon(Icons.camera_front);
                          case CameraFacing.back:
                            return const Icon(Icons.camera_rear);
                        }
                      },
                    ),
                    iconSize: 32.0,
                    onPressed: () => controller.switchCamera(),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

