extension DateTimeExtension on DateTime{
  String getDifferenceFormateDateTime([bool isShortFormat = false]) {
    final diff = DateTime.now().difference(this);

    if(diff.inSeconds < 60){
      return "${diff.inSeconds}${(isShortFormat)?" s":" seconds ago"}";
    }
    else if(diff.inMinutes < 60){
      return "${diff.inMinutes}${(isShortFormat)?" m":" minutes ago"}";
    }
    else if(diff.inHours < 24){
      return "${diff.inHours}${(isShortFormat)?" h":" hours ago"}";
    }
    else if(diff.inDays < 7){
      return "${diff.inDays}${(isShortFormat)?" d":" days ago"}";
    }
    else if(diff.inDays < 30){
      return "${diff.inDays ~/ 7}${(isShortFormat)?" w":" weeks ago"}";
    }
    else if(diff.inDays < 365){
      return "${diff.inDays ~/ 30}${(isShortFormat)?" M":" months ago"}";
    }
    else{
      return "${diff.inDays ~/ 365}${(isShortFormat)?" y":" years ago"}";
    }
  }

}