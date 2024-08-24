import 'package:flutter/material.dart';import 'package:project_zero/services/api_service_comments.dart';import 'models/comments.dart';import 'models/post.dart';void main() {  runApp(MyApp());}class MyApp extends StatelessWidget {  @override  Widget build(BuildContext context) {    return MaterialApp(      title: 'Flutter API Integration',      theme: ThemeData(        primarySwatch: Colors.blue,      ),      home: CommentsListScreen(),    );  }}class CommentsListScreen extends StatefulWidget {  @override  _CommentsListScreenState createState() => _CommentsListScreenState();}class _CommentsListScreenState extends State<CommentsListScreen> {  late Future<List<Comments>> futurePosts;  @override  void initState() {    super.initState();    // Initialize the futureComments with the API call    futurePosts = ApiServiceComments().fetchPosts();  }  @override  Widget build(BuildContext context) {    return Scaffold(      appBar: AppBar(        title: Text('Comments List'),      ),      body: FutureBuilder<List<Comments>>(        future: futurePosts,        builder: (context, snapshot) {          if (snapshot.connectionState == ConnectionState.waiting) {            return Center(child: CircularProgressIndicator());          } else if (snapshot.hasError) {            return Center(child: Text('Error: ${snapshot.error}'));          } else if (snapshot.hasData) {            return ListView.builder(              itemCount: snapshot.data!.length,              itemBuilder: (context, index) {                final comment = snapshot.data![index];                return Card(                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),                  child: Padding(                    padding: const EdgeInsets.all(16.0),                    child: Column(                      crossAxisAlignment: CrossAxisAlignment.start,                      children: [                        Text(                          comment.name,                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),                        ),                        Text(                          comment.email,                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),                        ),                        SizedBox(height: 8),                        Text(comment.body),                      ],                    ),                  ),                );              },            );          } else {            return Center(child: Text('No data found.'));          }        },      ),    );  }}