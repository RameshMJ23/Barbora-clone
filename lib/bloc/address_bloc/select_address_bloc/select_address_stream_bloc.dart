
import 'package:barboraapp/bloc/address_bloc/select_address_bloc/select_address_stream_state.dart';
import 'package:barboraapp/data/services/user_service.dart';
import 'package:bloc/bloc.dart';

class SelectAddressStreamBloc extends Cubit<SelectAddressStreamState>{

  SelectAddressStreamBloc(String uid):super(LoadingAddressState()){
    UserService().getUserAddresses(uid).listen((list) {
      if(isClosed) return;

      if(list != null){
        emit(AddressState(addressList: list));
      }else{
        emit(LoadingAddressState());
      }

    });
  }
}