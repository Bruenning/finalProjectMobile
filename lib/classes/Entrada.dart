class Entrada{
  String _input;
  String _source;
  String _target;

  Entrada(this._input, this._source, this._target);

  String get input => _input;

  String get source => _source;
  
  String get target => _target;

  set input(String value) {
    _input = value;
  }

  set source(String value) {
    _source = value;
  }

  set target(String value) {
    _target = value;
  }

}