import 'package:harpy/api/twitter/data/tweet.dart';
import 'package:harpy/api/twitter/services/tweet_service.dart';
import 'package:harpy/blocs/bloc_provider.dart';
import 'package:harpy/core/cache/tweet_cache.dart';
import 'package:rxdart/rxdart.dart';

class TimelineBloc extends BlocBase {
  TimelineBloc() {
    _initController.stream.listen((_) => _initTimeline());

    _updateController.stream.listen((_) => _updateTimeline());
  }

  PublishSubject<List<Tweet>> _timelineController = PublishSubject();
  ValueObservable<List<Tweet>> get timeline => _timelineController.stream;

  PublishSubject<Null> _updateController = PublishSubject();
  Sink<Null> get update => _updateController.sink;

  PublishSubject<Null> _initController = PublishSubject();
  Sink<Null> get init => _initController.sink;

  Future<void> _updateTimeline() async {
    _timelineController.add(await TweetService().getHomeTimeline());
  }

  Future<void> _initTimeline() async {
    List<Tweet> tweets = await TweetCache.home().getCachedTweets();

    if (tweets.isEmpty) {
      await _updateTimeline();
    } else {
      _timelineController.add(tweets);
      _updateTimeline();
    }
  }

  @override
  void dispose() {
    _timelineController.close();
    _updateController.close();
    _initController.close();
  }
}
