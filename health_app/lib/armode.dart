import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class RemoteObject extends StatefulWidget {
  final String modelPath;

  const RemoteObject({Key? key, required this.modelPath}) : super(key: key);

  @override
  _RemoteObjectState createState() => _RemoteObjectState();
}

class _RemoteObjectState extends State<RemoteObject> {
  late String currentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.modelPath; // Initialize with the passed model path
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Model Viewer')),
      body: Column(
        children: [
          Expanded(
            child: ModelViewer(
              key: ValueKey(currentModel),
              backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
              src: currentModel,
              alt: 'A 3D model',
              ar: true,
              autoRotate: true,
              iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
              disableZoom: true,
            ),
          ),
          // ... existing button code ...
        ],
      ),
    );
  }
}