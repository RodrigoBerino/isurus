import '../models/video_model.dart';
import '../repositories/video_repository.dart';

class VideoController {
  final VideoRepository _repository = VideoRepository();

  Future<List<VideoModel>> loadVideos() {
    return _repository.getAllVideos();
  }
}
