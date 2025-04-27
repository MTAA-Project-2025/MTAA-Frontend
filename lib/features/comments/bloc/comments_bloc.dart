import 'package:flutter_bloc/flutter_bloc.dart';

import 'comments_event.dart';
import 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsState(comments: [])) {
    on<AddMultipleCommentsEvent>((event, emit) {
      state.comments.addAll(event.comments);
      emit(CommentsState(comments: state.comments));
    });
    on<RemoveCommentEvent>((event, emit) {
      state.comments.remove(event.comment);
      emit(CommentsState(comments: state.comments));
    });
    on<AddNextCommentEvent>((event, emit) {
      int i = state.comments.indexOf(event.comment)+1;
      while(i<state.comments.length && state.comments[i].isMovedToTop){
        i++;
      }
      state.comments.insert(i, event.commentToPlace);

      emit(CommentsState(comments: state.comments));
    });
    on<RemoveNextCommentsEvent>((event, emit) {
      state.comments.removeWhere((e)=>e.id==event.comment.id);
      emit(CommentsState(comments: state.comments));
    });
    on<ClearCommentsEvent>((event, emit) {
      emit(CommentsState(comments: []));
    });

    on<AddFirstCommentEvent>((event, emit) {
      state.comments.insert(0, event.comment);
      emit(CommentsState(comments: state.comments));
    });
  }
}
