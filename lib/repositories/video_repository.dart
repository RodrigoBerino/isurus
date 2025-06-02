import '../models/video_model.dart';
import '../services/video_service.dart';

class VideoRepository {
  final VideoService _service = VideoService();

  Future<List<VideoModel>> getAllVideos() {
    return _service.fetchVideos();
  }
}
