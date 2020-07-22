import 'package:flutter/material.dart';
import 'package:flutter_news/Model/artical_model.dart';
import 'package:flutter_news/helper/news.dart';

import 'artical_view.dart';


class category_new extends StatefulWidget {

  final String category1;
  category_new({this.category1});

  @override
  _category_newState createState() => _category_newState();
}

class _category_newState extends State<category_new> {


  List<ArticalModel>articles = new List<ArticalModel>();

  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }
  getCategoryNews() async{
    BlogNews newsClass = BlogNews();
    await newsClass.getNews(widget.category1);

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
          mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget>[
            Text("Flutter"),
            Text("News", style: TextStyle(
              color: Colors.blue
            ),)
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save,)),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) :SingleChildScrollView(
        child: Container(

          child: Column(
            children: <Widget>[
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
      )
      
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