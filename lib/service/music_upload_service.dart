// import 'dart:io';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// class MusicUploadService extends StatefulWidget {
//   const MusicUploadService({super.key});

//   @override
//   _MusicUploadServiceState createState() => _MusicUploadServiceState();
// }

// class _MusicUploadServiceState extends State<MusicUploadService> {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   bool _isUploading = false;
//   String _uploadStatus = "";

//   Future<String> _getAudioDuration(String filePath) async {
//     final player = AudioPlayer();
//     await player.setSourceDeviceFile(filePath);
//     Duration? duration = await player.getDuration(); // Fetch duration

//     if (duration != null) {
//       return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}"; // MM:SS format
//     } else {
//       return "Unknown"; // Handle cases where duration couldn't be retrieved
//     }
//   }

//   // Function to pick and upload multiple music files
//   Future<void> _pickAndUploadMusic(String category) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.audio,
//       allowMultiple: true, // Enable multiple file selection
//     );

//     if (result != null) {
//       setState(() {
//         _isUploading = true;
//         _uploadStatus = "Uploading ${result.files.length} files...";
//       });

//       // Fetch existing data to determine the next available key
//       DocumentSnapshot categoryDoc = await _firestore.collection("music").doc(category).get();
//       Map<String, dynamic> existingData = categoryDoc.exists ? categoryDoc.data() as Map<String, dynamic> : {};

//       int nextIndex = existingData.length + 1; // Start numbering from next available index

//       for (var file in result.files) {
//         if (file.path != null) {
//           File audioFile = File(file.path!);
//           String fileName = file.name;

//           String duration = await _getAudioDuration(audioFile.path);

//           try {
//             Reference ref = _storage.ref('music/$category/$fileName');
//             UploadTask uploadTask = ref.putFile(audioFile);
//             TaskSnapshot snapshot = await uploadTask;
//             String downloadUrl = await snapshot.ref.getDownloadURL();

//             await _firestore.collection("music").doc(category).set(
//               {
//                 "$nextIndex": {
//                   "songName": fileName,
//                   "category": category,
//                   "duration": duration,
//                   "fileUrl": downloadUrl,
//                   "uploadDate": Timestamp.now(),
//                 },
//               },
//               SetOptions(merge: true),
//             ); // Merge to avoid overwriting existing data

//             // Show success message
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Uploaded: $fileName (Duration: $duration)'),
//               ),
//             );

//             nextIndex++; // Increment index for the next song
//           } catch (e) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Upload failed for $fileName: $e')),
//             );
//           }
//         }
//       }

//       setState(() {
//         _isUploading = false;
//         _uploadStatus = "Upload complete!";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Music Upload Service")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (_isUploading) CircularProgressIndicator(),
//             if (_uploadStatus.isNotEmpty) Text(_uploadStatus),
//             _buildCategoryButton("Sad"),
//             _buildCategoryButton("Romantic"),
//             _buildCategoryButton("Marathi"),
//             _buildCategoryButton("Party"),
//             _buildCategoryButton("Pop"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryButton(String category) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: ElevatedButton(
//         onPressed: () => _pickAndUploadMusic(category),
//         child: Text("Upload $category Music"),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool _isUploading = false;
  List<String> _uploadedImages = [];

  Future<void> _pickAndUploadImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() => _isUploading = true);

      List<String> uploadedUrls = [];

      for (var file in result.files) {
        File imageFile = File(file.path!);

        try {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference ref = _storage.ref().child("category/$fileName.jpg");
          UploadTask uploadTask = ref.putFile(imageFile);
          TaskSnapshot snapshot = await uploadTask;
          String downloadUrl = await snapshot.ref.getDownloadURL();

          uploadedUrls.add(downloadUrl);
        } catch (e) {
          print("Upload failed: $e");
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
        }
      }

      setState(() {
        _isUploading = false;
        _uploadedImages.addAll(uploadedUrls);
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Upload complete!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload & Display Images")),
      body: Column(
        children: [
          if (_isUploading) LinearProgressIndicator(),
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: _pickAndUploadImages,
              child: Text("Select & Upload Images"),
            ),
          ),
          Expanded(
            child:
                _uploadedImages.isEmpty
                    ? Center(child: Text("No images uploaded yet"))
                    : GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _uploadedImages.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          _uploadedImages[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
