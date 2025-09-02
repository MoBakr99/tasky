import 'package:flutter/material.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  Offset _offset = Offset.zero;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Column(
          children: [
            Text('Drag the photo to move it'),
            SizedBox(height: 10),
            Text('Double tap the photo to zoom in/out'),
            SizedBox(height: 10),
            Text('Long Press the photo to reset it'),
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Transform.translate(
          offset: _offset,
          child: Transform.scale(
            scale: _scale,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _offset += details.delta;
                });
              },
              // onPanEnd: (details) {
              //   setState(() {
              //     _offset = Offset.zero;
              //   });
              // },
              onLongPress: () {
                setState(() {
                  _offset = Offset.zero;
                  _scale = 1.0;
                });
              },
              onDoubleTap: () {
                setState(() {
                  _scale = _scale == 1.0 ? 1.5 : 1.0;
                });
              },
              // onScaleUpdate: (details) {
              //   setState(() {
              //     _scale = (_scale * details.scale).clamp(0.5, 2.0);
              //   });
              // },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/png/note.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
