import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/Model/artical_model.dart';
import 'package:flutter_news/Model/category_model.dart';
import 'package:flutter_news/helper/data.dart';
import 'package:flutter_news/helper/news.dart';
import 'package:flutter_news/views/artical_view.dart';
import 'package:flutter_news/views/category_new.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticalModel>articles = new List<ArticalModel>();

  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories =getCategories();
    getNews();
  }
  getNews() async{
    News newsClass = News();
    await newsClass.getNews();

    articles = newsClass.news;
    setState(() {
      _loading =false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Srilankan "),
            Text("News ToDay" ,style: TextStyle(
              color:Colors.blue
            ),)
          ],
        ),
            centerTitle: true,
            elevation: 0.0,
      ),

      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    return CategoryTile(

                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,

                    );
                    }),
              ),

              Container(

                padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                child: ListView.builder(
                  itemCount: articles.length ,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context,index){
                    return BlogTile(
                      imageUrl: articles[index].urlToImage,
                      title: articles[index].description,
                      description: articles[index].description,
                      url: articles[index].url,
                    );
                    }),
                ),




            ],
          ),

        ),
      ),


    );
  }
}
class CategoryTile extends StatelessWidget {

  final  String imageUrl, categoryName;
  CategoryTile({this.imageUrl,this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => category_new(
            category1: categoryName.toLowerCase(),
          )
        ));

      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius:BorderRadius.circular(6),
                child: CachedNetworkImage(
                    imageUrl: imageUrl,width: 120,height: 60, fit: BoxFit.cover)
            ),
            Container(
              alignment: Alignment.center,
              width: 120,height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                  color: Colors.black26
              ),

              child: Text(categoryName, style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),),
            )
          ],
        ),
      ),
    );
  }
}
class BlogTile extends StatelessWidget {

  final String imageUrl,title,description,url;

  BlogTile({this.imageUrl,this.title,this.description,this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => artical_view(
            BlogUrl: url,
            
          )
          
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                
              borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            Text(title , style: TextStyle(
              fontSize: 17,
              color:Colors.black

            ),),
            Text(description ,style: TextStyle(
              color:Colors.grey,
              fontWeight: FontWeight.w600
            ),),
            SizedBox(height: 8,)
          ],
        ),
      ),
    );
  }
}
