class TextData {
  //general text
  static const String enterYourPhoneNumber = 'Введите ваш номер телефона';
  static const String weWillSendYouVerificationCode =
      'Мы вышлем вам проверочный код';
  static const String doNotHaveAnAccount = 'У вас нет аккаунта?';
  static const String registration = 'Регистрация';
  static const String enterVerificationCode = 'Введите номер активации';
  static const String weSentItTo = 'Мы выслали его на номер ';
  static const String canSendAgainIn = 'Отправить код повторно можно через ';

  static const String username = 'Дмитрий';

  //parameterized text
  static String helloUser(String value) => 'Привет, $value!';

  //errors
  static const String thatNumberIsNotRegistered =
      'Указанный вами номер не найден';
  static const String codeIsIncorrect = 'Неверный код';

  //buttons
  static const String next = 'Далее';
  static const String enterSystem = 'Войти в систему';

  static const String sendAgain = 'Отправить код повторно';

  //extra
  static const String ruNumberPrefix = '+7 ';
}
