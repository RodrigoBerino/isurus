import 'package:flutter/material.dart'; 
import '../controllers/video_controller.dart';
import '../widgets/video_card.dart';
import '../models/video_model.dart';

class HomeView extends StatelessWidget { //herança
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = VideoController();

    return Scaffold(
      appBar: AppBar(title: const Text('StreamApp')),
      body: FutureBuilder<List<VideoModel>>(
        future: controller.loadVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final videos = snapshot.data!;
          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) => VideoCard(video: videos[index]),
          );
        },
      ),
    );
  }
}
