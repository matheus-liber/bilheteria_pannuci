import 'package:bloc/bloc.dart';

part 'home_states.dart';

class HomeCubit<HomeStates> extends Cubit{
  HomeCubit() : super(HomeInitial());
}