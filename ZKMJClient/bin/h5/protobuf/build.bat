@echo off
e:
cd /Tranning/ProtoBuf/protobuf-python-3.3.0/protobuf-3.3.0/src
protoc -I=F:/Solutions/RemoteSVN/LWH/MJGameServer/protobuf --python_out=F:/Solutions/RemoteSVN/LWH/MJGameServer/protobuf F:/Solutions/RemoteSVN/LWH/MJGameServer/protobuf/*.proto
pause