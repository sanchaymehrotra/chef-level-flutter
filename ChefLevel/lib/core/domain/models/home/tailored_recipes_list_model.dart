class TailoredRecipesAllData {
  final bool? last;
  final int? pageNo;
  final int? pageSize;
  final List<TailoredAllRecipiesResult>? results;
  final int? totalElement;
  final int? totalPage;

  TailoredRecipesAllData({
    this.last,
    this.pageNo,
    this.pageSize,
    this.results,
    this.totalElement,
    this.totalPage,
  });

  factory TailoredRecipesAllData.fromJson(Map<String, dynamic> json) {
    return TailoredRecipesAllData(
      last: json['last'],
      pageNo: json['pageNo'],
      pageSize: json['pageSize'],
      results: json['results'] != null ? List<TailoredAllRecipiesResult>.from(json['results'].map((x) => TailoredAllRecipiesResult.fromJson(x))) : null,
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

class Image {
  final String? fileName;
  final String? filePath;
  final String? fileType;
  final int? id;

  Image({
    this.fileName,
    this.filePath,
    this.fileType,
    this.id,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
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

class IngredientDetail {
  final String? name;
  final String? quantity;

  IngredientDetail({
    this.name,
    this.quantity,
  });

  factory IngredientDetail.fromJson(Map<String, dynamic> json) {
    return IngredientDetail(
      name: json['name'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}

// class Ingredients {
//   final String? ​  Cocoa powder (sifted);
//   final String? heavy whipping cream;
//   final String? powdered sugar (to taste) ​;
//   final String? vanilla extract;

//   Ingredients({
//     this.heavy whipping cream,
//     this.powdered sugar (to taste) ​,
//     this.vanilla extract,
//     this.​  Cocoa powder (sifted),
//   });

//   factory Ingredients.fromJson(Map<String, dynamic> json) {
//     return Ingredients(
//       ​  Cocoa powder (sifted): json['​  Cocoa powder (sifted)'],
//       heavy whipping cream: json['Heavy whipping cream'],
//       powdered sugar (to taste) ​: json['Powdered sugar (to taste) ​'],
//       vanilla extract: json['Vanilla extract'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'Heavy whipping cream': heavy whipping cream,
//       'Powdered sugar (to taste) ​': powdered sugar (to taste) ​,
//       'Vanilla extract': vanilla extract,
//       '​  Cocoa powder (sifted)': ​  Cocoa powder (sifted),
//     };
//   }
// }

class TailoredAllRecipiesResult {
  final int? calories;
  final int? carbs;
  final String? chefName;
  final String? chefTips;
  final String? chefUid;
  final String? cuisine;
  final String? difficulty;
  final String? dishName;
  final String? dishType;
  final int? fats;
  final int? fiber;
  final int? id;
  final List<Image>? image;
  final dynamic? imageId;
  final List<IngredientDetail>? ingredientDetails;
 // final Ingredients? ingredients;
  final String? instructions;
  final bool? isActive;
  final int? prepTime;
  final int? protein;
  final String? shortDescription;
  final String? skillLevel;
  final String? spiceLevel;
  final int? sugar;
  final int? thumbnailImageId;
  final List<String>? utensils;
  final dynamic? videoUrl;

  TailoredAllRecipiesResult({
    this.calories,
    this.carbs,
    this.chefName,
    this.chefTips,
    this.chefUid,
    this.cuisine,
    this.difficulty,
    this.dishName,
    this.dishType,
    this.fats,
    this.fiber,
    this.id,
    this.image,
    this.imageId,
    this.ingredientDetails,
   // this.ingredients,
    this.instructions,
    this.isActive,
    this.prepTime,
    this.protein,
    this.shortDescription,
    this.skillLevel,
    this.spiceLevel,
    this.sugar,
    this.thumbnailImageId,
    this.utensils,
    this.videoUrl,
  });

  factory TailoredAllRecipiesResult.fromJson(Map<String, dynamic> json) {
    return TailoredAllRecipiesResult(
      calories: json['calories'],
      carbs: json['carbs'],
      chefName: json['chefName'],
      chefTips: json['chefTips'],
      chefUid: json['chefUid'],
      cuisine: json['cuisine'],
      difficulty: json['difficulty'],
      dishName: json['dishName'],
      dishType: json['dishType'],
      fats: json['fats'],
      fiber: json['fiber'],
      id: json['id'],
      image: json['image'] != null ? List<Image>.from(json['image'].map((x) => Image.fromJson(x))) : null,
      imageId: json['imageId'],
      ingredientDetails: json['ingredientDetails'] != null ? List<IngredientDetail>.from(json['ingredientDetails'].map((x) => IngredientDetail.fromJson(x))) : null,
      //ingredients: json['ingredients'] != null ? Ingredients.fromJson(json['ingredients']) : null,
      instructions: json['instructions'],
      isActive: json['isActive'],
      prepTime: json['prepTime'],
      protein: json['protein'],
      shortDescription: json['shortDescription'],
      skillLevel: json['skillLevel'],
      spiceLevel: json['spiceLevel'],
      sugar: json['sugar'],
      thumbnailImageId: json['thumbnailImageId'],
      utensils: json['utensils'] != null ? List<String>.from(json['utensils']) : null,
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'carbs': carbs,
      'chefName': chefName,
      'chefTips': chefTips,
      'chefUid': chefUid,
      'cuisine': cuisine,
      'difficulty': difficulty,
      'dishName': dishName,
      'dishType': dishType,
      'fats': fats,
      'fiber': fiber,
      'id': id,
      'image': image?.map((x) => x.toJson()).toList(),
      'imageId': imageId,
      'ingredientDetails': ingredientDetails?.map((x) => x.toJson()).toList(),
      //'ingredients': ingredients?.toJson(),
      'instructions': instructions,
      'isActive': isActive,
      'prepTime': prepTime,
      'protein': protein,
      'shortDescription': shortDescription,
      'skillLevel': skillLevel,
      'spiceLevel': spiceLevel,
      'sugar': sugar,
      'thumbnailImageId': thumbnailImageId,
      'utensils': utensils,
      'videoUrl': videoUrl,
    };
  }
}

class TailoredRecipeListDataModel {
  final TailoredRecipesAllData? data;
  final String? message;
  final int? responseCode;
  final String? status;

  TailoredRecipeListDataModel({
    this.data,
    this.message,
    this.responseCode,
    this.status,
  });

  factory TailoredRecipeListDataModel.fromJson(Map<String, dynamic> json) {
    return TailoredRecipeListDataModel(
      data: json['data'] != null ? TailoredRecipesAllData.fromJson(json['data']) : null,
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
