import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:skk_iden_mobile/features/shared/cubit/network_check_state.dart';

class NetworkCheckCubit extends Cubit<NetworkCheckState>{
  NetworkCheckCubit() : super(NetworkCheckInitial());

  void checkConnection() async{
    emit(NetworkCheckLoading());
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    emit(isConnected ? NetworkCheckConnected() : NetworkCheckLost());
  }
}