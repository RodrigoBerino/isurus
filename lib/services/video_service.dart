import '../models/video_model.dart';

class VideoService {
  Future<List<VideoModel>> fetchVideos() async {
    await Future.delayed(const Duration(seconds: 1)); // simula delay de rede
    return [
      VideoModel(
        id: '1',
        title: 'Video de Exemplo',
        thumbnailUrl: 'https://placekitten.com/300/200',
        videoUrl: 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4',
      ),
      // adicione mais vídeos conforme desejar
    ];
  }
}
