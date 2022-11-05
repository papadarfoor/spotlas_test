
class FeedModel {
    final String id;
  final String authorUsername;
  final String authorFullName;
  final String authorProfilePicture;
  final String createdAt;
  final String spotName;
  final String spots;
  final String location;
   final String logo;
  final String mediaImage;
  final String caption;
  final String tags;
 bool saved; 
  bool liked; 


  FeedModel({required this.id, required this.authorUsername, required this.authorFullName, required this.authorProfilePicture, required this.createdAt, required this.spotName, required this.spots, required this.location, required this.logo,  required this.mediaImage, required this.caption, required this.tags, this.saved = false, this.liked = false});

  Map<String, dynamic> toJson() => {
        'id': id,
        'authorUsername': authorUsername,
        'authorFullName': authorFullName,
         'authorProfilePicture': authorProfilePicture,
        'createdAt': createdAt,
         'spotName': spotName,
         'spots':spots,
        'location': location,
        'logo': logo,
        'mediaImage': mediaImage,
         'caption': caption,
        'tags': tags,
        'saved': saved,
        'liked': liked,
      };
}
