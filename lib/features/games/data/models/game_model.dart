class GameModel {
  final int id;
  final String? title; // Made nullable
  // bool? isEnrolled; // Made nullable
  // final double? progress; // Made nullable
  // final String? contentType; // Nullable
  // final String? audioLink; // Nullable
  // final String? videoLink; // Nullable
  // final String? imageUrl; // Nullable
  // final String? galleryUrl; // Nullable
  // final String? qaQuestion; // Nullable
  // final String? parentTrackTitle; // Nullable
  // final int? completedModules;
  // final int? completionPoints;
  // final int? totalModulesCount;
  // final String? courseType;
  // final List<AchievementModel>? achievements; // Nullable and list
  // List<ModuleModel>? modules; // Nullable, as it was not in the JSON example

  GameModel({
    required this.id,
    this.title,
    // this.parentTrackTitle,
    // this.completionPoints,
    // this.isEnrolled,
    // this.progress,
    // this.completedModules,
    // this.contentType,
    // this.totalModulesCount,
    // this.audioLink,
    // this.videoLink,
    // this.imageUrl,
    // this.courseType,
    // this.galleryUrl,
    // this.qaQuestion,
    // this.achievements,
    // this.modules,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      title: json['title'], // Now nullable
      // Handle case where featured_image_url might be false or null
      // isEnrolled: json['is_enrolled'] == true,
      // progress: json['progress'] != null ? json['progress'].toDouble() : 0,
      // completionPoints: json['achievements'] == null
      //     ? 0
      //     : json['achievements']['total_points'],
      // contentType: json['content_type'], // Nullable
      // audioLink: json['audio_link'], // Nullable
      // videoLink: json['video_link'], // Nullable
      // imageUrl: json['image_url'], // Nullable
      // completedModules: json['completed_modules_count'], // Nullable
      // totalModulesCount: json['total_modules_count'], // Nullable
      // parentTrackTitle: json['parent_track_title'], // Nullable
      // galleryUrl: json['gallery_url'], // Nullable
      // qaQuestion: json['qa_question'], // Nullable
      // courseType: json['course_type'], // Nullable
      // // Map achievements if present, otherwise null
      // achievements: json['achievements'] != null
      //     ? List<AchievementModel>.from(json['achievements']['achievements']
      //         .map((x) => AchievementModel.fromJson(x)))
      //     : null,
      // // Handle modules if present, otherwise null
      // modules: json['modules'] != null
      //     ? List<ModuleModel>.from(
      //         json['modules'].map((x) => ModuleModel.fromJson(x)))
      //     : null,
    );
  }
}
