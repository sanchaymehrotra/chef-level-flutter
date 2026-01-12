import 'package:dio/dio.dart';
import 'package:food_chef/core/controller/home_recipes_controller.dart';
import 'package:food_chef/core/domain/network/dio_client.dart';
import 'package:food_chef/core/controller/user_controller.dart';
import 'package:food_chef/core/domain/repository/home_recipes_repository.dart';
import 'package:food_chef/core/domain/repository/user_repository.dart';
import 'package:food_chef/core/domain/services/home_recipes_service.dart';
import 'package:food_chef/core/domain/services/user_service.dart';
import 'package:get_it/get_it.dart';

 
final getIt = GetIt.instance;
 
Future<void> setup() async {
  // --------------- Dio -------------
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));

  
  //final bool isSeenWalkthrough = await SharedPrefService.isWalkthroughSeen();
  //final device = await Utility.getDeviceId();//UDID
  //final deviceType = await Utility.getDeviceType(); // DEVCE TYPE
  // await SharedPrefService.setUDID('sndndnd');
  // await SharedPrefService.setDeviceType("deviceType");
 
  // --------------- User Ifo -------------
  getIt.registerSingleton(UserService(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(UserRepository(getIt.get<UserService>()));
  getIt.registerSingleton(UserController());

  // --------------- Home Screen Recipes -------------
  getIt.registerSingleton(HomeRecipesService(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(HomeRecipesRepository (getIt.get<HomeRecipesService>()));
  getIt.registerSingleton(HomeRecipesController ());

}