
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:news_app/view/reused/NewsList.dart';
import '../constants.dart';
import '../controller/news_controller.dart';
import '../model/news_model.dart';

class HomeView extends GetWidget<NewsController> {
  @override
  Widget build(BuildContext context) {
    return NewsList(NEWS_CATEGORIES.values[0]);
  }

}

