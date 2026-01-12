class Chef {
  final String? address;
  final String? email;
  final int? id;
  final dynamic? imageId;
  final List<ImageResponse>? imageResponse;
  final String? name;
  final String? phoneNumber;
  final dynamic? rating;
  final int? recipeCount;
  final dynamic? thumbnailImageId;
  final String? uuid;

  Chef({
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

  factory Chef.fromJson(Map<String, dynamic> json) {
    return Chef(
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
      'imageResponse': imageResponse,
      'name': name,
      'phoneNumber': phoneNumber,
      'rating': rating,
      'recipeCount': recipeCount,
      'thumbnailImageId': thumbnailImageId,
      'uuid': uuid,
    };
  }
}

class HomeData {
  final List<Chef>? chefs;
  final List<PopularTechnique>? popularTechniques;
  final List<TailoredRecipe>? tailoredRecipes;

  HomeData({
    this.chefs,
    this.popularTechniques,
    this.tailoredRecipes,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      chefs: json['chefs'] != null ? List<Chef>.from(json['chefs'].map((x) => Chef.fromJson(x))) : null,
      popularTechniques: json['popularTechniques'] != null ? List<PopularTechnique>.from(json['popularTechniques'].map((x) => PopularTechnique.fromJson(x))) : null,
      tailoredRecipes: json['tailoredRecipes'] != null ? List<TailoredRecipe>.from(json['tailoredRecipes'].map((x) => TailoredRecipe.fromJson(x))) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chefs': chefs?.map((x) => x.toJson()).toList(),
      'popularTechniques': popularTechniques?.map((x) => x.toJson()).toList(),
      'tailoredRecipes': tailoredRecipes?.map((x) => x.toJson()).toList(),
    };
  }
}

class HomeRecipesDataModel {
  final HomeData? data;
  final String? message;
  final int? responseCode;
  final String? status;

  HomeRecipesDataModel({
    this.data,
    this.message,
    this.responseCode,
    this.status,
  });

  factory HomeRecipesDataModel.fromJson(Map<String, dynamic> json) {
    return HomeRecipesDataModel(
      data: json['data'] != null ? HomeData.fromJson(json['data']) : null,
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

class TailoredRecipeImage {
  final String? fileName;
  final String? filePath;
  final String? fileType;
  final int? id;

  TailoredRecipeImage({
    this.fileName,
    this.filePath,
    this.fileType,
    this.id,
  });

  factory TailoredRecipeImage.fromJson(Map<String, dynamic> json) {
    return TailoredRecipeImage(
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
//   final String? arborio Rice;
//   final String? chicken Stock;

//   Ingredients({
//     this.arborio Rice,
//     this.chicken Stock,
//   });

//   factory Ingredients.fromJson(Map<String, dynamic> json) {
//     return Ingredients(
//       arborio Rice: json['Arborio Rice'],
//       chicken Stock: json['Chicken Stock'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'Arborio Rice': arborio Rice,
//       'Chicken Stock': chicken Stock,
//     };
//   }
// }

class PopularTechnique {
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

  PopularTechnique({
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

  factory PopularTechnique.fromJson(Map<String, dynamic> json) {
    return PopularTechnique(
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

class TailoredRecipe {
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
  final List<TailoredRecipeImage>? image;
  final int? imageId;
  final List<IngredientDetail>? ingredientDetails;
  //final Ingredients? ingredients;
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

  TailoredRecipe({
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
    //this.ingredients,
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

  factory TailoredRecipe.fromJson(Map<String, dynamic> json) {
    return TailoredRecipe(
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
      image: json['image'] != null ? List<TailoredRecipeImage>.from(json['image'].map((x) => TailoredRecipeImage.fromJson(x))) : null,
      imageId: json['imageId'],
      ingredientDetails: json['ingredientDetails'] != null ? List<IngredientDetail>.from(json['ingredientDetails'].map((x) => IngredientDetail.fromJson(x))) : null,
     // ingredients: json['ingredients'] != null ? Ingredients.fromJson(json['ingredients']) : null,
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
     // 'ingredients': ingredients?.toJson(),
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
