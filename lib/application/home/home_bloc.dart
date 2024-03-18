import 'package:bloc/bloc.dart';
import 'package:sky_track/domain/user/models/user_model.dart';
import 'package:sky_track/infastructure/user/firebase_user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeUsersEvent>(_handleFetchUsersEvent);
  }

  Future<void> _handleFetchUsersEvent(FetchHomeUsersEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final usersList = await fetchUsers();
      emit(HomeSuccessState(users: usersList));
    } catch (e) {
      emit(HomeErrorState('Failed to fetch users: $e'));
    }
  }

  Future<List<UserModel>> fetchUsers() async {
    try {
      final usersSnapshot = await FirebaseUserRepository().getUsers().first;
      return usersSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromDocument(data);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
