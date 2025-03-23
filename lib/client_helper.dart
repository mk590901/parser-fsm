import 'package:parser/parser_state_machine/parser_controller.dart';
import 'package:uuid/uuid.dart';

class ClientHelper {
  static ClientHelper? _instance;

  final String _clientId = 'flutter_client_${const Uuid().v4()}';
  late ParserController _controller;

  static void initInstance() {
    _instance ??= ClientHelper();
  }

  static ClientHelper? instance() {
    if (_instance == null) {
      throw Exception("--- ClientHelper was not initialized ---");
    }
    return _instance;
  }

  String clientId () {
    return _clientId;
  }

  void setController(ParserController controller) {
    _controller = controller;
  }

  ParserController? controller() {
    return _controller;
  }

}
