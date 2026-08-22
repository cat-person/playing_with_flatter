import 'package:bloc/bloc.dart';
import 'package:snd/repo/main/repo.dart';
import 'event.dart';
import 'state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  // final MainRepo _mainRepo;

  MainBloc() : super(MainState("N")) {
    on<A>(_handleA);
    on<B>(_handleB);
  }

  Future<void> _handleA(event, emit) async {
    // final user = await _userRepo.getUser(_userId);
    emit(MainState("A"));
  }

  Future<void> _handleB(event, emit) async {
    // await _userRepo.updateUser(state.user.copyWith(name: event.name));
    emit(MainState("B"));
  }
}
