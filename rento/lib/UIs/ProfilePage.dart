import 'package:flutter/material.dart';
import 'package:rento/components/SideMenu.dart';
import 'package:rento/components/StarRating.dart';

class ProfilePage extends StatefulWidget {
  @override
  Profile createState() => Profile();
}

class Comment {
  String _text, _uName;
  DateTime _dateTime;
  Comment(this._text, this._dateTime, this._uName);
}

// class CommentBlock extends StatelessWidget
// {
//   Comment cmnt;
//   CommentBlock(this.cmnt);
//   return new _Comment(this.cmnt);

//   class _Comment{

//   }
// }

class Profile extends State<ProfilePage> {
  double rating = 3;
  List<Comment> comments = [
    new Comment("_text1", DateTime.now(), "_uName1"),
    new Comment("_text2", DateTime.now(), "_uName2"),
    new Comment("_text3", DateTime.now(), "_uName3")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text("Profile")),
        drawer: new SideMenu(),
        body: Column(children: <Widget>[
          Divider(),
          _buildUserIdentity("user"),
          Divider(),
          new Padding(
            padding: EdgeInsets.only(left: 15),
            //USER DESCRIPTION
            child: _bibleField(),
          ),
          Divider(),
          new Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(children: <Widget>[
                //RATES
                Text(
                  "Rating",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: "Poppings",
                      fontSize: 18),
                ),
                new StarRating(
                  color: Colors.yellow[600],
                  starCount: 5,
                  rating: rating,
                  size: 4,
                  onRatingChanged: (rating) =>
                      setState(() => this.rating = rating),
                ),
              _bldcmnt(comments[1]),
              ])),
          //COMMENTS BLOCKS
          // new Padding(
          //   padding: EdgeInsets.only(left: 20),
          //   child: ListView.builder(
          //     itemCount: comments.length,
          //     itemBuilder: (context, index) {
          //       final comment = comments[index];
                //return _bldcmnt(comment);
          //     },
            // ),
          // )
            
        ]));
  }

  Widget _buildUserIdentity(String user) {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Padding(
            child: new CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.grey,
              // backgroundImage: user.avatarUrl != null ? new NetworkImage(
              //     user.avatarUrl) : null,
            ),
            padding: const EdgeInsets.only(right: 15.0),
          ),
          new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: new Text("Display name",
                    style: new TextStyle(fontWeight: FontWeight.bold)),
              ),
              new Text("Real name")
            ],
          )
        ]);
  }

  Widget _bibleField() {
    return new Container(
        padding: const EdgeInsets.all(15),
        child: new Container(
          child: new Center(
              child: new Column(children: [
            new Padding(padding: EdgeInsets.only(top: 15.0)),
            new SingleChildScrollView(
              child: new TextFormField(
                enableInteractiveSelection: false,
                enabled: false,
                maxLines: 5,
                initialValue: " ",
                decoration: new InputDecoration(
                  labelText: "Bibliography",
                  fillColor: Colors.pink,
                  disabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                        color: Colors.deepOrange,
                        style: BorderStyle.solid,
                        width: 2),
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                        color: Colors.pink,
                        style: BorderStyle.solid,
                        width: 10),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            )
          ])),
        ));
  }

  Widget _bldcmnt(Comment cmnt) {
    return new Column(
      children: <Widget>[new ListTile(
        title: Text(cmnt._uName),
        subtitle: new SingleChildScrollView(
          child: new TextFormField(
            enableInteractiveSelection: false,
            enabled: false,
            maxLines: 3,
            initialValue: cmnt._text,
            decoration: new InputDecoration(

              prefixText: cmnt._dateTime.year.toString()+"/"+cmnt._dateTime.month.toString()+"/"+cmnt._dateTime.day.toString()+'\n',
              disabledBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                    color: Colors.deepOrange,
                    style: BorderStyle.solid,
                    width: 2),
              ),
            ),
            keyboardType: TextInputType.multiline,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ))]);
  }
}
