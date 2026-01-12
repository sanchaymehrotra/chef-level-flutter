class ChefListDataModel {
  final ChefAllData? data;
  final String? message;
  final int? responseCode;
  final String? status;

  ChefListDataModel({
    this.data,
    this.message,
    this.responseCode,
    this.status,
  });

  factory ChefListDataModel.fromJson(Map<String, dynamic> json) {
    return ChefListDataModel(
      data: json['data'] != null ? ChefAllData.fromJson(json['data']) : null,
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

class ChefAllData {
  final bool? last;
  final int? pageNo;
  final int? pageSize;
  final List<ChefAllResult>? results;
  final int? totalElement;
  final int? totalPage;

  ChefAllData({
    this.last,
    this.pageNo,
    this.pageSize,
    this.results,
    this.totalElement,
    this.totalPage,
  });

  factory ChefAllData.fromJson(Map<String, dynamic> json) {
    return ChefAllData(
      last: json['last'],
      pageNo: json['pageNo'],
      pageSize: json['pageSize'],
      results: json['results'] != null ? List<ChefAllResult>.from(json['results'].map((x) => ChefAllResult.fromJson(x))) : null,
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

class ImageResponse {
  final String? fileName;
  final String? filePath;
  final String? fileType;
  final int? id;

  ImageResponse({
    this.fileName,
    this.filePath,
    this.fileType,
    this.id,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    return ImageResponse(
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

class ChefAllResult {
  final String? address;
  final String? email;
  final int? id;
  final dynamic? imageId;
  final List<ImageResponse>? imageResponse;
  final String? name;
  final String? phoneNumber;
  final dynamic? rating;
  final int? recipeCount;
  final int? thumbnailImageId;
  final String? uuid;

  ChefAllResult({
    this.address,
    this.email,
    this.id,
    this.imageId,
    this.imageResponse,
    this.name,
    this.phoneNumber,
    this.rating,
    this.recipeCount,
    this.thumbnailImageId,
    this.uuid,
  });

  factory ChefAllResult.fromJson(Map<String, dynamic> json) {
    return ChefAllResult(
      address: json['address'],
      email: json['email'],
      id: json['id'],
      imageId: json['imageId'],
      imageResponse: json['imageResponse'] != null ? List<ImageResponse>.from(json['imageResponse'].map((x) => ImageResponse.fromJson(x))) : null,
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      rating: json['rating'],
      recipeCount: json['recipeCount'],
      thumbnailImageId: json['thumbnailImageId'],
      uuid: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'email': email,
      'id': id,
      'imageId': imageId,
      'imageResponse': imageResponse?.map((x) => x.toJson()).toList(),
      'name': name,
      'phoneNumber': phoneNumber,
      'rating': rating,
      'recipeCount': recipeCount,
      'thumbnailImageId': thumbnailImageId,
      'uuid': uuid,
    };
  }
}
