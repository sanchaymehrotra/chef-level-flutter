import 'package:flutter/material.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';

class CustomLoader{
 static void showCustomLoader(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          backgroundColor: AppColor.lightBlack,
          title: Text("Loading",style: TextStyle(color: AppColor.white),),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Colors.red.shade100,),
              SizedBox(width: 20),
              Text("Please wait...",style: TextStyle(color: AppColor.white),),
            ],
          ),
        );
      },
    );
  }
}