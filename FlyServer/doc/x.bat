set ConfigPath=..\..\FlyServer\scripts\����
set ClientConfigPath=..\..\Flying3D\scripts\����
for %%a in (
	��ͼ
	����
	ˢ��
	����
	������Ϣ
	Npc
	����
	��Ʒ
	�������
	Buff
	����
	����
	�̳�
	��Ʒ�ڹ�
	��ֵ���
	�����
	�����齱
	��װ
	��Ʒʹ��
)do (
unzip -j -o "%%a.xlsx" xl\sharedStrings.xml xl\workbook.xml xl\worksheets\sheet*.xml
myxml "%ConfigPath%/%%~na��.lua"
)
for %%a in (
	��ͼ
	ˢ��
	����
	�̳�
	��Ʒ�ڹ�
	��ֵ���
	�����
	�����齱
	��Ʒʹ��
)do (
copy %ConfigPath%\%%~na��.lua %ClientConfigPath%\%%~na��.lua
)
del *.xml
