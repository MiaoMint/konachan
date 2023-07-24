class PostModel {
  int? id;
  String? tags;
  int? createdAt;
  int? creatorId;
  String? author;
  int? change;
  String? source;
  int? score;
  String? md5;
  int? fileSize;
  String? fileUrl;
  bool? isShownInIndex;
  String? previewUrl;
  int? previewWidth;
  int? previewHeight;
  int? actualPreviewWidth;
  int? actualPreviewHeight;
  String? sampleUrl;
  int? sampleWidth;
  int? sampleHeight;
  int? sampleFileSize;
  String? jpegUrl;
  int? jpegWidth;
  int? jpegHeight;
  int? jpegFileSize;
  String? rating;
  bool? hasChildren;
  String? status;
  int? width;
  int? height;
  bool? isHeld;

  PostModel({
    this.id,
    this.tags,
    this.createdAt,
    this.creatorId,
    this.author,
    this.change,
    this.source,
    this.score,
    this.md5,
    this.fileSize,
    this.fileUrl,
    this.isShownInIndex,
    this.previewUrl,
    this.previewWidth,
    this.previewHeight,
    this.actualPreviewWidth,
    this.actualPreviewHeight,
    this.sampleUrl,
    this.sampleWidth,
    this.sampleHeight,
    this.sampleFileSize,
    this.jpegUrl,
    this.jpegWidth,
    this.jpegHeight,
    this.jpegFileSize,
    this.rating,
    this.hasChildren,
    this.status,
    this.width,
    this.height,
    this.isHeld,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tags = json['tags'];
    createdAt = json['created_at'];
    creatorId = json['creator_id'];
    author = json['author'];
    change = json['change'];
    source = json['source'];
    score = json['score'];
    md5 = json['md5'];
    fileSize = json['file_size'];
    fileUrl = json['file_url'];
    isShownInIndex = json['is_shown_in_index'];
    previewUrl = json['preview_url'];
    previewWidth = json['preview_width'];
    previewHeight = json['preview_height'];
    actualPreviewWidth = json['actual_preview_width'];
    actualPreviewHeight = json['actual_preview_height'];
    sampleUrl = json['sample_url'];
    sampleWidth = json['sample_width'];
    sampleHeight = json['sample_height'];
    sampleFileSize = json['sample_file_size'];
    jpegUrl = json['jpeg_url'];
    jpegWidth = json['jpeg_width'];
    jpegHeight = json['jpeg_height'];
    jpegFileSize = json['jpeg_file_size'];
    rating = json['rating'];
    hasChildren = json['has_children'];
    status = json['status'];
    width = json['width'];
    height = json['height'];
    isHeld = json['is_held'];
  }
}
