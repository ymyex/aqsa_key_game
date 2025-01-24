class OutputModel {
  final String? type; // e.g., 'image', 'video', 'text'
  final String?
      data; // For 'image': image filename; For 'video': video filename; For 'text': text content

  OutputModel({
    this.type,
    this.data,
  });

  factory OutputModel.fromJson(Map<String, dynamic> json) {
    return OutputModel(
      type: json['type'] as String?,
      data: json['data']?.toString(),
    );
  }
}
