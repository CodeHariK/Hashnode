// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$helloHash() => r'f052a0c65ff2338567add5a08bca2ced488f3fe2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [hello].
@ProviderFor(hello)
const helloProvider = HelloFamily();

/// See also [hello].
class HelloFamily extends Family<String> {
  /// See also [hello].
  const HelloFamily();

  /// See also [hello].
  HelloProvider call(
    String person,
  ) {
    return HelloProvider(
      person,
    );
  }

  @override
  HelloProvider getProviderOverride(
    covariant HelloProvider provider,
  ) {
    return call(
      provider.person,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'helloProvider';
}

/// See also [hello].
class HelloProvider extends AutoDisposeProvider<String> {
  /// See also [hello].
  HelloProvider(
    String person,
  ) : this._internal(
          (ref) => hello(
            ref as HelloRef,
            person,
          ),
          from: helloProvider,
          name: r'helloProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$helloHash,
          dependencies: HelloFamily._dependencies,
          allTransitiveDependencies: HelloFamily._allTransitiveDependencies,
          person: person,
        );

  HelloProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.person,
  }) : super.internal();

  final String person;

  @override
  Override overrideWith(
    String Function(HelloRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HelloProvider._internal(
        (ref) => create(ref as HelloRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        person: person,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _HelloProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HelloProvider && other.person == person;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, person.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HelloRef on AutoDisposeProviderRef<String> {
  /// The parameter `person` of this provider.
  String get person;
}

class _HelloProviderElement extends AutoDisposeProviderElement<String>
    with HelloRef {
  _HelloProviderElement(super.provider);

  @override
  String get person => (origin as HelloProvider).person;
}

String _$futureHelloHash() => r'a8cb30784280d3ca41801ac240691594ae87284a';

/// See also [futureHello].
@ProviderFor(futureHello)
final futureHelloProvider = AutoDisposeFutureProvider<int>.internal(
  futureHello,
  name: r'futureHelloProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$futureHelloHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FutureHelloRef = AutoDisposeFutureProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
