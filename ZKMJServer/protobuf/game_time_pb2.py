# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: game_time.proto

import sys
_b=sys.version_info[0]<3 and (lambda x:x) or (lambda x:x.encode('latin1'))
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
from google.protobuf import descriptor_pb2
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor.FileDescriptor(
  name='game_time.proto',
  package='',
  syntax='proto2',
  serialized_pb=_b('\n\x0fgame_time.proto\"4\n\x12GameTimeTickNotify\x12\x0f\n\x07nUserID\x18\x01 \x02(\x05\x12\r\n\x05nLeft\x18\x02 \x02(\x05')
)




_GAMETIMETICKNOTIFY = _descriptor.Descriptor(
  name='GameTimeTickNotify',
  full_name='GameTimeTickNotify',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='nUserID', full_name='GameTimeTickNotify.nUserID', index=0,
      number=1, type=5, cpp_type=1, label=2,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='nLeft', full_name='GameTimeTickNotify.nLeft', index=1,
      number=2, type=5, cpp_type=1, label=2,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  options=None,
  is_extendable=False,
  syntax='proto2',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=19,
  serialized_end=71,
)

DESCRIPTOR.message_types_by_name['GameTimeTickNotify'] = _GAMETIMETICKNOTIFY
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

GameTimeTickNotify = _reflection.GeneratedProtocolMessageType('GameTimeTickNotify', (_message.Message,), dict(
  DESCRIPTOR = _GAMETIMETICKNOTIFY,
  __module__ = 'game_time_pb2'
  # @@protoc_insertion_point(class_scope:GameTimeTickNotify)
  ))
_sym_db.RegisterMessage(GameTimeTickNotify)


# @@protoc_insertion_point(module_scope)
