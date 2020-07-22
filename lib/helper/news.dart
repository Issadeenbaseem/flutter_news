import 'dart:convert';

import 'package:flutter_news/Model/artical_model.dart';
import 'package:http/http.dart' as http;


class News {
  List<ArticalModel> news  = [];

  Future<void> getNews() async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=3e6473820b414c92a7e36dd0bda7fdae";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData['articles'].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null) {
          ArticalModel articalModel = ArticalModel(
            author: element["author"],
            title: element['title'],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content:element["content"],
          );

          news.add(articalModel);

        }
      });

    }
  }

}
class BlogNews {
  List<ArticalModel> news  = [];

  Future<void> getNews(String category ) async{
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=3e6473820b414c92a7e36dd0bda7fdae";

//3e6473820b414c92a7e36dd0bda7fdae
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData['articles'].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null) {
          ArticalModel articalModel = ArticalModel(
            author: element["author"],
            title: element['title'],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content:element["content"],
          );

          news.add(articalModel);

        }
      });

    }
  }

}