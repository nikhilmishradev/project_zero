import 'package:flutter/material.dart';import 'package:project_zero/services/other/photo_service.dart';import 'models/photo.dart';void main() {  runApp(MyApp());}class MyApp extends StatelessWidget {  @override  Widget build(BuildContext context) {    return MaterialApp(      title: 'Photos App',      theme: ThemeData(        primarySwatch: Colors.blue,      ),      home: PhotoListScreen(),    );  }}class PhotoListScreen extends StatefulWidget {  @override  _PhotoListScreenState createState() => _PhotoListScreenState();}class _PhotoListScreenState extends State<PhotoListScreen> {  late Future<List<Photo>> futurePhotos;  List<Photo> photos = [];  @override  void initState() {    super.initState();    // Initialize the futurePhotos with the API call    futurePhotos = PhotoApiService().fetchPhotos();    // Fetch the photos and store them locally for managing state    futurePhotos.then((value) {      setState(() {        photos = value;      });    });  }  @override  Widget build(BuildContext context) {    return Scaffold(      appBar: AppBar(        title: Text('Photos List'),      ),      body: photos.isEmpty          ? Center(child: CircularProgressIndicator())          : ListView.builder(        itemCount: photos.length,        itemBuilder: (context, index) {          final photo = photos[index];          return Card(            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),            child: Padding(              padding: const EdgeInsets.all(8.0),              child: Row(                crossAxisAlignment: CrossAxisAlignment.start,                children: [                  // Display thumbnail image                  Image.network(                    photo.thumbnailUrl,                    width: 64,                    height: 64,                    fit: BoxFit.cover,                  ),                  SizedBox(width: 16),                  // Display details (albumId, id, title, and URL)                  Expanded(                    child: Column(                      crossAxisAlignment: CrossAxisAlignment.start,                      children: [                        Text(                          'Album ID: ${photo.albumId} | ID: ${photo.id}',                          style: TextStyle(                            fontWeight: FontWeight.bold,                            color: Colors.blueGrey,                          ),                        ),                        SizedBox(height: 4),                        Text(                          photo.title,                          style: TextStyle(                            fontSize: 16,                            fontWeight: FontWeight.w500,                          ),                        ),                        SizedBox(height: 8),                        Text(                          'URL: ${photo.url}',                          style: TextStyle(                            fontSize: 14,                            color: Colors.grey,                          ),                        ),                      ],                    ),                  ),                ],              ),            ),          );        },      ),    );  }}