import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sky_track/domain/authentication/models/auth_model.dart';
import 'package:sky_track/domain/user/models/user_model.dart';
import 'package:sky_track/infastructure/user/firebase_user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeUsersEvent>(_handleFetchUsersEvent);
  }

  Future<void> _handleFetchUsersEvent(FetchHomeUsersEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final usersList = await fetchUsers();
      final currentUser = await getCurrentUsers();
      emit(HomeSuccessState(users: usersList, currentUser: currentUser));
    } catch (e) {
      emit(HomeErrorState('Failed to fetch users: $e'));
    }
  }

  Future<AuthModel> getCurrentUsers() async {
    try {
      final uid = await secureStorage.read(key: 'uid');
      final email = await secureStorage.read(key: 'email');
      return AuthModel(userId: uid!, userEmail: email!);
    } catch (e) {
      throw Exception('Failed to load current users: $e');
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
