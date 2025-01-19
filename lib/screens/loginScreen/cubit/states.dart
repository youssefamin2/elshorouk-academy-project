abstract class UniveristyLoginStates {}

class LoginInitialState extends UniveristyLoginStates {}

//successLogin
class LoginSuccessState extends UniveristyLoginStates {}

//ErrorLogin
class LoginErrorState extends UniveristyLoginStates
{
  final String error;

  LoginErrorState(this.error);

}
