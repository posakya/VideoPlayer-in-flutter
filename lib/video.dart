class Video{
  List<Data> data;

  Video(this.data);

  factory Video.fromJson(List<dynamic> json){
    List<Data> data = new List<Data>();
    data = json.map((i) => Data.fromJson(i)).toList();
    return new Video(data);
  }

}

class Data {
  int videoId;
  String videoLink;
  String videoName;
  int videoPriority;

  Data({this.videoId, this.videoLink, this.videoName, this.videoPriority});

  Data.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    videoLink = json['video_link'];
    videoName = json['video_name'];
    videoPriority = json['video_priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_id'] = this.videoId;
    data['video_link'] = this.videoLink;
    data['video_name'] = this.videoName;
    data['video_priority'] = this.videoPriority;
    return data;
  }
}