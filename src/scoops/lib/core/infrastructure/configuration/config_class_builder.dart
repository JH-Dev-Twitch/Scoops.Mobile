class ConfigClassBuilder {
  bool _isStatic;
  String className;
  List<String> _fields;
  List<ConfigClassBuilder> _subClasses;

  ConfigClassBuilder(String className, this._isStatic) {
    this.className = formatClassName(className);
    _fields = List.empty(growable: true);
    _subClasses = List.empty(growable: true);
  }

  String addTab() => "  ";

  String addStatic() => _isStatic ? "static " : "";

  void _addNullField(String name) =>
      _fields.add('${addTab()}${addStatic()}final var $name;');

  void _addStringField(String name, String value) =>
      _fields.add('${addTab()}${addStatic()}final String $name = "$value";');

  void _addBoolField(String name, bool value) =>
      _fields.add('${addTab()}${addStatic()}final bool $name = $value;');

  void _addIntField(String name, int value) =>
      _fields.add('${addTab()}${addStatic()}final int $name = $value;');

  void _addObjectField(String name, dynamic value) {
    var className = formatClassName(name);
    _fields
        .add('${addTab()}${addStatic()}final $className $name = $className();');
    var builder = ConfigClassBuilder(name, false);
    builder.importFields(value as Map);
    _subClasses.add(builder);
  }

  void _addArrayField(String name, List<dynamic> values) {
    var builder = StringBuffer();
    var value = values[0];
    var type = determineType(value.runtimeType);
    builder.write("${addTab()}${addStatic()}final List<$type> $name = [");
    bool isString = value.runtimeType == String;
    for (var i = 0; i < values.length; i++) {
      var val = values[i];
      builder.write(isString ? '"$val"' : '$val');
      if (i != values.length - 1) builder.write(',');
    }
    values.forEach((val) {});
    builder.write("];");
    _fields.add(builder.toString());
    builder.clear();
  }

  String determineType(Type value) {
    if (value == String)
      return "String";
    else if (value == int)
      return "int";
    else if (value == bool)
      return "bool";
    else if (value == String) return "String";
    throw Exception();
  }

  String formatClassName(String value) =>
      '${value[0].toUpperCase()}${value.substring(1)}';

  ConfigClassBuilder importFields(Map<String, dynamic> fields) {
    fields.forEach((key, value) {
      if (value != null) {
        if (value.runtimeType == String)
          _addStringField(key, value);
        else if (value.runtimeType == int)
          _addIntField(key, value);
        else if (value.runtimeType == bool)
          _addBoolField(key, value);
        else if (value.runtimeType == [].runtimeType)
          _addArrayField(key, value);
        else
          _addObjectField(key, value);
      }
    });
    return this;
  }

  String buildClass() {
    StringBuffer classBuilder = new StringBuffer();
    classBuilder.writeln("class $className {");
    _fields.forEach((value) => classBuilder.writeln(value));
    classBuilder.writeln("}");
    _subClasses.forEach((subClassBuilder) {
      classBuilder.writeln(subClassBuilder.buildClass());
    });
    return classBuilder.toString();
  }

  String generateFileNameForClass() {
    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    return className
        .replaceAllMapped(exp, (Match m) => ('_' + m.group(0)))
        .toLowerCase();
  }
}
