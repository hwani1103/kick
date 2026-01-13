class VideoModel {
  final String id;
  final String videoUrl;
  final String userId;
  final int kicks;
  final DateTime createdAt;
  final List<String> kickedBy;
  final int reportCount;

  VideoModel({
    required this.id,
    required this.videoUrl,
    required this.userId,
    required this.kicks,
    required this.createdAt,
    required this.kickedBy,
    this.reportCount = 0,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map, String id) {
    return VideoModel(
      id: id,
      videoUrl: map['videoUrl'] ?? '',
      userId: map['userId'] ?? '',
      kicks: map['kicks'] ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
      kickedBy: List<String>.from(map['kickedBy'] ?? []),
      reportCount: map['reportCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'videoUrl': videoUrl,
      'userId': userId,
      'kicks': kicks,
      'createdAt': createdAt.toIso8601String(),
      'kickedBy': kickedBy,
      'reportCount': reportCount,
    };
  }
}
