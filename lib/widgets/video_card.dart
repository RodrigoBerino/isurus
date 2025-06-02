import 'package:flutter/material.dart';
import '../models/video_model.dart';
import '../views/video_player_view.dart';

class VideoCard extends StatelessWidget {
  final VideoModel video;

  const VideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => VideoPlayerView(video: video)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(video.thumbnailUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(video.title, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
