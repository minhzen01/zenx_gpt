// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class MessageRealm extends _MessageRealm
    with RealmEntity, RealmObjectBase, RealmObject {
  MessageRealm(
    String msg,
    int msgType,
    bool complete,
    int dateTime,
  ) {
    RealmObjectBase.set(this, 'msg', msg);
    RealmObjectBase.set(this, 'msgType', msgType);
    RealmObjectBase.set(this, 'complete', complete);
    RealmObjectBase.set(this, 'dateTime', dateTime);
  }

  MessageRealm._();

  @override
  String get msg => RealmObjectBase.get<String>(this, 'msg') as String;
  @override
  set msg(String value) => RealmObjectBase.set(this, 'msg', value);

  @override
  int get msgType => RealmObjectBase.get<int>(this, 'msgType') as int;
  @override
  set msgType(int value) => RealmObjectBase.set(this, 'msgType', value);

  @override
  bool get complete => RealmObjectBase.get<bool>(this, 'complete') as bool;
  @override
  set complete(bool value) => RealmObjectBase.set(this, 'complete', value);

  @override
  int get dateTime => RealmObjectBase.get<int>(this, 'dateTime') as int;
  @override
  set dateTime(int value) => RealmObjectBase.set(this, 'dateTime', value);

  @override
  Stream<RealmObjectChanges<MessageRealm>> get changes =>
      RealmObjectBase.getChanges<MessageRealm>(this);

  @override
  MessageRealm freeze() => RealmObjectBase.freezeObject<MessageRealm>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(MessageRealm._);
    return const SchemaObject(
        ObjectType.realmObject, MessageRealm, 'MessageRealm', [
      SchemaProperty('msg', RealmPropertyType.string),
      SchemaProperty('msgType', RealmPropertyType.int),
      SchemaProperty('complete', RealmPropertyType.bool),
      SchemaProperty('dateTime', RealmPropertyType.int, primaryKey: true),
    ]);
  }
}
