import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'No cameras available';
        });
        return;
      }

      _controller = CameraController(
        _cameras[0],
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error initializing camera: $e';
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Monitoring'),
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_camera),
            onPressed: _cameras.length < 2
                ? null
                : () async {
                    final currentCameraIndex = _cameras.indexOf(_controller!.description);
                    final nextCameraIndex = (currentCameraIndex + 1) % _cameras.length;
                    await _controller?.dispose();
                    setState(() {
                      _isLoading = true;
                    });
                    _controller = CameraController(
                      _cameras[nextCameraIndex],
                      ResolutionPreset.high,
                      enableAudio: false,
                    );
                    try {
                      await _controller!.initialize();
                    } catch (e) {
                      if (mounted) {
                        setState(() {
                          _errorMessage = 'Error switching camera: $e';
                        });
                      }
                    }
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _initializeCamera,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: Text('Camera not initialized'));
    }

    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: CameraPreview(_controller!),
          ),
        ),
        _buildControlBar(),
      ],
    );
  }

  Widget _buildControlBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: () {
              // TODO: Implement snapshot capture
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Snapshot feature coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // TODO: Implement video recording
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Recording feature coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement camera settings
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Camera settings coming soon!')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget? _buildFloatingActionButton() {
    if (_isLoading || _errorMessage.isNotEmpty) {
      return null;
    }

    return FloatingActionButton(
      onPressed: () {
        // TODO: Implement emergency alert
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Emergency alert feature coming soon!'),
            backgroundColor: Colors.red,
          ),
        );
      },
      backgroundColor: Colors.red,
      child: const Icon(Icons.warning_amber_rounded),
    );
  }
}
