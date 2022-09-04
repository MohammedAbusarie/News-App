


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:news_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/news_controller.dart';
import '../../model/news_model.dart';

class NewsList extends StatefulWidget {

  late NEWS_CATEGORIES _category;

  NewsList(NEWS_CATEGORIES news_category){
    _category=news_category;
  }

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final _controller=Get.put(NewsController());
  String _alt_img="https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg";
  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (val){
            setState(() {
              _currentIndex=val;
              widget._category=NEWS_CATEGORIES.values[val];
            });
        },
        items: [
          BottomNavigationBarItem(
              label: NEWS_CATEGORIES.sports.toShortString().capitalize,
              icon: Icon(Icons.sports_baseball)
          ),
          BottomNavigationBarItem(
              label: NEWS_CATEGORIES.science.toShortString().capitalize,
              icon: Icon(Icons.science)
          ),
          BottomNavigationBarItem(
              label: NEWS_CATEGORIES.technology.toShortString().capitalize,
              icon: Icon(Icons.health_and_safety)
          ),
        ],
      ),
      appBar: AppBar(
        title:Text(widget._category.toShortString().toUpperCase()) ,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _controller.getData(widget._category),
        builder: (context,AsyncSnapshot snapshot){
          NewsResponse data= snapshot.data;
          if(snapshot.hasData){
            return ListView.builder(
                itemCount:data.articles.length ,
                itemBuilder: (context,index){
                  return  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: () async => await _launchUrl(data.articles[index].url),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TransparentImageCard(
                              width: double.infinity,
                              imageProvider: NetworkImage(data.articles[index].urlToImage ?? _alt_img),
                              tags: [ _tag(data.articles[index].publishedAt.toString(), () {}), ],
                              title: _title(data.articles[index].title,color: Colors.white),
                              description: _content(data.articles[index].description ?? "",color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    ),
                  );
                  // Text(data.articles[index].title.toString());
                }
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(
              ),
            );
          }
        },
      ),
    );
  }

  _launchUrl (String url) async {
    final _url=Uri.parse(url);
    if(await canLaunchUrl( _url ) )
    {
        await launchUrl(
            _url,
            mode: LaunchMode.inAppWebView,
        );
    }
    else{
       Get.snackbar("Can't open article!","");
    }
  }

  Widget _title(String title,{Color? color}) {
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textDirection: TextDirection.rtl,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
    );
  }

  Widget _content(String description,{Color? color}) {
    return Text(
      description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color),
    );
  }

  Widget _footer({Color? color}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            'assets/avatar.png',
          ),
          radius: 12,
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
            child: Text(
              'Super user',
              style: TextStyle(color: color),
            )),
        IconButton(onPressed: () {}, icon: Icon(Icons.share))
      ],
    );
  }

  Widget _tag(String tag, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.green),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          tag,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }


}