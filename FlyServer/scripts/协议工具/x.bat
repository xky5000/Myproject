set serverPath=..\..\..\FlyServer\scripts
set clientPath=..\..\..\Flying3D\scripts\����

::TortoiseProc.exe /command:update /path:"%serverPath%\common\PacketID.lua" /closeonend:2
::TortoiseProc.exe /command:update /path:"%clientPath%\" /closeonend:2

SET names=Э��,����,���,����,����,��Ʒ,����,����,����,����,���а�,����,����,�л�

call :ServerToClient ��� ����
call :ServerToClient ���� ����
call :ServerToClient ���� ����
call :ServerToClient ��Ʒ ��Ʒ
call :ServerToClient ���� ����
call :ServerToClient ���� ����
call :ServerToClient ���� ����
call :ServerToClient ���� ����
call :ServerToClient ���а� ���а�
call :ServerToClient ���� ����
call :ServerToClient ���� ����
call :ServerToClient �л� �л�

��Ϣ����.lua
copy Message.lua %clientPath%\��Ϣ.lua
copy %serverPath%\����\Э��ID.lua PacketID.lua
��Ϣ��������.lua PacketID %clientPath%\��Ϣ����.lua
del Message.lua
del CGMethod.lua
del PacketID.lua

rem TortoiseProc.exe /command:commit /path:"%serverPath%\common\PacketID.lua" /logmsg:"��������������Э��id����" /closeonend:2
rem TortoiseProc.exe /command:add /path:"%clientPath%\" /logmsg:"���������ͻ���Э�����" /closeonend:2
rem TortoiseProc.exe /command:commit /path:"%clientPath%\" /logmsg:"���������ͻ���Э�����" /closeonend:2

exit/b

:ServerToClient
	Э������.lua %serverPath%\ģ��\?.lua %1 %2 %names% "��Ϣ����.lua"
	��Ϣ����ϲ�.lua %clientPath%\��Ϣ����\%2��Ϣ����.lua %2��Ϣ����.lua %clientPath%\��Ϣ����\%2��Ϣ����.lua
	del %2��Ϣ����.lua
exit/b
