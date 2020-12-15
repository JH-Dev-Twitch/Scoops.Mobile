class ConfigClassBuilder {
  bool _isStatic;
  String className;
  List<ClassField> _fields;

  List<ConfigClassBuilder> _subClasses;

  ConfigClassBuilder(String className, this._isStatic) {
    this.className = formatClassName(className);
    _fields = List.empty(growable: true);
    _subClasses = List.empty(growable: true);
  }

  String addTab() => "  ";

  String addStatic() => _isStatic ? "static " : "";

  // void _addArrayField(String name, List<dynamic> values) {
  //   var builder = StringBuffer();
  //   var value = values[0];
  //   var type = determineType(value.runtimeType);
  //   builder.write("${addTab()}${addStatic()}final List<$type> $name = [");
  //   bool isString = value.runtimeType == String;
  //   for (var i = 0; i < values.length; i++) {
  //     var val = values[i];
  //     builder.write(isString ? '"$val"' : '$val');
  //     if (i != values.length - 1) builder.write(',');
  //   }
  //   values.forEach((val) {});
  //   builder.write("];");
  //   _fields.add(builder.toString());
  //   builder.clear();
  // }

  String formatClassName(String value) =>
      '${value[0].toUpperCase()}${value.substring(1)}';

  ConfigClassBuilder importFields(Map<String, dynamic> fields) {
    fields.forEach((key, value) {
      if (value != null) {
        var field = ClassField(key, value);
        _fields.add(field);
        if (field.isCustomClass) {
          var builder = ConfigClassBuilder(key, false);
          builder.importFields(value as Map);
          _subClasses.add(builder);
        }
      }
    });
    return this;
  }

  String buildClass() {
    StringBuffer classBuilder = new StringBuffer();
    //class name
    classBuilder.writeln("class $className {");
    classBuilder.writeln();
    //fields
    _fields
        .forEach((value) => classBuilder.writeln(value.generateFieldString()));
    classBuilder.writeln();
    //singleton
    classBuilder.writeln(buildSingletonField());
    classBuilder.writeln();
    classBuilder.writeln(buildClassFactory());
    classBuilder.writeln();
    //constructions
    classBuilder.writeln(buildInternalContructor());
    classBuilder.writeln();
    classBuilder.writeln("}");
    classBuilder.writeln();
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

  String buildInternalContructor() {
    var fields = _fields.map<String>((field) => 'this.${field.name}').join(",");
    return '$className._internal($fields);';
  }

  String buildClassFactory() => 'factory $className() {return _singleton;}';

  String buildSingletonField() =>
      'static final $className _singleton = $className._internal(${_fields.map((field) => field.generateFieldValue()).join(",")});';
}

class ClassField {
  final String name;
  final dynamic value;
  String type;
  bool isCustomClass;
  var knownTypes = [
    "String",
    "int",
    "bool",
    "List<String>",
    "List<int>",
    "List<bool>"
  ];
  ClassField(this.name, this.value) {
    type = determineTypeString(this.value);
    isCustomClass = !knownTypes.contains(type);
  }

  String generateFieldString() => 'final $type $name;';

  String generateFieldValue() {
    return _generateFieldValue(this.value);
  }

  String _generateFieldValue(dynamic value) {
    if (value.runtimeType == String)
      return '"$value"';
    else if (value.runtimeType == int)
      return "$value";
    else if (value.runtimeType == bool)
      return "$value";
    else if (value.runtimeType == [].runtimeType)
      return formatListValue(value);
    else
      return formatClassValue();
  }

  String determineTypeString(dynamic value) {
    if (value.runtimeType == String)
      return "String";
    else if (value.runtimeType == int)
      return "int";
    else if (value.runtimeType == bool)
      return "bool";
    else if (value.runtimeType == [].runtimeType)
      return determineListType(value);
    else
      return formatClassName(name);
  }

  String formatClassName(String value) =>
      '${value[0].toUpperCase()}${value.substring(1)}';

  String determineListType(List<dynamic> values) {
    if (values.isEmpty) return "List";
    var first = values.first;
    return 'List<${determineTypeString(first)}>';
  }

  String formatClassValue() => '${formatClassName(name)}()';

  String formatListValue(List<dynamic> values) =>
      '[${values.map((val) => type == "List<String>" ? '"$val"' : "$val").join(",")}]';
}
