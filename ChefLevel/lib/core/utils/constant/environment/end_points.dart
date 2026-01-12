// ignore_for_file: non_constant_identifier_names

String baseUrl = "http://72.61.224.170:9123";
String cmsBaseUrl = "http://72.61.224.170:9124";

class EndPoints {
  static final create_account = "/api/chef-level-app-bff/v1/user-engagement/v1/create-account";
  static final check_profile_exist = "/api/chef-level-app-bff/v1/user-engagement/v1/check-profile-exists";
  static final login = "/api/chef-level-app-bff/v1/user-engagement/v1/login";
  static final verify_otp = "/api/chef-level-app-bff/v1/user-engagement/v1/authenticate-otp";
  static final data_defination = "/api/cms/v1/get-data-definition";
  static final save_prefs_data = "/api/chef-level-app-bff/v1/user-engagement/v1/save-user-preferences";
  static final get_home_recipes_data = "/api/chef-level-app-bff/v1/user-engagement/v1/get-home-screen";
  static final get_chef_list = "/api/chef-level-app-bff/v1/user-engagement/v1/list-chefs";
  static final get_tailored_recipe_list = "/api/chef-level-app-bff/v1/user-engagement/v1/get-tailored-recipes";
  static final get_popular_technique_list = "/api/chef-level-app-bff/v1/user-engagement/v1/get-popular-techniques";
}
