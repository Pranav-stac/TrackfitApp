import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<dynamic> videos = [];
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.googleapis.com/youtube/v3/search?part=snippet&q=dietandnutrition&type=video&maxResults=10&key=AIzaSyDoQgxx7bhnkDsY2gZV2joWYE_7D875dd0'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          if (data['items'] != null) {
            videos = data['items'];
          } else {
            error = 'No videos found';
          }
        });
      } else {
        setState(() {
          error = 'Failed to load videos';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error fetching videos: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: error.isNotEmpty
          ? Center(child: Text(error, style: TextStyle(color: Colors.white)))
          : videos.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    final title = video['snippet']['title'];
                    final thumbnailUrl = video['snippet']['thumbnails']['default']['url'];
                    final videoId = video['id']['videoId']; // Assuming the video ID is here

                    return ListTile(
                      leading: Image.network(thumbnailUrl),
                      title: Text(title, style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle the tap event, e.g., navigate to a video player page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerPage(videoId: videoId),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}

class VideoPlayerPage extends StatelessWidget {
  final String videoId;

  const VideoPlayerPage({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // YoutubePlayerController _controller = YoutubePlayerController(
    //   initialVideoId: videoId,
    //   flags: YoutubePlayerFlags(
    //     autoPlay: true,
    //     mute: false,
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(title: Text('Video Player')),
      // body: YoutubePlayer(
      //   controller: _controller,
      //   showVideoProgressIndicator: true,
      //   progressIndicatorColor: Colors.amber,
      // ),
    );
  }
}