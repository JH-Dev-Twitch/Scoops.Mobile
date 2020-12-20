import 'package:flutter_test/flutter_test.dart';
import 'package:scoops/core/infrastructure/configuration/config_class_builder.dart';

void main() {
  group('Basic Class Creation', () {
    test('Simple Static Creation', () {
      var builder = ConfigClassBuilder("Config", true);
      var actual = builder.buildClass();
      var containsClassName = contains("class Config {");
      expect(actual, containsClassName);
    });
  });

  group('Basic Field Tests', () {
    test('Simple Static Field - String', () {
      var builder = ConfigClassBuilder("Config", true);
      var actual = builder.importFields({'Test': 'Test'}).buildClass();
      var containsStaticField =
          contains(buildExpectedField(true, "String", "Test", '"Test"'));
      expect(actual, containsStaticField);
    });

    test('Simple Static Field - int', () {
      var builder = ConfigClassBuilder("Config", true);
      var actual = builder.importFields({'Test': 1}).buildClass();
      var containsStaticField =
          contains(buildExpectedField(true, "int", "Test", "1"));
      expect(actual, containsStaticField);
    });

    test('Simple Static Field - bool', () {
      var builder = ConfigClassBuilder("Config", true);
      var actual = builder.importFields({'Test': true}).buildClass();
      var containsStaticField =
          contains(buildExpectedField(true, "bool", "Test", "true"));
      expect(actual, containsStaticField);
    });

    test('Simple Static Field - Array', () {
      var builder = ConfigClassBuilder("Config", true);
      List<dynamic> val = [1, 2, 3];
      var actual = builder.importFields({'Test': val}).buildClass();
      var containsStaticField =
          contains(buildExpectedField(true, "List<int>", "Test", "[1,2,3]"));
      expect(actual, containsStaticField);
    });

    test('Simple Static Field - Object', () {
      var builder = ConfigClassBuilder("Config", true);

      var actual = builder.importFields({
        'Test': {'SubTest': 1}
      }).buildClass();
      var containsSubClass = contains("class Test {");
      var containsField =
          contains(buildExpectedField(false, "int", "SubTest", "1"));

      expect(actual, containsSubClass);
      expect(actual, containsField);
    });

    test('Simple Static Field - Null', () {
      var builder = ConfigClassBuilder("Config", true);
      var actual = builder.importFields({'Test': null}).buildClass();
      expect(actual, contains('class Config {'));
    });
  });
}

String buildExpectedField(
        bool isStatic, String type, String name, String value) =>
    '${isStatic ? "static " : ""}final $type $name = $value;';
