import 'package:flutter_flux/flutter_flux.dart';
import 'package:harpy/api/twitter/data/tweet.dart';
import 'package:harpy/api/twitter/services/tweet_service.dart';

class HomeStore extends Store {
  static final Action initTweets = Action();

  List<Tweet> _tweets;

  List<Tweet> get tweets => _tweets;

  HomeStore() {
    triggerOnAction(initTweets, (_) async {
      _tweets = await TweetService().getHomeTimeline();
    });
  }
}
