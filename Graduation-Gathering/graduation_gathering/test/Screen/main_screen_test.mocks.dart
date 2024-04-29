// Mocks generated by Mockito 5.4.4 from annotations
// in graduation_gathering/test/Screen/main_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i6;
import 'package:flutter/material.dart' as _i5;
import 'package:graduation_gathering/Auth/auth_token.dart' as _i2;
import 'package:graduation_gathering/Map/main_map_widget.dart' as _i7;
import 'package:graduation_gathering/Map/map_widget.dart' as _i4;
import 'package:graduation_gathering/Map/Zones/grad_zones.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAuthToken_0 extends _i1.SmartFake implements _i2.AuthToken {
  _FakeAuthToken_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGradZones_1 extends _i1.SmartFake implements _i3.GradZones {
  _FakeGradZones_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMapWidgetState_2<E extends _i4.MapWidget> extends _i1.SmartFake
    implements _i4.MapWidgetState<E> {
  _FakeMapWidgetState_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeStatefulElement_3 extends _i1.SmartFake
    implements _i5.StatefulElement {
  _FakeStatefulElement_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeDiagnosticsNode_4 extends _i1.SmartFake
    implements _i5.DiagnosticsNode {
  _FakeDiagnosticsNode_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({
    _i6.TextTreeConfiguration? parentConfiguration,
    _i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.info,
  }) =>
      super.toString();
}

/// A class which mocks [MainMapWidget].
///
/// See the documentation for Mockito's code generation for more information.
class MockMainMapWidget extends _i1.Mock implements _i7.MainMapWidget {
  MockMainMapWidget() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AuthToken get authToken => (super.noSuchMethod(
        Invocation.getter(#authToken),
        returnValue: _FakeAuthToken_0(
          this,
          Invocation.getter(#authToken),
        ),
      ) as _i2.AuthToken);

  @override
  _i3.GradZones get allGradZones => (super.noSuchMethod(
        Invocation.getter(#allGradZones),
        returnValue: _FakeGradZones_1(
          this,
          Invocation.getter(#allGradZones),
        ),
      ) as _i3.GradZones);

  @override
  _i3.GradZones get usersGradZones => (super.noSuchMethod(
        Invocation.getter(#usersGradZones),
        returnValue: _FakeGradZones_1(
          this,
          Invocation.getter(#usersGradZones),
        ),
      ) as _i3.GradZones);

  @override
  _i4.MapWidgetState<_i7.MainMapWidget> createState() => (super.noSuchMethod(
        Invocation.method(
          #createState,
          [],
        ),
        returnValue: _FakeMapWidgetState_2<_i7.MainMapWidget>(
          this,
          Invocation.method(
            #createState,
            [],
          ),
        ),
      ) as _i4.MapWidgetState<_i7.MainMapWidget>);

  @override
  _i5.StatefulElement createElement() => (super.noSuchMethod(
        Invocation.method(
          #createElement,
          [],
        ),
        returnValue: _FakeStatefulElement_3(
          this,
          Invocation.method(
            #createElement,
            [],
          ),
        ),
      ) as _i5.StatefulElement);

  @override
  String toStringShort() => (super.noSuchMethod(
        Invocation.method(
          #toStringShort,
          [],
        ),
        returnValue: _i8.dummyValue<String>(
          this,
          Invocation.method(
            #toStringShort,
            [],
          ),
        ),
      ) as String);

  @override
  void debugFillProperties(_i6.DiagnosticPropertiesBuilder? properties) =>
      super.noSuchMethod(
        Invocation.method(
          #debugFillProperties,
          [properties],
        ),
        returnValueForMissingStub: null,
      );

  @override
  String toStringShallow({
    String? joiner = r', ',
    _i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.debug,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #toStringShallow,
          [],
          {
            #joiner: joiner,
            #minLevel: minLevel,
          },
        ),
        returnValue: _i8.dummyValue<String>(
          this,
          Invocation.method(
            #toStringShallow,
            [],
            {
              #joiner: joiner,
              #minLevel: minLevel,
            },
          ),
        ),
      ) as String);

  @override
  String toStringDeep({
    String? prefixLineOne = r'',
    String? prefixOtherLines,
    _i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.debug,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #toStringDeep,
          [],
          {
            #prefixLineOne: prefixLineOne,
            #prefixOtherLines: prefixOtherLines,
            #minLevel: minLevel,
          },
        ),
        returnValue: _i8.dummyValue<String>(
          this,
          Invocation.method(
            #toStringDeep,
            [],
            {
              #prefixLineOne: prefixLineOne,
              #prefixOtherLines: prefixOtherLines,
              #minLevel: minLevel,
            },
          ),
        ),
      ) as String);

  @override
  _i5.DiagnosticsNode toDiagnosticsNode({
    String? name,
    _i6.DiagnosticsTreeStyle? style,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #toDiagnosticsNode,
          [],
          {
            #name: name,
            #style: style,
          },
        ),
        returnValue: _FakeDiagnosticsNode_4(
          this,
          Invocation.method(
            #toDiagnosticsNode,
            [],
            {
              #name: name,
              #style: style,
            },
          ),
        ),
      ) as _i5.DiagnosticsNode);

  @override
  List<_i5.DiagnosticsNode> debugDescribeChildren() => (super.noSuchMethod(
        Invocation.method(
          #debugDescribeChildren,
          [],
        ),
        returnValue: <_i5.DiagnosticsNode>[],
      ) as List<_i5.DiagnosticsNode>);

  @override
  String toString({_i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.info}) =>
      super.toString();
}