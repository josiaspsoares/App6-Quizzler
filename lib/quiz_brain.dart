import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('\“Penso, logo existo\” é uma famosa frase de Sócrates.', false),
    Question('O Vaticano é o menor país do mundo.', true),
    Question('O livro mais vendido no mundo é a Bíblia.', true),
    Question(
        'Em 7 de setembro se comemora a Proclamação da República no Brasil.',
        false),
    Question('O Pico da Neblina é a montanha mais alta do Brasil.', true),
    Question('A Estátua da Liberdade se localiza em Miami.', false),
    Question('A Baleia Azul é o maior animal terrestre.', false),
    Question('Pessoas do tipo sanguíneo O são consideradas doadores universais',
        true),
    Question('Os nomes dos três Reis Magos são Belchior, Galileu e Baltazar.',
        false),
    Question('Bill Gates foi o fundador da Microsoft.', true),
    Question(
        'Mercúrio é o planeta do Sistema Solar mais próximo do Sol.', true),
    Question(
        'A clorossíntese é o processo pelo qual as plantas convertem luz em energia.',
        false),
    Question('A Terra tem cinco oceanos.', true),
    Question('A África é o maior continente do mundo.', false),
    Question(
        'Sublimação é o processo pelo qual a água em estado gasoso passa para líquido.',
        false),
    Question('Crocodilos são répteis.', true),
    Question(
        'A Terra demora um ano para a Terra completar uma órbita ao redor do Sol.',
        true),
    Question('Plutão é um planeta.', false),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  int numberOfQuestions() {
    return _questionBank.length;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
