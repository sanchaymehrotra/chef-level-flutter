class PopuarTechniqueAllData {
  final bool? last;
  final int? pageNo;
  final int? pageSize;
  final List<PopuarTechniqueAllResult>? results;
  final int? totalElement;
  final int? totalPage;

  PopuarTechniqueAllData({
    this.last,
    this.pageNo,
    this.pageSize,
    this.results,
    this.totalElement,
    this.totalPage,
  });

  factory PopuarTechniqueAllData.fromJson(Map<String, dynamic> json) {
    return PopuarTechniqueAllData(
      last: json['last'],
      pageNo: json['pageNo'],
      pageSize: json['pageSize'],
      results: json['results'] != null ? List<PopuarTechniqueAllResult>.from(json['results'].map((x) => PopuarTechniqueAllResult.fromJson(x))) : null,
      totalElement: json['totalElement'],
      totalPage: json['totalPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last': last,
      'pageNo': pageNo,
      'pageSize': pageSize,
      'results': results?.map((x) => x.toJson()).toList(),
      'totalElement': totalElement,
      'totalPage': totalPage,
    };
  }
}

class ImageResponseDTO {
  final String? fileName;
  final String? filePath;
  final String? fileType;
  final int? id;

  ImageResponseDTO({
    this.fileName,
    this.filePath,
    this.fileType,
    this.id,
  });

  factory ImageResponseDTO.fromJson(Map<String, dynamic> json) {
    return ImageResponseDTO(
      fileName: json['fileName'],
      filePath: json['filePath'],
      fileType: json['fileType'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'filePath': filePath,
      'fileType': fileType,
      'id': id,
    };
  }
}

class PopularTechniquesListDataModel {
  final PopuarTechniqueAllData? data;
  final String? message;
  final int? responseCode;
  final String? status;

  PopularTechniquesListDataModel({
    this.data,
    this.message,
    this.responseCode,
    this.status,
  });

  factory PopularTechniquesListDataModel.fromJson(Map<String, dynamic> json) {
    return PopularTechniquesListDataModel(
      data: json['data'] != null ? PopuarTechniqueAllData.fromJson(json['data']) : null,
      message: json['message'],
      responseCode: json['responseCode'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'message': message,
      'responseCode': responseCode,
      'status': status,
    };
  }
}

class PopuarTechniqueAllResult {
  final dynamic? category;
  final String? chefName;
  final String? chefUuid;
  final String? description;
  final int? id;
  final List<ImageResponseDTO>? imageResponseDTO;
  final String? tags;
  final int? thumbnailImageId;
  final String? title;
  final int? videoId;

  PopuarTechniqueAllResult({
    this.category,
    this.chefName,
    this.chefUuid,
    this.description,
    this.id,
    this.imageResponseDTO,
    this.tags,
    this.thumbnailImageId,
    this.title,
    this.videoId,
  });

  factory PopuarTechniqueAllResult.fromJson(Map<String, dynamic> json) {
    return PopuarTechniqueAllResult(
      category: json['category'],
      chefName: json['chefName'],
      chefUuid: json['chefUuid'],
      description: json['description'],
      id: json['id'],
      imageResponseDTO: json['imageResponseDTO'] != null ? List<ImageResponseDTO>.from(json['imageResponseDTO'].map((x) => ImageResponseDTO.fromJson(x))) : null,
      tags: json['tags'],
      thumbnailImageId: json['thumbnailImageId'],
      title: json['title'],
      videoId: json['videoId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'chefName': chefName,
      'chefUuid': chefUuid,
      'description': description,
      'id': id,
      'imageResponseDTO': imageResponseDTO?.map((x) => x.toJson()).toList(),
      'tags': tags,
      'thumbnailImageId': thumbnailImageId,
      'title': title,
      'videoId': videoId,
    };
  }
}
