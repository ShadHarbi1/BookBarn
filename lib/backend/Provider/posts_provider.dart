import 'package:book_barn/backend/Provider/api_base_provider.dart';
import 'package:book_barn/backend/models/posts.dart';
import 'package:book_barn/backend/services/Api/api_services.dart';
import 'package:either_option/either_option.dart';

class PostsDataProvider extends BaseProvider {
  List<Post> postsList = List<Post>();

  getPostsList() async {
    final Either<String, List<Post>> result =
        await ApiServices().getPostsList();

    result.fold((e) {
      setErrorMessage(e);
      setUiStateAndNotify(UISTATE.ERROR);
    }, (f) {
      postsList = f;
      setUiStateAndNotify(UISTATE.SUCCESS);
    });
  }
}
