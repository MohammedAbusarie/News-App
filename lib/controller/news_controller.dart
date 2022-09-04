import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

import '../constants.dart';
class NewsController extends GetxController{

  getData(NEWS_CATEGORIES news_category)async{
    final baseurl="https://newsapi.org";
    final method="/v2/top-headlines";
    final query="?category=${news_category.toShortString()}&country=eg&apiKey=204cd5e07430461e919cd532f87a7f0e";
    final url=baseurl+method+query;
    http.Response response= await http.get(Uri.parse(url));

    if(response.statusCode==200){
      try{
        return NewsResponse.fromJson(jsonDecode(response.body));
      }
      catch(e){
        Get.snackbar("Can't get data!", e.toString());
      }
    }
  }

}